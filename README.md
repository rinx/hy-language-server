hy-language-server
===

[![PyPI version](https://badge.fury.io/py/hy-language-server.svg)](https://pypi.org/project/hy-language-server)

[Hy](https://github.com/hylang/hy) Language Server built using [pygls](https://github.com/openlawlibrary/pygls) and [Jedhy](https://github.com/ekaschalk/jedhy).

## Supported Features

Note: Currently, these features are available only for Hy's built-in core functions.

- `textDocument/completion`
- `textDocument/hover`

![hyls-with-nvim-example](https://user-images.githubusercontent.com/1588935/117307829-e2ac6b80-aebb-11eb-9d93-ab6087959d03.gif)

## Installation

```sh
pip install hy-language-server
```

`hyls` will be installed under your PATH.

If you are using Hy 1.0a1, please install the latest main branch.

```sh
pip install git+https://github.com/rinx/jedhy.git@update/hy-1.0a1
pip install git+https://github.com/rinx/hy-language-server.git
```

## license

MIT
