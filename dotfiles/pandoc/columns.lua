function Pandoc(doc)
  local n = nil
  local v = doc.meta["columns"]
 
  if v ~= nil then
    local s = pandoc.utils.stringify(v)
    n = tonumber(s)
  end
 
  if n ~= nil and n >= 2 then
    n = math.floor(n)
    table.insert(doc.blocks, 1, pandoc.RawBlock("latex", "\\begin{multicols}{" .. n .. "}"))
    table.insert(doc.blocks, pandoc.RawBlock("latex", "\\end{multicols}"))
  end
 
  return doc
end
 

