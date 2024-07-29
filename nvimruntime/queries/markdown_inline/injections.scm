;; extends
(
  (inline)
  @injection.content
  (#vim-match? @injection.content "^[a-zA-Z][a-zA-Z0-9]*:\/\/\\S\+$")
  (#set! injection.language "uri")
)
