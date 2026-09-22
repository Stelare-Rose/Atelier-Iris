local black_and_white = false

local read_meta = {
  Meta = function(meta)
    local v = meta["black-and-white"]
    if v == true then
      black_and_white = true
    elseif v ~= nil and type(v) ~= "boolean" and pandoc.utils.stringify then
      local s = pandoc.utils.stringify(v):lower()
      black_and_white = (s == "true")
    end
    return meta
  end
}

local apply_codeblock_style = {
  CodeBlock = function(block)
    if black_and_white then
      return block
    end

    if #block.classes == 0 then
      block.classes = {"default"}
    end
    return block
  end
}

return { read_meta, apply_codeblock_style }
