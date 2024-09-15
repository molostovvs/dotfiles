((
  (raw_string_literal) @constant
  (#match? @constant "(SELECT|select|insert|INSERT).*")
)@injection.content (#set! injection.language "sql"))
