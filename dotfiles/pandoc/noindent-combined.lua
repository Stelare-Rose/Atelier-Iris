-- Suppresses paragraph indentation in these cases:
--   1. A paragraph immediately following a code block (always, regardless
--      of sentence count).
--   2. Any single-sentence paragraph, anywhere in the document.
--
-- Sentence count is approximated by counting sentence-ending punctuation
-- (. ! ?) followed by a space/end and an uppercase letter or nothing --
-- a heuristic that can misfire on abbreviations (Mr., Dr., e.g., etc.),
-- since true sentence segmentation isn't possible with regex alone.

local function count_sentences(text)
  local count = 0
  for punct, next_char in text:gmatch("([.!?])%s*(%a?)") do
    if next_char == "" or next_char:match("%u") then
      count = count + 1
    end
  end
  return count
end

function Pandoc(doc)
  local blocks = doc.blocks
  local n = #blocks

  for i, block in ipairs(blocks) do
    if block.t == "Para" then
      local prev_is_codeblock = (i > 1) and (blocks[i-1].t == "CodeBlock")

      local should_noindent = false

      if prev_is_codeblock then
        should_noindent = true
      else
        local text = pandoc.utils.stringify(block)
        if count_sentences(text) <= 1 then
          should_noindent = true
        end
      end

      if should_noindent then
        table.insert(block.content, 1, pandoc.RawInline("latex", "\\noindent "))
      end
    end
  end

  return doc
end
