local sexp_filetypes = "clojure,scheme,lisp,timl,fennel"
local sexp_mappings = {sexp_outer_list = "af", sexp_inner_list = "if", sexp_outer_top_list = "aF", sexp_inner_top_list = "iF", sexp_outer_string = "as", sexp_inner_string = "is", sexp_outer_element = "ae", sexp_inner_element = "ie", sexp_move_to_prev_bracket = "(", sexp_move_to_next_bracket = ")", sexp_move_to_prev_element_head = "<M-b>", sexp_move_to_next_element_head = "<M-w>", sexp_move_to_prev_element_tail = "g<M-e>", sexp_move_to_next_element_tail = "<M-e>", sexp_flow_to_prev_close = "<M-[>", sexp_flow_to_next_open = "<M-]>", sexp_flow_to_prev_open = "<M-{>", sexp_flow_to_next_close = "<M-}>", sexp_flow_to_prev_leaf_head = "<M-S-b>", sexp_flow_to_next_leaf_head = "<M-S-w>", sexp_flow_to_prev_leaf_tail = "<M-S-g>", sexp_flow_to_next_leaf_tail = "<M-S-e>", sexp_move_to_prev_top_element = "[[", sexp_move_to_next_top_element = "]]", sexp_select_prev_element = "[e", sexp_select_next_element = "]e", sexp_indent = "==", sexp_indent_top = "=-", sexp_round_head_wrap_list = "<LocalLeader>i", sexp_round_tail_wrap_list = "<LocalLeader>I", sexp_square_head_wrap_list = "<LocalLeader>[", sexp_square_tail_wrap_list = "<LocalLeader>]", sexp_curly_head_wrap_list = "<LocalLeader>{", sexp_curly_tail_wrap_list = "<LocalLeader>}", sexp_round_head_wrap_element = "<LocalLeader>w", sexp_round_tail_wrap_element = "<LocalLeader>W", sexp_square_head_wrap_element = "<LocalLeader>e[", sexp_square_tail_wrap_element = "<LocalLeader>e]", sexp_curly_head_wrap_element = "<LocalLeader>e{", sexp_curly_tail_wrap_element = "<LocalLeader>e}", sexp_insert_at_list_head = "<LocalLeader>h", sexp_insert_at_list_tail = "<LocalLeader>l", sexp_splice_list = "<LocalLeader>@", sexp_convolute = "<LocalLeader>?", sexp_raise_list = "<LocalLeader>o", sexp_raise_element = "<LocalLeader>O", sexp_swap_list_backward = "<M-k>", sexp_swap_list_forward = "<M-j>", sexp_swap_element_backward = "<M-h>", sexp_swap_element_forward = "<M-l>", sexp_emit_head_element = "<M-S-j>", sexp_emit_tail_element = "<M-S-k>", sexp_capture_prev_element = "<M-S-h>", sexp_capture_next_element = "<M-S-l>"}
local enable_insert_mode_mappings = true
local function create_mappings(a, b)
  for _, plug in ipairs({"sexp_outer_list", "sexp_inner_list", "sexp_outer_top_list", "sexp_inner_top_list", "sexp_outer_string", "sexp_inner_string", "sexp_outer_element", "sexp_inner_element"}) do
    local lhs = sexp_mappings[plug]
    vim.keymap.set({"x", "o"}, lhs, ("<Plug>(" .. plug .. ")"), {buffer = 0})
  end
  for _, plug in ipairs({"sexp_move_to_prev_bracket", "sexp_move_to_next_bracket", "sexp_move_to_prev_element_head", "sexp_move_to_next_element_head", "sexp_move_to_prev_element_tail", "sexp_move_to_next_element_tail", "sexp_move_to_prev_top_element", "sexp_move_to_next_top_element", "sexp_select_prev_element", "sexp_select_next_element"}) do
    local lhs = sexp_mappings[plug]
    vim.keymap.set({"n", "x", "o"}, lhs, ("<Plug>(" .. plug .. ")"), {buffer = 0})
  end
  for _, plug in ipairs({"sexp_indent", "sexp_indent_top", "sexp_insert_at_list_head", "sexp_insert_at_list_tail", "sexp_convolute", "sexp_splice_list"}) do
    local lhs = sexp_mappings[plug]
    vim.keymap.set({"n"}, lhs, ("<Plug>(" .. plug .. ")"), {buffer = 0})
  end
  for _, plug in ipairs({"sexp_round_head_wrap_list", "sexp_round_tail_wrap_list", "sexp_square_head_wrap_list", "sexp_square_tail_wrap_list", "sexp_curly_head_wrap_list", "sexp_curly_tail_wrap_list", "sexp_round_head_wrap_element", "sexp_round_tail_wrap_element", "sexp_square_head_wrap_element", "sexp_square_tail_wrap_element", "sexp_curly_head_wrap_element", "sexp_curly_tail_wrap_element", "sexp_raise_list", "sexp_raise_element", "sexp_swap_list_backward", "sexp_swap_list_forward", "sexp_swap_element_backward", "sexp_swap_element_forward", "sexp_emit_head_element", "sexp_emit_tail_element", "sexp_capture_prev_element", "sexp_capture_next_element", "sexp_flow_to_prev_close", "sexp_flow_to_next_open", "sexp_flow_to_prev_open", "sexp_flow_to_next_close", "sexp_flow_to_prev_leaf_head", "sexp_flow_to_next_leaf_head", "sexp_flow_to_prev_leaf_tail", "sexp_flow_to_next_leaf_tail"}) do
    local lhs = sexp_mappings[plug]
    vim.keymap.set({"n", "x"}, lhs, ("<Plug>(" .. plug .. ")"), {buffer = 0})
  end
  if enable_insert_mode_mappings then
    vim.keymap.set("i", "(", "<Plug>(sexp_insert_opening_round)", {buffer = 0})
    vim.keymap.set("i", "[", "<Plug>(sexp_insert_opening_square)", {buffer = 0})
    vim.keymap.set("i", "{", "<Plug>(sexp_insert_opening_curly)", {buffer = 0})
    vim.keymap.set("i", ")", "<Plug>(sexp_insert_closing_round)", {buffer = 0})
    vim.keymap.set("i", "]", "<Plug>(sexp_insert_closing_square)", {buffer = 0})
    vim.keymap.set("i", "}", "<Plug>(sexp_insert_closing_curly)", {buffer = 0})
    vim.keymap.set("i", "\"", "<Plug>(sexp_insert_double_quote)", {buffer = 0})
    return vim.keymap.set("i", "<BS>", "<Plug>(sexp_insert_backspace)", {buffer = 0})
  else
    return nil
  end
