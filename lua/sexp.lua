local mappings = {sexp_outer_list = "af", sexp_inner_list = "if", sexp_outer_top_list = "aF", sexp_inner_top_list = "iF", sexp_outer_string = "as", sexp_inner_string = "is", sexp_outer_element = "ae", sexp_inner_element = "ie", sexp_move_to_prev_bracket = "(", sexp_move_to_next_bracket = ")", sexp_move_to_prev_element_head = "<M-b>", sexp_move_to_next_element_head = "<M-w>", sexp_move_to_prev_element_tail = "g<M-e>", sexp_move_to_next_element_tail = "<M-e>", sexp_flow_to_prev_close = "<M-[>", sexp_flow_to_next_open = "<M-]>", sexp_flow_to_prev_open = "<M-{>", sexp_flow_to_next_close = "<M-}>", sexp_flow_to_prev_leaf_head = "<M-S-b>", sexp_flow_to_next_leaf_head = "<M-S-w>", sexp_flow_to_prev_leaf_tail = "<M-S-g>", sexp_flow_to_next_leaf_tail = "<M-S-e>", sexp_move_to_prev_top_element = "[[", sexp_move_to_next_top_element = "]]", sexp_select_prev_element = "[e", sexp_select_next_element = "]e", sexp_indent = "==", sexp_indent_top = "=-", sexp_round_head_wrap_list = "<LocalLeader>i", sexp_round_tail_wrap_list = "<LocalLeader>I", sexp_square_head_wrap_list = "<LocalLeader>[", sexp_square_tail_wrap_list = "<LocalLeader>]", sexp_curly_head_wrap_list = "<LocalLeader>{", sexp_curly_tail_wrap_list = "<LocalLeader>}", sexp_round_head_wrap_element = "<LocalLeader>w", sexp_round_tail_wrap_element = "<LocalLeader>W", sexp_square_head_wrap_element = "<LocalLeader>e[", sexp_square_tail_wrap_element = "<LocalLeader>e]", sexp_curly_head_wrap_element = "<LocalLeader>e{", sexp_curly_tail_wrap_element = "<LocalLeader>e}", sexp_insert_at_list_head = "<LocalLeader>h", sexp_insert_at_list_tail = "<LocalLeader>l", sexp_splice_list = "<LocalLeader>@", sexp_convolute = "<LocalLeader>?", sexp_raise_list = "<LocalLeader>o", sexp_raise_element = "<LocalLeader>O", sexp_swap_list_backward = "<M-k>", sexp_swap_list_forward = "<M-j>", sexp_swap_element_backward = "<M-h>", sexp_swap_element_forward = "<M-l>", sexp_emit_head_element = "<M-S-j>", sexp_emit_tail_element = "<M-S-k>", sexp_capture_prev_element = "<M-S-h>", sexp_capture_next_element = "<M-S-l>"}
local have_repeat_set = vim.fn.exists("repeat#set")
local defaults = {enable_insert_mode_mappings = true, insert_after_wrap = true, filetypes = "clojure,scheme,lisp,timl,fennel", maxlines = -1, mappings = mappings}
local function imapexpr(lhs, rhs)
  return vim.keymap.set("i", lhs, rhs, {expr = true, replace_keycodes = false})
