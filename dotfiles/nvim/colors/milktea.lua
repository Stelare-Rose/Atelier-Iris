vim.cmd("highlight clear")
if vim.fn.exists("syntax_on") == 1 then vim.cmd("syntax reset") end
vim.g.colors_name = "milktea"

local p = require("milktea.palette")

local set = vim.api.nvim_set_hl

-- Normal
set(0, "Normal",       { fg = p.text })
set(0, "Identifier", { fg = p.text })
set(0, "Function",   { fg = p.blueberry })
set(0, "Statement",  { fg = p.plum })
set(0, "Keyword",    { fg = p.plum })
set(0, "Type",       { fg = p.lemon })
set(0, "Special",    { fg = p.pink })
set(0, "Constant",   { fg = p.orange })
set(0, "String",     { fg = p.leaf })
set(0, "Comment",    { fg = p.subtext2, italic = true })
set(0, "PreProc",    { fg = p.plum })
set(0, "Delimiter",  { fg = p.subtext1 })
set(0, "NormalFloat",  { fg = p.text })
set(0, "FloatBorder",  { fg = p.sky })
set(0, "FloatTitle",   { fg = p.sky })

-- @variable
set(0, "@variable", { fg = p.lilac })
set(0, "@variable.builtin", { fg = p.plum, italic = true })
set(0, "@variable.member", { fg = p.lavender })

-- @constant
set(0, "@constant", { fg = p.orange })
set(0, "@constant.builtin", { fg = p.orange, bold = true })

-- @string
set(0, "@string", { fg = p.leaf })
set(0, "@string.escape", { fg = p.mint })
set(0, "@string.regexp", { fg = p.mint })

-- @number / @boolean
set(0, "@number", { fg = p.orange })
set(0, "@number.float", { fg = p.orange })
set(0, "@boolean", { fg = p.orange })

-- @function
set(0, "@function", { fg = p.blueberry })
set(0, "@function.call", { fg = p.blueberry })
set(0, "@function.method", { fg = p.blueberry })
set(0, "@function.method.call", { fg = p.blueberry })

-- @keyword
set(0, "@keyword", { fg = p.plum })
set(0, "@keyword.function", { fg = p.plum })
set(0, "@keyword.return", { fg = p.strawberry })
set(0, "@keyword.import", { fg = p.plum })
set(0, "@keyword.conditional", { fg = p.plum })
set(0, "@keyword.repeat", { fg = p.plum })
set(0, "@keyword.exception", { fg = p.strawberry })

-- @type
set(0, "@type", { fg = p.lemon })
set(0, "@type.builtin", { fg = p.lemon, italic = true })

-- @operator / @punctuation
set(0, "@operator", { fg = p.text })
set(0, "@punctuation.delimiter", { fg = p.subtext1 })
set(0, "@punctuation.bracket", { fg = p.subtext1 })

-- @comment
set(0, "@comment", { fg = p.subtext2, italic = true })
set(0, "@comment.todo", { fg = p.lemon, bold = true })
set(0, "@comment.error", { fg = p.strawberry, bold = true })
set(0, "@comment.warning", { fg = p.orange, bold = true })

-- @attribute
set(0, "@attribute", { fg = p.pink })

-- base menu
set(0, "Pmenu",       { fg = p.text,     bg = p.cream })
set(0, "PmenuSel",    { fg = p.foam,     bg = p.grape })  -- selected item
set(0, "PmenuSbar",   {                  bg = p.base })        -- scrollbar
set(0, "PmenuThumb",  {                  bg = p.subtext2 })    -- scrollbar thumb
set(0, "PmenuBorder", { fg = p.sky })

-- the popup border and title
set(0, "NoiceCmdlinePopupBorder",      { fg = p.leaf })
set(0, "NoiceCmdlinePopupTitle",       { fg = p.leaf })

-- the popup background
set(0, "NoiceCmdlinePopup",            { fg = p.text, bg = "NONE" })

-- the icon/prompt (the > symbol)
set(0, "NoiceCmdlineIcon",             { fg = p.plum })

-- the cursor block in the cmdline
set(0, "NoiceCmdlineCursor",           { bg = p.plum })

-- Buffer
set(0, "EndOfBuffer", { fg = p.foam, bg = "NONE" })
