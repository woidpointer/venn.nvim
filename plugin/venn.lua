-- to have a clean 100% lua statistics in Github ;) I know it's perfectionism
vim.cmd [[command! -range VBox lua require"venn".draw_box("s")]]
vim.cmd [[command! -range VBoxD lua require"venn".draw_box("d")]]
vim.cmd [[command! -range VBoxH lua require"venn".draw_box("b")]]
vim.cmd [[command! -range VBoxR lua require"venn".draw_box("rounded")]]
vim.cmd [[command! -range VBoxDa lua require"venn".draw_box("dashed")]]
vim.cmd [[command! -range VBoxHDa lua require"venn".draw_box("dashed_heavy")]]

vim.cmd [[command! -range VBoxO lua require"venn".draw_box_over("s")]]
vim.cmd [[command! -range VBoxDO lua require"venn".draw_box_over("d")]]
vim.cmd [[command! -range VBoxHO lua require"venn".draw_box_over("b")]]
vim.cmd [[command! -range VBoxRO lua require"venn".draw_box_over("rounded")]]
vim.cmd [[command! -range VBoxDaO lua require"venn".draw_box_over("dashed")]]
vim.cmd [[command! -range VBoxHDaO lua require"venn".draw_box_over("dashed_heavy")]]

-- draw using the currently selected style (see :VStyle / require"venn".set_style)
vim.cmd [[command! -range VBoxC lua require"venn".draw_box()]]
vim.cmd [[command! -range VBoxCO lua require"venn".draw_box_over()]]

-- :VStyle <name> sets the style, :VStyle with no argument cycles to the next one
vim.cmd [[command! -nargs=? VStyle lua local v=require"venn" if <q-args> ~= "" then v.set_style(<q-args>) else v.cycle_style() end]]

vim.cmd [[command! -range VFill lua require"venn".fill_box()]]
