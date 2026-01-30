-- Lua filter to convert <br> tags to proper line breaks in LaTeX output
-- and allow inline code to wrap in tables

function RawInline(elem)
  if elem.format == "html" and elem.text:match("^<br%s*/?>$") then
    if FORMAT:match("latex") or FORMAT:match("pdf") then
      return pandoc.RawInline("latex", "\\newline ")
    end
  end
end

-- Allow inline code to break at certain characters in LaTeX
function Code(elem)
  if FORMAT:match("latex") or FORMAT:match("pdf") then
    -- Allow breaks after underscores, dots, parens, and commas
    local text = elem.text
    -- Escape LaTeX special characters first
    text = text:gsub("\\", "\\textbackslash{}")
    text = text:gsub("%%", "\\%%")
    text = text:gsub("%$", "\\$")
    text = text:gsub("%&", "\\&")
    text = text:gsub("#", "\\#")
    text = text:gsub("{", "\\{")
    text = text:gsub("}", "\\}")
    text = text:gsub("%^", "\\textasciicircum{}")
    text = text:gsub("~", "\\textasciitilde{}")
    -- Now add break points
    text = text:gsub("_", "\\_\\allowbreak{}")
    text = text:gsub("%.", ".\\allowbreak{}")
    text = text:gsub("%(", "(\\allowbreak{}")
    text = text:gsub(",", ",\\allowbreak{}")
    return pandoc.RawInline("latex", "\\texttt{" .. text .. "}")
  end
end