end
local function create_mappings(a, b)
  for _, plug in ipairs({"sexp_outer_list", "sexp_inner_list", "sexp_outer_top_list", "sexp_inner_top_list", "sexp_outer_string", "sexp_inner_string", "sexp_outer_element", "sexp_inner_element"}) do
    local lhs = options.mappings[plug]
    vim.keymap.set({"x", "o"}, lhs, ("<Plug>(" .. plug .. ")"), {buffer = 0})
  end
  for _, plug in ipairs({"sexp_move_to_prev_bracket", "sexp_move_to_next_bracket", "sexp_move_to_prev_element_head", "sexp_move_to_next_element_head", "sexp_move_to_prev_element_tail", "sexp_move_to_next_element_tail", "sexp_move_to_prev_top_element", "sexp_move_to_next_top_element", "sexp_select_prev_element", "sexp_select_next_element"}) do
    local lhs = options.mappings[plug]
    vim.keymap.set({"n", "x", "o"}, lhs, ("<Plug>(" .. plug .. ")"), {buffer = 0})
  end
  for _, plug in ipairs({"sexp_indent", "sexp_indent_top", "sexp_insert_at_list_head", "sexp_insert_at_list_tail", "sexp_convolute", "sexp_splice_list"}) do
    local lhs = options.mappings[plug]
    vim.keymap.set({"n"}, lhs, ("<Plug>(" .. plug .. ")"), {buffer = 0})
  end
  for _, plug in ipairs({"sexp_round_head_wrap_list", "sexp_round_tail_wrap_list", "sexp_square_head_wrap_list", "sexp_square_tail_wrap_list", "sexp_curly_head_wrap_list", "sexp_curly_tail_wrap_list", "sexp_round_head_wrap_element", "sexp_round_tail_wrap_element", "sexp_square_head_wrap_element", "sexp_square_tail_wrap_element", "sexp_curly_head_wrap_element", "sexp_curly_tail_wrap_element", "sexp_raise_list", "sexp_raise_element", "sexp_swap_list_backward", "sexp_swap_list_forward", "sexp_swap_element_backward", "sexp_swap_element_forward", "sexp_emit_head_element", "sexp_emit_tail_element", "sexp_capture_prev_element", "sexp_capture_next_element", "sexp_flow_to_prev_close", "sexp_flow_to_next_open", "sexp_flow_to_prev_open", "sexp_flow_to_next_close", "sexp_flow_to_prev_leaf_head", "sexp_flow_to_next_leaf_head", "sexp_flow_to_prev_leaf_tail", "sexp_flow_to_next_leaf_tail"}) do
    local lhs = options.mappings[plug]
    vim.keymap.set({"n", "x"}, lhs, ("<Plug>(" .. plug .. ")"), {buffer = 0})
  end
  if options.enable_insert_mode_mappings then
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
local function build_prefix(jump, opmode)
  local function _3_()
    if jump then
      local function _2_()
        if opmode then
          return "vv"
        else
          return ""
        end
      end
      return ("execute \"normal! " .. _2_() .. "m`\" \\| ")
    else
      return ""
    end
  end
  return (":<C-u>let b:sexp_count = v:count \\| " .. _3_())
end
local function defplug(mode, func, expr, _repeat, jump)
  local lhs = (mode .. "noremap <silent> <Plug>(" .. func .. ")")
  local opmode = (string.sub(mode, 1, 1) == "o")
  local prefix = build_prefix(jump, opmode)
  local prefix0 = (prefix .. "call " .. expr)
  local _repeat0 = true
  local _4_ = {_repeat0, opmode}
  if ((_G.type(_4_) == "table") and ((_4_)[1] == false) and true) then
    local _ = (_4_)[2]
    return vim.api.nvim_command((lhs .. " " .. prefix0 .. "<CR>"))
  elseif ((_G.type(_4_) == "table") and ((_4_)[1] == true) and ((_4_)[2] == true)) then
    return vim.api.nvim_command((lhs .. " " .. prefix0 .. " \\| " .. "if v:operator ==? \"c\" \\| " .. "  call sexp#repeat_set(v:operator . \"\\<Plug>(" .. func .. ")\\<lt>C-r>.\\<lt>C-Bslash>\\<lt>C-n>\", b:sexp_count) \\| " .. "else \\| " .. "  call sexp#repeat_set(v:operator . \"\\<Plug>(" .. func .. ")\", b:sexp_count) \\| " .. "endif<CR>"))
  elseif true then
    local _ = _4_
    return vim.api.nvim_command((lhs .. " " .. prefix0 .. " \\| call sexp#repeat_set(\"\\<Plug>(" .. func .. ")\", b:sexp_count)<CR>"))
  else
    return nil
  end
end
local function defplug000(modes, func, seq)
  return vim.keymap.set(modes, ("<Plug>(" .. func .. ")"), seq)
end
local function defplug100(mode, func, expr)
  return defplug(mode, func, expr, false, true)
end
local function defplug110(mode, func, expr)
  return defplug(mode, func, expr, true, true)
end
local function defplug101(mode, func, expr)
  return defplug(mode, func, expr, false, false)
end
local function defplug111(mode, func, expr)
  return defplug(mode, func, expr, true, false)
end
local function create_autocmd()
  if (string.len(options.filetypes) ~= 0) then
    return vim.api.nvim_create_autocmd("FileType", {pattern = options.filetypes, group = vim.api.nvim_create_augroup("sexp-filetypes", {clear = true}), callback = create_mappings})
  else
    return nil
  end
