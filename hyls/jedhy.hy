(require [hy.contrib.walk [let]])
(import hy)

(defclass Jedhy []
  (defn --init-- [self jedhy &optional logger]
    (setv self.jedhy jedhy)
    (setv self.logger logger))
  (defn refresh-ns [self __imports__]
    (for [__i__ __imports__]
      (self.logger.info (+ "import/require: " __i__))
      (try
        (-> __i__
            (read-str)
            (eval))
        (except [e BaseException]
          (self.logger.info (+ "import/require failed: " (repr e))))))
    (self.jedhy.set-namespace :locals- (locals)
                              :globals- (globals)
                              :macros- --macros--))
  (defn complete [self prefix-str]
    (self.jedhy.complete prefix-str))
  (defn docs [self candidate-str]
    (self.jedhy.docs candidate-str)))
