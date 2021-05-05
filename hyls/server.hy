(require [hy.contrib.walk [let]])

(import logging)
(import re)
(import [jedhy.api [API]])
(import [pygls.lsp.methods [COMPLETION
                            HOVER
                            TEXT_DOCUMENT_DID_CHANGE
                            TEXT_DOCUMENT_DID_CLOSE
                            TEXT_DOCUMENT_DID_OPEN]])
(import [pygls.lsp.types [CompletionItem
                          CompletionList
                          CompletionOptions
                          CompletionParams
                          Hover
                          MarkupContent
                          MarkupKind]])
(import [pygls.server [LanguageServer]])

(setv logger (logging.getLogger "hyls.server"))

(defn cursor-line [ls uri ln]
  (let [doc (ls.workspace.get_document uri)
        content doc.source
        lines (content.split "\n")]
    (get lines ln)))

(defn cursor-word [ls uri ln cn]
  (let [line (cursor-line ls uri ln)]
    (for [m (re.finditer r"[\.\?a-zA-Z0-9_]+" line)]
      (when (and (<= (m.start) cn) (<= cn (m.end)))
        (return (cut line (m.start) cn))))))

(defn cursor-word-all [ls uri ln cn]
  (let [line (cursor-line ls uri ln)]
    (for [m (re.finditer r"[\.\?a-zA-Z0-9_]+" line)]
      (when (and (<= (m.start) cn) (<= cn (m.end)))
        (return (cut line (m.start) (m.end)))))))

(defclass Server []
  (defn --init-- [self]
    (setv self.server (LanguageServer))
    (setv self.jedhy (API))

    (with-decorator
      (self.server.feature
        COMPLETION
        (CompletionOptions))
      (defn completions [params]
        (let [word (cursor-word self.server
                                params.text_document.uri
                                params.position.line
                                params.position.character)]
          (setv complist (CompletionList
                           :is_incomplete False
                           :items []))
          (when (not (none? word))
            (for [candidate (self.jedhy.complete word)]
              (complist.add_item (CompletionItem :label candidate))))
          complist)))
    (with-decorator
      (self.server.feature HOVER)
      (defn hover [params]
        (let [word (cursor-word-all self.server
                                    params.text_document.uri
                                    params.position.line
                                    params.position.character)]
          (when (not (none? word))
            (let [docs (self.jedhy.docs word)]
              (when (!= docs "")
                (Hover
                  :contents (MarkupContent
                              :kind MarkupKind.PlainText
                              :value docs))))))))
    (with-decorator
      (self.server.feature TEXT_DOCUMENT_DID_OPEN)
      (defn did-open [params]
        None))
    (with-decorator
      (self.server.feature TEXT_DOCUMENT_DID_CLOSE)
      (defn did-close [params]
        None))
    (with-decorator
      (self.server.feature TEXT_DOCUMENT_DID_CHANGE)
      (defn did-change [params]
        None)))
  (defn start [self]
    (self.server.start_io)))
