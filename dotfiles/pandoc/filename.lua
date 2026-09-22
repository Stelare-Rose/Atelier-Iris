-- Sets the document title from the source filename (minus extension),
-- unless an explicit title is already set in YAML frontmatter.
 
function Pandoc(doc)
  if doc.meta.title then
    -- Respect an explicit title if one is already set in YAML frontmatter
    return doc
  end
 
  local path = PANDOC_STATE.input_files[1]
  if path then
    local filename = path:match("([^/\\]+)$")          -- strip directory
    local name_no_ext = filename:match("(.+)%..+$") or filename  -- strip extension
    doc.meta.title = pandoc.MetaInlines({ pandoc.Str(name_no_ext) })
  end
 
  return doc
end

