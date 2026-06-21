##../venn
@implement+=
function M.set_line(opts, new_char)
  charset[table.concat(opts, "")] = new_char
end

function M.set_arrow(dir, new_char)
  if dir == "up" then
    arrow_chars.up = new_char
  elseif dir == "down" then
    arrow_chars.down = new_char
  elseif dir == "left" then
    arrow_chars.left = new_char
  elseif dir == "right" then
    arrow_chars.right = new_char
  else
    print(("venn.nvim: unknown dir for arrow %s!"):format(dir))
  end
end

@implement+=
-- style used by draw functions when no explicit style is passed
M.current_style = "single"

function M.resolve_style(name)
  local s = styles[name]
  if not s then
    return "s", nil
  end
  return s[1], s[2]
end

function M.set_style(name)
  if not styles[name] then
    print(("venn.nvim: unknown line style %s!"):format(tostring(name)))
    return M.current_style
  end
  M.current_style = name
  print("venn.nvim: line style = " .. name)
  return M.current_style
end

function M.get_style()
  return M.current_style
end

function M.list_styles()
  return vim.deepcopy(style_cycle)
end

function M.cycle_style()
  local idx = 0
  for i, name in ipairs(style_cycle) do
    if name == M.current_style then
      idx = i
      break
    end
  end
  idx = idx % #style_cycle + 1
  return M.set_style(style_cycle[idx])
end