end
local function setup(opts)
  options = vim.tbl_deep_extend("force", {}, defaults, opts)
  local _7_
  if options.insert_after_wrap then
    _7_ = 1
  else
    _7_ = 0
  end
  vim.g["sexp_insert_after_wrap"] = _7_
  vim.g["sexp_maxlines"] = options.maxlines
  create_autocmd()
  defplug100("x", "sexp_outer_list", "sexp#docount(b:sexp_count, 'sexp#select_current_list', 'v', 0, 1)")
  defplug110("o", "sexp_outer_list", "sexp#docount(b:sexp_count, 'sexp#select_current_list', 'o', 0, 1)")
  defplug100("x", "sexp_inner_list", "sexp#docount(b:sexp_count, 'sexp#select_current_list', 'v', 1, 1)")
  defplug110("o", "sexp_inner_list", "sexp#docount(b:sexp_count, 'sexp#select_current_list', 'o', 1, 1)")
  defplug100("x", "sexp_outer_top_list", "sexp#select_current_top_list('v', 0)")
  defplug110("o", "sexp_outer_top_list", "sexp#select_current_top_list('o', 0)")
  defplug100("x", "sexp_inner_top_list", "sexp#select_current_top_list('v', 1)")
  defplug110("o", "sexp_inner_top_list", "sexp#select_current_top_list('o', 1)")
  defplug100("x", "sexp_outer_string", "sexp#select_current_string('v', 0)")
  defplug110("o", "sexp_outer_string", "sexp#select_current_string('o', 0)")
  defplug100("x", "sexp_inner_string", "sexp#select_current_string('v', 1)")
  defplug110("o", "sexp_inner_string", "sexp#select_current_string('o', 1)")
  defplug100("x", "sexp_outer_element", "sexp#select_current_element('v', 0)")
  defplug110("o", "sexp_outer_element", "sexp#select_current_element('o', 0)")
  defplug100("x", "sexp_inner_element", "sexp#select_current_element('v', 1)")
  defplug110("o", "sexp_inner_element", "sexp#select_current_element('o', 1)")
  defplug100("n", "sexp_move_to_prev_bracket", "sexp#docount(b:sexp_count, 'sexp#move_to_nearest_bracket', 'n', 0)")
  defplug000("x", "sexp_move_to_prev_bracket", "<Esc>:<C-u>call sexp#docount(v:prevcount, 'sexp#move_to_nearest_bracket', 'v', 0)<CR>")
  defplug110("o", "sexp_move_to_prev_bracket", "sexp#move_to_nearest_bracket('o', 0)")
  defplug100("n", "sexp_move_to_next_bracket", "sexp#docount(b:sexp_count, 'sexp#move_to_nearest_bracket', 'n', 1)")
  defplug000("x", "sexp_move_to_next_bracket", "<Esc>:<C-u>call sexp#docount(v:prevcount, 'sexp#move_to_nearest_bracket', 'v', 1)<CR>")
  defplug110("o", "sexp_move_to_next_bracket", "sexp#move_to_nearest_bracket('o', 1)")
  defplug101("n", "sexp_move_to_prev_element_head", "sexp#move_to_adjacent_element('n', b:sexp_count, 0, 0, 0)")
  defplug000("x", "sexp_move_to_prev_element_head", "<Esc>:<C-u>call sexp#move_to_adjacent_element('v', v:prevcount, 0, 0, 0)<CR>")
  defplug111("o", "sexp_move_to_prev_element_head", "sexp#move_to_adjacent_element('o', b:sexp_count, 0, 0, 0)")
  defplug101("n", "sexp_move_to_next_element_head", "sexp#move_to_adjacent_element('n', b:sexp_count, 1, 0, 0)")
  defplug000("x", "sexp_move_to_next_element_head", "<Esc>:<C-u>call sexp#move_to_adjacent_element('v', v:prevcount, 1, 0, 0)<CR>")
  defplug111("o", "sexp_move_to_next_element_head", "sexp#move_to_adjacent_element('o', b:sexp_count, 1, 0, 0)")
  defplug101("n", "sexp_move_to_prev_element_tail", "sexp#move_to_adjacent_element('n', b:sexp_count, 0, 1, 0)")
  defplug000("x", "sexp_move_to_prev_element_tail", "<Esc>:<C-u>call sexp#move_to_adjacent_element('v', v:prevcount, 0, 1, 0)<CR>")
  defplug111("o", "sexp_move_to_prev_element_tail", "sexp#move_to_adjacent_element('o', b:sexp_count, 0, 1, 0)")
  defplug101("n", "sexp_move_to_next_element_tail", "sexp#move_to_adjacent_element('n', b:sexp_count, 1, 1, 0)")
  defplug000("x", "sexp_move_to_next_element_tail", "<Esc>:<C-u>call sexp#move_to_adjacent_element('v', v:prevcount, 1, 1, 0)<CR>")
  defplug111("o", "sexp_move_to_next_element_tail", "sexp#move_to_adjacent_element('o', b:sexp_count, 1, 1, 0)")
  defplug100("n", "sexp_flow_to_prev_close", "sexp#list_flow('n', b:sexp_count, 0, 1)")
  defplug000("x", "sexp_flow_to_prev_close", "<Esc>:<C-u>call sexp#list_flow('v', v:prevcount, 0, 1)<CR>")
  defplug100("n", "sexp_flow_to_prev_open", "sexp#list_flow('n', b:sexp_count, 0, 0)")
  defplug000("x", "sexp_flow_to_prev_open", "<Esc>:<C-u>call sexp#list_flow('v', v:prevcount, 0, 0)<CR>")
  defplug100("n", "sexp_flow_to_next_open", "sexp#list_flow('n', b:sexp_count, 1, 0)")
  defplug000("x", "sexp_flow_to_next_open", "<Esc>:<C-u>call sexp#list_flow('v', v:prevcount, 1, 0)<CR>")
  defplug100("n", "sexp_flow_to_next_close", "sexp#list_flow('n', b:sexp_count, 1, 1)")
  defplug000("x", "sexp_flow_to_next_close", "<Esc>:<C-u>call sexp#list_flow('v', v:prevcount, 1, 1)<CR>")
  defplug101("n", "sexp_flow_to_prev_leaf_head", "sexp#leaf_flow('n', b:sexp_count, 0, 0)")
  defplug000("x", "sexp_flow_to_prev_leaf_head", "<Esc>:<C-u>call sexp#leaf_flow('v', v:prevcount, 0, 0)<CR>")
  defplug101("n", "sexp_flow_to_next_leaf_head", "sexp#leaf_flow('n', b:sexp_count, 1, 0)")
  defplug000("x", "sexp_flow_to_next_leaf_head", "<Esc>:<C-u>call sexp#leaf_flow('v', v:prevcount, 1, 0)<CR>")
  defplug101("n", "sexp_flow_to_prev_leaf_tail", "sexp#leaf_flow('n', b:sexp_count, 0, 1)")
  defplug000("x", "sexp_flow_to_prev_leaf_tail", "<Esc>:<C-u>call sexp#leaf_flow('v', v:prevcount, 0, 1)<CR>")
  defplug101("n", "sexp_flow_to_next_leaf_tail", "sexp#leaf_flow('n', b:sexp_count, 1, 1)")
  defplug000("x", "sexp_flow_to_next_leaf_tail", "<Esc>:<C-u>call sexp#leaf_flow('v', v:prevcount, 1, 1)<CR>")
  defplug100("n", "sexp_move_to_prev_top_element", "sexp#move_to_adjacent_element('n', b:sexp_count, 0, 0, 1)")
  defplug000("x", "sexp_move_to_prev_top_element", "<Esc>:<C-u>call sexp#move_to_adjacent_element('v', v:prevcount, 0, 0, 1)<CR>")
  defplug110("o", "sexp_move_to_prev_top_element", "sexp#move_to_adjacent_element('o', b:sexp_count, 0, 0, 1)")
  defplug100("n", "sexp_move_to_next_top_element", "sexp#move_to_adjacent_element('n', b:sexp_count, 1, 0, 1)")
  defplug000("x", "sexp_move_to_next_top_element", "<Esc>:<C-u>call sexp#move_to_adjacent_element('v', v:prevcount, 1, 0, 1)<CR>")
  defplug110("o", "sexp_move_to_next_top_element", "sexp#move_to_adjacent_element('o', b:sexp_count, 1, 0, 1)")
  defplug100("n", "sexp_select_prev_element", "sexp#docount(b:sexp_count, 'sexp#select_adjacent_element', 'n', 0)")
  defplug100("x", "sexp_select_prev_element", "sexp#docount(b:sexp_count, 'sexp#select_adjacent_element', 'v', 0)")
  defplug110("o", "sexp_select_prev_element", "sexp#docount(b:sexp_count, 'sexp#select_adjacent_element', 'o', 0)")
  defplug100("n", "sexp_select_next_element", "sexp#docount(b:sexp_count, 'sexp#select_adjacent_element', 'n', 1)")
  defplug100("x", "sexp_select_next_element", "sexp#docount(b:sexp_count, 'sexp#select_adjacent_element', 'v', 1)")
  defplug110("o", "sexp_select_next_element", "sexp#docount(b:sexp_count, 'sexp#select_adjacent_element', 'o', 1)")
  defplug110("n", "sexp_indent", "sexp#indent(0, b:sexp_count)")
  defplug110("n", "sexp_indent_top", "sexp#indent(1, b:sexp_count)")
  defplug110("n", "sexp_round_head_wrap_list", "sexp#wrap('f', '(', ')', 0, g:sexp_insert_after_wrap)")
  defplug100("x", "sexp_round_head_wrap_list", "sexp#wrap('v', '(', ')', 0, g:sexp_insert_after_wrap)")
  defplug110("n", "sexp_round_tail_wrap_list", "sexp#wrap('f', '(', ')', 1, g:sexp_insert_after_wrap)")
  defplug100("x", "sexp_round_tail_wrap_list", "sexp#wrap('v', '(', ')', 1, g:sexp_insert_after_wrap)")
  defplug110("n", "sexp_square_head_wrap_list", "sexp#wrap('f', '[', ']', 0, g:sexp_insert_after_wrap)")
  defplug100("x", "sexp_square_head_wrap_list", "sexp#wrap('v', '[', ']', 0, g:sexp_insert_after_wrap)")
  defplug110("n", "sexp_square_tail_wrap_list", "sexp#wrap('f', '[', ']', 1, g:sexp_insert_after_wrap)")
  defplug100("x", "sexp_square_tail_wrap_list", "sexp#wrap('v', '[', ']', 1, g:sexp_insert_after_wrap)")
  defplug110("n", "sexp_curly_head_wrap_list", "sexp#wrap('f', '{', '}', 0, g:sexp_insert_after_wrap)")
  defplug100("x", "sexp_curly_head_wrap_list", "sexp#wrap('v', '{', '}', 0, g:sexp_insert_after_wrap)")
  defplug110("n", "sexp_curly_tail_wrap_list", "sexp#wrap('f', '{', '}', 1, g:sexp_insert_after_wrap)")
  defplug100("x", "sexp_curly_tail_wrap_list", "sexp#wrap('v', '{', '}', 1, g:sexp_insert_after_wrap)")
  defplug110("n", "sexp_round_head_wrap_element", "sexp#wrap('e', '(', ')', 0, g:sexp_insert_after_wrap)")
  defplug100("x", "sexp_round_head_wrap_element", "sexp#wrap('v', '(', ')', 0, g:sexp_insert_after_wrap)")
  defplug110("n", "sexp_round_tail_wrap_element", "sexp#wrap('e', '(', ')', 1, g:sexp_insert_after_wrap)")
  defplug100("x", "sexp_round_tail_wrap_element", "sexp#wrap('v', '(', ')', 1, g:sexp_insert_after_wrap)")
  defplug110("n", "sexp_square_head_wrap_element", "sexp#wrap('e', '[', ']', 0, g:sexp_insert_after_wrap)")
  defplug100("x", "sexp_square_head_wrap_element", "sexp#wrap('v', '[', ']', 0, g:sexp_insert_after_wrap)")
  defplug110("n", "sexp_square_tail_wrap_element", "sexp#wrap('e', '[', ']', 1, g:sexp_insert_after_wrap)")
  defplug100("x", "sexp_square_tail_wrap_element", "sexp#wrap('v', '[', ']', 1, g:sexp_insert_after_wrap)")
  defplug110("n", "sexp_curly_head_wrap_element", "sexp#wrap('e', '{', '}', 0, g:sexp_insert_after_wrap)")
  defplug100("x", "sexp_curly_head_wrap_element", "sexp#wrap('v', '{', '}', 0, g:sexp_insert_after_wrap)")
  defplug110("n", "sexp_curly_tail_wrap_element", "sexp#wrap('e', '{', '}', 1, g:sexp_insert_after_wrap)")
  defplug100("x", "sexp_curly_tail_wrap_element", "sexp#wrap('v', '{', '}', 1, g:sexp_insert_after_wrap)")
  defplug110("n", "sexp_insert_at_list_head", "sexp#insert_at_list_terminal(0)")
  defplug110("n", "sexp_insert_at_list_tail", "sexp#insert_at_list_terminal(1)")
  defplug110("n", "sexp_raise_list", "sexp#docount(b:sexp_count, 'sexp#raise', 'n', 'sexp#select_current_list', 'n', 0, 0)")
  defplug100("x", "sexp_raise_list", "sexp#docount(b:sexp_count, 'sexp#raise', 'v', '')")
  defplug110("n", "sexp_raise_element", "sexp#docount(b:sexp_count, 'sexp#raise', 'n', 'sexp#select_current_element', 'n', 1)")
  defplug100("x", "sexp_raise_element", "sexp#docount(b:sexp_count, 'sexp#raise', 'v', '')")
  defplug111("n", "sexp_convolute", "sexp#convolute(b:sexp_count, 'n')")
  defplug110("n", "sexp_splice_list", "sexp#splice_list(b:sexp_count)")
  defplug110("n", "sexp_swap_list_backward", "sexp#docount(b:sexp_count, 'sexp#swap_element', 'n', 0, 1)")
  defplug110("n", "sexp_swap_list_forward", "sexp#docount(b:sexp_count, 'sexp#swap_element', 'n', 1, 1)")
  defplug000("x", "sexp_swap_list_forward", "<Esc>:<C-u>call sexp#docount(v:prevcount, 'sexp#swap_element', 'v', 1, 1)<CR>")
  defplug110("n", "sexp_swap_element_backward", "sexp#docount(b:sexp_count, 'sexp#swap_element', 'n', 0, 0)")
  defplug000("x", "sexp_swap_element_backward", "<Esc>:<C-u>call sexp#docount(v:prevcount, 'sexp#swap_element', 'v', 0, 0)<CR>")
  defplug110("n", "sexp_swap_element_forward", "sexp#docount(b:sexp_count, 'sexp#swap_element', 'n', 1, 0)")
  defplug000("x", "sexp_swap_element_forward", "<Esc>:<C-u>call sexp#docount(v:prevcount, 'sexp#swap_element', 'v', 1, 0)<CR>")
  defplug110("n", "sexp_emit_head_element", "sexp#docount(b:sexp_count, 'sexp#stackop', 'n', 0, 0)")
  defplug100("x", "sexp_emit_head_element", "sexp#docount(b:sexp_count, 'sexp#stackop', 'v', 0, 0)")
  defplug110("n", "sexp_emit_tail_element", "sexp#docount(b:sexp_count, 'sexp#stackop', 'n', 1, 0)")
  defplug100("x", "sexp_emit_tail_element", "sexp#docount(b:sexp_count, 'sexp#stackop', 'v', 1, 0)")
  defplug110("n", "sexp_capture_prev_element", "sexp#docount(b:sexp_count, 'sexp#stackop', 'n', 0, 1)")
  defplug100("x", "sexp_capture_prev_element", "sexp#docount(b:sexp_count, 'sexp#stackop', 'v', 0, 1)")
  defplug110("n", "sexp_capture_next_element", "sexp#docount(b:sexp_count, 'sexp#stackop', 'n', 1, 1)")
  defplug100("x", "sexp_capture_next_element", "sexp#docount(b:sexp_count, 'sexp#stackop', 'v', 1, 1)")
  imapexpr("<Plug>(sexp_insert_opening_round)", "sexp#opening_insertion('(')")
  imapexpr("<Plug>(sexp_insert_opening_square)", "sexp#opening_insertion('[')")
  imapexpr("<Plug>(sexp_insert_opening_curly)", "sexp#opening_insertion('{')")
  imapexpr("<Plug>(sexp_insert_closing_round)", "sexp#closing_insertion(')')")
  imapexpr("<Plug>(sexp_insert_closing_square)", "sexp#closing_insertion(']')")
  imapexpr("<Plug>(sexp_insert_closing_curly)", "sexp#closing_insertion('}')")
  imapexpr("<Plug>(sexp_insert_double_quote)", "sexp#quote_insertion('\"')")
  return imapexpr("<Plug>(sexp_insert_backspace)", "sexp#backspace_insertion()")
end
return {setup = setup}
