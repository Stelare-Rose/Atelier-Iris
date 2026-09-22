function Pandoc(doc)
  local skip = doc.meta["skip-links"]
  if skip == nil then
    return doc
  end

  local skip_str = pandoc.utils.stringify(skip)
  if skip_str ~= "true" then
    return doc
  end

  return doc:walk({
    Link = function(el)
      return {}
    end
  })
end