end
local function DEFPLUG(modes, func, seq)
  return vim.keymap.set(modes, ("<Plug>(" .. func .. ")"), seq)
end
local function create_autocmd()
  if (string.len(sexp_filetypes) ~= 0) then
    return vim.api.nvim_create_autocmd("FileType", {pattern = sexp_filetypes, group = vim.api.nvim_create_augroup("sexp-filetypes", {clear = true}), callback = create_mappings})
  else
    return nil
  end
end
local function setup(opts)
  create_autocmd()
  DEFPLUG("x", "sexp_move_to_prev_bracket", "<Esc>:<C-u>call sexp#docount(v:prevcount, 'sexp#move_to_nearest_bracket', 'v', 0)<CR>")
  DEFPLUG("x", "sexp_move_to_next_bracket", "<Esc>:<C-u>call sexp#docount(v:prevcount, 'sexp#move_to_nearest_bracket', 'v', 1)<CR>")
  DEFPLUG("x", "sexp_move_to_prev_element_head", "<Esc>:<C-u>call sexp#move_to_adjacent_element('v', v:prevcount, 0, 0, 0)<CR>")
  DEFPLUG("x", "sexp_move_to_next_element_head", "<Esc>:<C-u>call sexp#move_to_adjacent_element('v', v:prevcount, 1, 0, 0)<CR>")
  DEFPLUG("x", "sexp_move_to_prev_element_tail", "<Esc>:<C-u>call sexp#move_to_adjacent_element('v', v:prevcount, 0, 1, 0)<CR>")
  DEFPLUG("x", "sexp_move_to_next_element_tail", "<Esc>:<C-u>call sexp#move_to_adjacent_element('v', v:prevcount, 1, 1, 0)<CR>")
  DEFPLUG("x", "sexp_flow_to_prev_close", "<Esc>:<C-u>call sexp#list_flow('v', v:prevcount, 0, 1)<CR>")
  DEFPLUG("x", "sexp_flow_to_prev_open", "<Esc>:<C-u>call sexp#list_flow('v', v:prevcount, 0, 0)<CR>")
  DEFPLUG("x", "sexp_flow_to_next_open", "<Esc>:<C-u>call sexp#list_flow('v', v:prevcount, 1, 0)<CR>")
  DEFPLUG("x", "sexp_flow_to_next_close", "<Esc>:<C-u>call sexp#list_flow('v', v:prevcount, 1, 1)<CR>")
  DEFPLUG("x", "sexp_flow_to_prev_leaf_head", "<Esc>:<C-u>call sexp#leaf_flow('v', v:prevcount, 0, 0)<CR>")
  DEFPLUG("x", "sexp_flow_to_next_leaf_head", "<Esc>:<C-u>call sexp#leaf_flow('v', v:prevcount, 1, 0)<CR>")
  DEFPLUG("x", "sexp_flow_to_prev_leaf_tail", "<Esc>:<C-u>call sexp#leaf_flow('v', v:prevcount, 0, 1)<CR>")
  DEFPLUG("x", "sexp_flow_to_next_leaf_tail", "<Esc>:<C-u>call sexp#leaf_flow('v', v:prevcount, 1, 1)<CR>")
  DEFPLUG("x", "sexp_move_to_prev_top_element", "<Esc>:<C-u>call sexp#move_to_adjacent_element('v', v:prevcount, 0, 0, 1)<CR>")
  DEFPLUG("x", "sexp_move_to_next_top_element", "<Esc>:<C-u>call sexp#move_to_adjacent_element('v', v:prevcount, 1, 0, 1)<CR>")
  DEFPLUG("x", "sexp_swap_list_forward", "<Esc>:<C-u>call sexp#docount(v:prevcount, 'sexp#swap_element', 'v', 1, 1)<CR>")
  DEFPLUG("x", "sexp_swap_list_forward", "<Esc>:<C-u>call sexp#docount(v:prevcount, 'sexp#swap_element', 'v', 1, 1)<CR>")
  DEFPLUG("x", "sexp_swap_element_backward", "<Esc>:<C-u>call sexp#docount(v:prevcount, 'sexp#swap_element', 'v', 0, 0)<CR>")
  return DEFPLUG("x", "sexp_swap_element_forward", "<Esc>:<C-u>call sexp#docount(v:prevcount, 'sexp#swap_element', 'v', 1, 0)<CR>")
end
return {setup = setup}
