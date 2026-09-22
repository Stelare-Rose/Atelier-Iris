function Pandoc(doc)
  local skip = doc.meta["skip-title"]
  if skip == nil then
    return doc
  end

  local skip_str = pandoc.utils.stringify(skip)
  if skip_str == "true" then
    doc.meta.title = nil
    doc.meta.subtitle = nil
  end

  return doc
end

