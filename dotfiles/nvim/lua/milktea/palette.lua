local accents = {
  light = {
    strawberry = "#bc6262",
    orange     = "#c48f4b",
    lemon      = "#d6bf6d",
    leaf       = "#8cb372",
    mint       = "#77bf8f",
    sky        = "#77bbd0",
    blueberry  = "#8099d1",
    grape      = "#7c78c2",
    plum       = "#917bc3",
    lavender   = "#bd89c9",
    lilac      = "#d38ec5",
    pink       = "#f09bb8",
  },
  dark = {
    strawberry = "#cf8282",
    orange     = "#d4a266",
    lemon      = "#e3cd7f",
    leaf       = "#9ccc96",
    mint       = "#99cfac",
    sky        = "#90cdde",
    blueberry  = "#9bb0de",
    grape      = "#9b98d6",
    plum       = "#aa99d1",
    lavender   = "#cca3d6",
    lilac      = "#dbb4d3",
    pink       = "#edb7ca",
  },
}

local neutrals = {
  light = {
    foam      = "#f7f4e9",
    cream     = "#f0e8da",
    base      = "#e6d9c8",
    tea       = "#decec1",
    subtext2  = "#8a7a72",
    subtext1  = "#4f453f",
    text      = "#38312d",
    highlight = "#302821",
  },
  dark = {
    foam      = "#6b564b",
    cream     = "#4f453f",
    base      = "#403732",
    tea       = "#383029",
    subtext2  = "#a8988c",
    subtext1  = "#e6d9c8",
    text      = "#f0e8da",
    highlight = "#f8f4e9",
  },
}

return function()
  local mode = vim.o.background == "dark" and "dark" or "light"
  return vim.tbl_extend("force", neutrals[mode], accents[mode])
end
