local p = require("milktea.palette")
local theme = {
  normal = {
    a = { fg = p.foam, bg = p.strawberry, gui = "bold" },
    b = { fg = p.cream, bg = p.orange },
    c = { fg = p.tea, bg = p.tea },
    x = { fg = p.cream, bg = p.blueberry, gui = "bold" },
    y = { fg = p.cream, bg = p.grape },
    z = { fg = p.foam, bg = p.lilac, gui = "bold" },
  },
  insert   = { a = { fg = p.foam, bg = p.leaf,       gui = "bold" } },
  visual   = { a = { fg = p.foam, bg = p.plum,       gui = "bold" } },
  replace  = { a = { fg = p.foam, bg = p.strawberry, gui = "bold" } },
  inactive = { a = { fg = p.subtext2, bg = 'NONE' } },
}
return theme
