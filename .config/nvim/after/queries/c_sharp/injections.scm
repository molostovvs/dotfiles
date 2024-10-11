; extends

; var x = "str";
(
(comment) @comment
.
(_
  (_
    (_
      (_
        (string_literal_content) @injection.content))))

(#eq? @comment "//language=sql")
(#set! injection.language "sql")
)

; fallback
(
  [
    (string_literal_content)
    (raw_string_content)
  ] @injection.content
  (#match? @injection.content "(SELECT|select|INSERT|insert|UPDATE|update|DELETE|delete|UPSERT|upsert|DECLARE|declare).+(FROM|from|INTO|into|VALUES|values|SET|set).*(WHERE|where|GROUP BY|group by)?")
  (#set! injection.language "sql")
)
