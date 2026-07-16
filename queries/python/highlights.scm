; extends
; NOTE: python-only keyword captures for per-keyword styling.

[
  "import"
  "from"
  "as"
] @keyword.import

[
  "def"
  "lambda"
] @keyword.function

"class" @keyword.type

[
  "return"
  "yield"
] @keyword.return

[
  "if"
  "elif"
  "else"
  "match"
  "case"
] @keyword.conditional

[
  "for"
  "while"
  "break"
  "continue"
] @keyword.repeat

[
  "try"
  "except"
  "finally"
  "raise"
  "assert"
] @keyword.exception

[
  "async"
  "await"
] @keyword.coroutine

[
  "and"
  "or"
  "not"
  "in"
  "is"
] @keyword.operator

[
  "global"
  "nonlocal"
] @keyword.scope
