##../venn
@implement+=
function M.parse(sym)
  sym = undecorate[sym] or sym
  for opt, c in pairs(charset) do
    if c == sym then
      return vim.split(opt, "")
    end
  end

  if sym == arrow_chars.up then
    return {" ", "s", " ", " "}
  elseif sym == arrow_chars.down then
    return {"s", " ", " ", " "}
  elseif sym == arrow_chars.left then
    return {" ", " ", " ", "s"}
  elseif sym == arrow_chars.right then
    return {" ", " ", "s", " "}
  end
end

@script_variables+=
local charset = {
  -- [ up down left right ] = char
  --      s : single
  --      d : double
  --      b : bold
  ["    "] = " ",
  ["ss  "] = "│",
  ["sss "] = "┤",
  ["ssd "] = "╡",
  ["dds "] = "╢",
  [" ds "] = "╖",
  [" sd "] = "╕",
  ["ddd "] = "╣",
  ["dd  "] = "║",
  [" dd "] = "╗",
  ["d d "] = "╝",
  ["d s "] = "╜",
  ["s d "] = "╛",
  [" ss "] = "┐",
  ["s  s"] = "└",
  ["s ss"] = "┴",
  [" sss"] = "┬",
  ["ss s"] = "├",
  ["  ss"] = "─",
  ["ssss"] = "┼",
  ["ss d"] = "╞",
  ["dd s"] = "╟",
  ["d  d"] = "╚",
  [" d d"] = "╔",
  ["d dd"] = "╩",
  [" ddd"] = "╦",
  ["dd d"] = "╠",
  ["  dd"] = "═",
  ["dddd"] = "╬",
  ["s dd"] = "╧",
  ["d ss"] = "╨",
  [" sdd"] = "╤",
  [" dss"] = "╥",
  ["d  s"] = "╙",
  ["s  d"] = "╘",
  [" s d"] = "╒",
  [" d s"] = "╓",
  ["ddss"] = "╫",
  ["ssdd"] = "╪",
  ["s s "] = "┘",
  [" s s"] = "┌",
  [" s b"] = "┍",
  [" b s"] = "┎",
  [" b s"] = "┎",
  [" b b"] = "┏",
  [" sb "] = "┑",
  [" bs "] = "┒",
  [" bb "] = "┓",
  ["s  b"] = "┕",
  ["b  s"] = "┖",
  ["b  b"] = "┗",
  ["s b "] = "┙",
  ["b s "] = "┚",
  ["b b "] = "┛",
  ["ss b"] = "┝",
  ["bs s"] = "┞",
  ["sb s"] = "┟",
  ["bb s"] = "┠",
  ["bs b"] = "┡",
  ["sb b"] = "┢",
  ["bb b"] = "┣",
  ["ssb "] = "┥",
  ["bss "] = "┦",
  ["sbs "] = "┧",
  ["bbs "] = "┨",
  ["bsb "] = "┩",
  ["sbb "] = "┪",
  ["bbb "] = "┫",
  [" sbs"] = "┭",
  [" ssb"] = "┮",
  [" sbb"] = "┯",
  [" bss"] = "┰",
  [" bbs"] = "┱",
  [" bsb"] = "┲",
  [" bbb"] = "┳",
  ["s bs"] = "┵",
  ["s sb"] = "┶",
  ["s bb"] = "┷",
  ["b ss"] = "┸",
  ["b bs"] = "┹",
  ["b sb"] = "┺",
  ["b bb"] = "┻",
  ["ssbs"] = "┽",
  ["sssb"] = "┾",
  ["ssbb"] = "┿",
  ["bsss"] = "╀",
  ["sbss"] = "╁",
  ["bbss"] = "╂",
  ["bsbs"] = "╃",
  ["bssb"] = "╄",
  ["sbbs"] = "╅",
  ["sbsb"] = "╆",
  ["bsbb"] = "╇",
  ["sbbb"] = "╈",
  ["bbbs"] = "╉",
  ["bbsb"] = "╊",
  ["bbbb"] = "╋",
  ["bb  "] = "┃",
  ["  bb"] = "━",
  ["  bb"] = "━",
}

@script_variables+=
-- decorations are applied on top of a freshly generated glyph.
-- only straight runs (dashed) and the four outer corners (rounded)
-- have dedicated glyphs, junctions keep their solid form.
local decorations = {
  rounded = {
    ["┌"] = "╭", ["┐"] = "╮", ["└"] = "╰", ["┘"] = "╯",
  },
  dashed = {
    ["─"] = "┄", ["│"] = "┆",
  },
  dashed_heavy = {
    ["━"] = "┅", ["┃"] = "┊",
  },
}

-- reverse lookup so M.parse can recognise an already decorated glyph
local undecorate = {}
for _, map in pairs(decorations) do
  for base, deco in pairs(map) do
    undecorate[deco] = base
  end
end

-- style name -> { join code (s/d/b), optional decoration }
local styles = {
  ["s"]            = { "s" },
  ["single"]       = { "s" },
  ["light"]        = { "s" },
  ["d"]            = { "d" },
  ["double"]       = { "d" },
  ["b"]            = { "b" },
  ["bold"]         = { "b" },
  ["heavy"]        = { "b" },
  ["r"]            = { "s", "rounded" },
  ["rounded"]      = { "s", "rounded" },
  ["ds"]           = { "s", "dashed" },
  ["dashed"]       = { "s", "dashed" },
  ["db"]           = { "b", "dashed_heavy" },
  ["dashed_heavy"] = { "b", "dashed_heavy" },
  ["heavy_dashed"] = { "b", "dashed_heavy" },
}

-- order used by M.cycle_style
local style_cycle = { "single", "double", "heavy", "rounded", "dashed", "dashed_heavy" }
