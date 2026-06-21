##../venn
@implement+=
function M.gen(opts)
  local c = charset[table.concat(opts, "")]
  if c and M.active_decor then
    local map = decorations[M.active_decor]
    if map and map[c] then
      c = map[c]
    end
  end
  return c
end
