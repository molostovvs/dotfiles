;; extends

; fallback
(
  [
    (string_literal_content)
    (raw_string_content)
  ] @injection.content
  (#match? @injection.content "(SELECT|select|INSERT|insert|UPDATE|update|DELETE|delete|UPSERT|upsert|DECLARE|declare).+(FROM|from|INTO|into|VALUES|values|SET|set).*(WHERE|where|GROUP BY|group by)?")
  (#set! injection.language "sql")
)

