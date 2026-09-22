-- Builds a subtitle from the note's `type` and `domain` frontmatter
-- properties, optionally appending a `custom-subtitle` property on its
-- own line beneath, and sets the result as the document subtitle.

local function meta_to_string(val)
  if val == nil then return nil end
  if type(val) == "string" then return val end
  return pandoc.utils.stringify(val)
end

local function domain_to_string(domain_meta)
  if domain_meta == nil then return nil end

  if type(domain_meta) == "table" and domain_meta[1] ~= nil and type(domain_meta[1]) == "table" then
    local parts = {}
    for _, item in ipairs(domain_meta) do
      table.insert(parts, pandoc.utils.stringify(item))
    end
    return table.concat(parts, ", ")
  else
    return pandoc.utils.stringify(domain_meta)
  end
end

local function capitalize(s)
  if s == nil then return nil end
  return s:sub(1,1):upper() .. s:sub(2)
end

function Pandoc(doc)
  if doc.meta.subtitle then
    return doc
  end

  local type_str = capitalize(meta_to_string(doc.meta.type))
  local domain_str = domain_to_string(doc.meta.domain)
  local custom_str = meta_to_string(doc.meta["custom"])

  local parts = {}
  if type_str then table.insert(parts, type_str) end
  if domain_str then table.insert(parts, domain_str) end

  local first_line = table.concat(parts, " · ")

  local lines = {}
  if first_line ~= "" then table.insert(lines, first_line) end
  if custom_str then table.insert(lines, custom_str) end

  if #lines == 0 then
    return doc
  end

  local subtitle_latex = table.concat(lines, "\\\\[0.15em]")

  doc.meta.subtitle = pandoc.MetaInlines({ pandoc.RawInline("latex", subtitle_latex) })

  return doc
end
