;                                                                  o8o
;                                                                  '"'
;   .oooo.o  .ooooo. oooo    ooooo.ooooo.    ooo. .oo. oooo    ooooooo ooo. .oo.  .oo.
;  d88(  "8 d88' `88b `88b..8P'  888' `88b   `888P"Y88b `88.  .8' `888 `888P"Y88bP"Y88b
;  `"Y88b.  888ooo888   Y888'    888   888    888   888  `88..8'   888  888   888   888
;  o.  )88b 888    .o .o8"'88b   888   888    888   888   `888'    888  888   888   888
;  8""888P' `Y8bod8P'o88'   888o 888bod8P' o o888o o888o   `8'    o888oo888o o888o o888o
;                                888
;                               o888o
;  Author:   guns <self@sungpae.com>
;            Ported by Grazfather <grazfather@gmail.com>
;  License:  MIT
;  Homepage: https://github.com/Grazfather/sexp.nvim

; TODO: Put into a config map and let setup override these
(var sexp_filetypes "clojure,scheme,lisp,timl,fennel")
(var sexp_mappings {"sexp_outer_list"                "af"
                    "sexp_inner_list"                "if"
                    "sexp_outer_top_list"            "aF"
                    "sexp_inner_top_list"            "iF"
                    "sexp_outer_string"              "as"
                    "sexp_inner_string"              "is"
                    "sexp_outer_element"             "ae"
                    "sexp_inner_element"             "ie"
                    "sexp_move_to_prev_bracket"      "("
                    "sexp_move_to_next_bracket"      ")"
                    "sexp_move_to_prev_element_head" "<M-b>"
                    "sexp_move_to_next_element_head" "<M-w>"
                    "sexp_move_to_prev_element_tail" "g<M-e>"
                    "sexp_move_to_next_element_tail" "<M-e>"
                    "sexp_flow_to_prev_close"        "<M-[>"
                    "sexp_flow_to_next_open"         "<M-]>"
                    "sexp_flow_to_prev_open"         "<M-{>"
                    "sexp_flow_to_next_close"        "<M-}>"
                    "sexp_flow_to_prev_leaf_head"    "<M-S-b>"
                    "sexp_flow_to_next_leaf_head"    "<M-S-w>"
                    "sexp_flow_to_prev_leaf_tail"    "<M-S-g>"
                    "sexp_flow_to_next_leaf_tail"    "<M-S-e>"
                    "sexp_move_to_prev_top_element"  "[["
                    "sexp_move_to_next_top_element"  "]]"
                    "sexp_select_prev_element"       "[e"
                    "sexp_select_next_element"       "]e"
                    "sexp_indent"                    "=="
                    "sexp_indent_top"                "=-"
                    "sexp_round_head_wrap_list"      "<LocalLeader>i"
                    "sexp_round_tail_wrap_list"      "<LocalLeader>I"
                    "sexp_square_head_wrap_list"     "<LocalLeader>["
                    "sexp_square_tail_wrap_list"     "<LocalLeader>]"
                    "sexp_curly_head_wrap_list"      "<LocalLeader>{"
                    "sexp_curly_tail_wrap_list"      "<LocalLeader>}"
                    "sexp_round_head_wrap_element"   "<LocalLeader>w"
                    "sexp_round_tail_wrap_element"   "<LocalLeader>W"
                    "sexp_square_head_wrap_element"  "<LocalLeader>e["
                    "sexp_square_tail_wrap_element"  "<LocalLeader>e]"
                    "sexp_curly_head_wrap_element"   "<LocalLeader>e{"
                    "sexp_curly_tail_wrap_element"   "<LocalLeader>e}"
                    "sexp_insert_at_list_head"       "<LocalLeader>h"
                    "sexp_insert_at_list_tail"       "<LocalLeader>l"
                    "sexp_splice_list"               "<LocalLeader>@"
                    "sexp_convolute"                 "<LocalLeader>?"
                    "sexp_raise_list"                "<LocalLeader>o"
                    "sexp_raise_element"             "<LocalLeader>O"
                    "sexp_swap_list_backward"        "<M-k>"
                    "sexp_swap_list_forward"         "<M-j>"
                    "sexp_swap_element_backward"     "<M-h>"
                    "sexp_swap_element_forward"      "<M-l>"
                    "sexp_emit_head_element"         "<M-S-j>"
                    "sexp_emit_tail_element"         "<M-S-k>"
                    "sexp_capture_prev_element"      "<M-S-h>"
                    "sexp_capture_next_element"      "<M-S-l>"})
(var enable_insert_mode_mappings true)
; Detect repeat.vim
(local have-repeat-set (vim.fn.exists "repeat#set"))

(fn imapexpr [lhs rhs]
  (vim.keymap.set :i lhs rhs {:replace_keycodes false :expr true}))

(fn create-mappings [a b]
  (each [_ plug (ipairs ["sexp_outer_list"     "sexp_inner_list"
                         "sexp_outer_top_list" "sexp_inner_top_list"
                         "sexp_outer_string"   "sexp_inner_string"
                         "sexp_outer_element"  "sexp_inner_element"])]
    (let [lhs (. sexp_mappings plug)]
      (vim.keymap.set [:x :o] lhs (.. "<Plug>(" plug ")") {:buffer 0})))

  (each [_ plug (ipairs ["sexp_move_to_prev_bracket"      "sexp_move_to_next_bracket"
                         "sexp_move_to_prev_element_head" "sexp_move_to_next_element_head"
                         "sexp_move_to_prev_element_tail" "sexp_move_to_next_element_tail"
                         "sexp_move_to_prev_top_element"  "sexp_move_to_next_top_element"
                         "sexp_select_prev_element"       "sexp_select_next_element"])]
    (let [lhs (. sexp_mappings plug)]
      (vim.keymap.set [:n :x :o] lhs (.. "<Plug>(" plug ")") {:buffer 0})))

  (each [_ plug (ipairs ["sexp_indent"              "sexp_indent_top"
                         "sexp_insert_at_list_head" "sexp_insert_at_list_tail"
                         "sexp_convolute"           "sexp_splice_list"])]
    (let [lhs (. sexp_mappings plug)]
      (vim.keymap.set [:n] lhs (.. "<Plug>(" plug ")") {:buffer 0})))

  (each [_ plug (ipairs ["sexp_round_head_wrap_list"     "sexp_round_tail_wrap_list"
                         "sexp_square_head_wrap_list"    "sexp_square_tail_wrap_list"
                         "sexp_curly_head_wrap_list"     "sexp_curly_tail_wrap_list"
                         "sexp_round_head_wrap_element"  "sexp_round_tail_wrap_element"
                         "sexp_square_head_wrap_element" "sexp_square_tail_wrap_element"
                         "sexp_curly_head_wrap_element"  "sexp_curly_tail_wrap_element"
                         "sexp_raise_list"               "sexp_raise_element"
                         "sexp_swap_list_backward"       "sexp_swap_list_forward"
                         "sexp_swap_element_backward"    "sexp_swap_element_forward"
                         "sexp_emit_head_element"        "sexp_emit_tail_element"
                         "sexp_capture_prev_element"     "sexp_capture_next_element"
                         "sexp_flow_to_prev_close"       "sexp_flow_to_next_open"
                         "sexp_flow_to_prev_open"        "sexp_flow_to_next_close"
                         "sexp_flow_to_prev_leaf_head"   "sexp_flow_to_next_leaf_head"
                         "sexp_flow_to_prev_leaf_tail"   "sexp_flow_to_next_leaf_tail"])]
    (let [lhs (. sexp_mappings plug)]
      (vim.keymap.set [:n :x] lhs (.. "<Plug>(" plug ")") {:buffer 0})))

  (when enable_insert_mode_mappings
    (vim.keymap.set :i "(" "<Plug>(sexp_insert_opening_round)" {:buffer 0})
    (vim.keymap.set :i "[" "<Plug>(sexp_insert_opening_square)" {:buffer 0})
    (vim.keymap.set :i "{" "<Plug>(sexp_insert_opening_curly)" {:buffer 0})
    (vim.keymap.set :i ")" "<Plug>(sexp_insert_closing_round)" {:buffer 0})
    (vim.keymap.set :i "]" "<Plug>(sexp_insert_closing_square)" {:buffer 0})
    (vim.keymap.set :i "}" "<Plug>(sexp_insert_closing_curly)" {:buffer 0})
    (vim.keymap.set :i "\"" "<Plug>(sexp_insert_double_quote)" {:buffer 0})
    (vim.keymap.set :i "<BS>" "<Plug>(sexp_insert_backspace)" {:buffer 0})))

(fn build-prefix [jump opmode]
  (.. ":<C-u>let b:sexp_count = v:count \\| "
      (if jump
        (.. "execute \"normal! " (if opmode "vv" "") "m`\" \\| ")
        "")))

(fn defplug [mode func expr repeat jump]
  (let [lhs (.. mode "noremap <silent> <Plug>(" func ")")
        opmode (= (string.sub mode 1 1) "o")
        prefix (build-prefix jump opmode)
        prefix (.. prefix "call " expr)
        repeat true]
        ; repeat (and repeat have-repeat-set)]

    (case [repeat opmode]
      [false _] (vim.api.nvim_command (.. lhs " " prefix "<CR>"))
      [true true] (vim.api.nvim_command (.. lhs " " prefix " \\| "
                                            "if v:operator ==? \"c\" \\| "
                                            "  call sexp#repeat_set(v:operator . \"\\<Plug>(" func ")\\<lt>C-r>.\\<lt>C-Bslash>\\<lt>C-n>\", b:sexp_count) \\| "
                                            "else \\| "
                                            "  call sexp#repeat_set(v:operator . \"\\<Plug>(" func ")\", b:sexp_count) \\| "
                                            "endif<CR>"))
      _ (vim.api.nvim_command (.. lhs " " prefix " \\| call sexp#repeat_set(\"\\<Plug>(" func ")\", b:sexp_count)<CR>")))
    ))

; 000: RHS as key press sequence
(fn defplug000 [modes func seq]
  (vim.keymap.set modes (.. "<Plug>(" func ")") seq))

; 100: RHS as expression, no repeat, jump
(fn defplug100 [mode func expr]
  (defplug mode func expr false true))

; 110: RHS as expression, repeat, jump
(fn defplug110 [mode func expr]
  (defplug mode func expr true true))

; 101: RHS as expression, no repeat, no jump
(fn defplug101 [mode func expr]
  (defplug mode func expr false false))

; 111: RHS as expression, repeat, no jump
(fn defplug111 [mode func expr]
  (defplug mode func expr true false))

(fn create-autocmd []
  ; Setup autocommand to create mappings for each sexp filetype
  (when (not= (string.len sexp_filetypes) 0)
    (vim.api.nvim_create_autocmd
      "FileType"
      {:pattern sexp_filetypes
       :group (vim.api.nvim_create_augroup :sexp-filetypes {:clear true})
       :callback create-mappings})
    ))

(fn setup [opts]
  ; TODO: Merge opts in
  (create-autocmd)

  ; Text Object Selections
  ; -- Current List (compount FORM)
  (defplug100 :x "sexp_outer_list" "sexp#docount(b:sexp_count, 'sexp#select_current_list', 'v', 0, 1)")
  (defplug110 :o "sexp_outer_list" "sexp#docount(b:sexp_count, 'sexp#select_current_list', 'o', 0, 1)")
  (defplug100 :x "sexp_inner_list" "sexp#docount(b:sexp_count, 'sexp#select_current_list', 'v', 1, 1)")
  (defplug110 :o "sexp_inner_list" "sexp#docount(b:sexp_count, 'sexp#select_current_list', 'o', 1, 1)")

  ; -- Current top-level list (compound FORM)
  (defplug100 :x "sexp_outer_top_list" "sexp#select_current_top_list('v', 0)")
  (defplug110 :o "sexp_outer_top_list" "sexp#select_current_top_list('o', 0)")
  (defplug100 :x "sexp_inner_top_list" "sexp#select_current_top_list('v', 1)")
  (defplug110 :o "sexp_inner_top_list" "sexp#select_current_top_list('o', 1)")

  ; -- Current string
  (defplug100 :x "sexp_outer_string" "sexp#select_current_string('v', 0)")
  (defplug110 :o "sexp_outer_string" "sexp#select_current_string('o', 0)")
  (defplug100 :x "sexp_inner_string" "sexp#select_current_string('v', 1)")
  (defplug110 :o "sexp_inner_string" "sexp#select_current_string('o', 1)")

  ; -- Current element
  (defplug100 :x "sexp_outer_element" "sexp#select_current_element('v', 0)")
  (defplug110 :o "sexp_outer_element" "sexp#select_current_element('o', 0)")
  (defplug100 :x "sexp_inner_element" "sexp#select_current_element('v', 1)")
  (defplug110 :o "sexp_inner_element" "sexp#select_current_element('o', 1)")

  ; Text Object Motions {{{1
  ; -- Nearest bracket
  (defplug100 :n "sexp_move_to_prev_bracket" "sexp#docount(b:sexp_count, 'sexp#move_to_nearest_bracket', 'n', 0)")
  (defplug000 :x "sexp_move_to_prev_bracket"
    "<Esc>:<C-u>call sexp#docount(v:prevcount, 'sexp#move_to_nearest_bracket', 'v', 0)<CR>")
  (defplug110 :o "sexp_move_to_prev_bracket" "sexp#move_to_nearest_bracket('o', 0)")
  (defplug100 :n "sexp_move_to_next_bracket" "sexp#docount(b:sexp_count, 'sexp#move_to_nearest_bracket', 'n', 1)")
  (defplug000 :x "sexp_move_to_next_bracket"
    "<Esc>:<C-u>call sexp#docount(v:prevcount, 'sexp#move_to_nearest_bracket', 'v', 1)<CR>")
  (defplug110 :o "sexp_move_to_next_bracket" "sexp#move_to_nearest_bracket('o', 1)")

  ; -- Adjacent element head
  ; Visual mappings must break out of visual mode in order to detect which end
  ;the user is using to adjust the selection.
  (defplug101 :n "sexp_move_to_prev_element_head" "sexp#move_to_adjacent_element('n', b:sexp_count, 0, 0, 0)")
  (defplug000 :x "sexp_move_to_prev_element_head"
    "<Esc>:<C-u>call sexp#move_to_adjacent_element('v', v:prevcount, 0, 0, 0)<CR>")
  (defplug111 :o "sexp_move_to_prev_element_head" "sexp#move_to_adjacent_element('o', b:sexp_count, 0, 0, 0)")
  (defplug101 :n "sexp_move_to_next_element_head" "sexp#move_to_adjacent_element('n', b:sexp_count, 1, 0, 0)")
  (defplug000 :x "sexp_move_to_next_element_head"
    "<Esc>:<C-u>call sexp#move_to_adjacent_element('v', v:prevcount, 1, 0, 0)<CR>")
  (defplug111 :o "sexp_move_to_next_element_head" "sexp#move_to_adjacent_element('o', b:sexp_count, 1, 0, 0)")

  ; -- Adjacent element tail
  ; Inclusive operator pending motions require a visual mode selection to
  ; include the last character of a line.
  (defplug101 :n "sexp_move_to_prev_element_tail" "sexp#move_to_adjacent_element('n', b:sexp_count, 0, 1, 0)")
  (defplug000 :x "sexp_move_to_prev_element_tail"
    "<Esc>:<C-u>call sexp#move_to_adjacent_element('v', v:prevcount, 0, 1, 0)<CR>")
  (defplug111 :o "sexp_move_to_prev_element_tail" "sexp#move_to_adjacent_element('o', b:sexp_count, 0, 1, 0)")
  (defplug101 :n "sexp_move_to_next_element_tail" "sexp#move_to_adjacent_element('n', b:sexp_count, 1, 1, 0)")
  (defplug000 :x "sexp_move_to_next_element_tail"
    "<Esc>:<C-u>call sexp#move_to_adjacent_element('v', v:prevcount, 1, 1, 0)<CR>")
  (defplug111 :o "sexp_move_to_next_element_tail" "sexp#move_to_adjacent_element('o', b:sexp_count, 1, 1, 0)")

  ; -- List flow commands
  (defplug100  :n "sexp_flow_to_prev_close" "sexp#list_flow('n', b:sexp_count, 0, 1)")
  (defplug000 :x "sexp_flow_to_prev_close"
    "<Esc>:<C-u>call sexp#list_flow('v', v:prevcount, 0, 1)<CR>")
  (defplug100  :n "sexp_flow_to_prev_open" "sexp#list_flow('n', b:sexp_count, 0, 0)")
  (defplug000 :x "sexp_flow_to_prev_open"
    "<Esc>:<C-u>call sexp#list_flow('v', v:prevcount, 0, 0)<CR>")
  (defplug100  :n "sexp_flow_to_next_open" "sexp#list_flow('n', b:sexp_count, 1, 0)")
  (defplug000 :x "sexp_flow_to_next_open"
    "<Esc>:<C-u>call sexp#list_flow('v', v:prevcount, 1, 0)<CR>")
  (defplug100  :n "sexp_flow_to_next_close" "sexp#list_flow('n', b:sexp_count, 1, 1)")
  (defplug000 :x "sexp_flow_to_next_close"
    "<Esc>:<C-u>call sexp#list_flow('v', v:prevcount, 1, 1)<CR>")

  ; -- Leaf flow commands
  (defplug101 :n "sexp_flow_to_prev_leaf_head" "sexp#leaf_flow('n', b:sexp_count, 0, 0)")
  (defplug000 :x "sexp_flow_to_prev_leaf_head"
    "<Esc>:<C-u>call sexp#leaf_flow('v', v:prevcount, 0, 0)<CR>")
  (defplug101 :n "sexp_flow_to_next_leaf_head" "sexp#leaf_flow('n', b:sexp_count, 1, 0)")
  (defplug000 :x "sexp_flow_to_next_leaf_head"
    "<Esc>:<C-u>call sexp#leaf_flow('v', v:prevcount, 1, 0)<CR>")
  (defplug101 :n "sexp_flow_to_prev_leaf_tail" "sexp#leaf_flow('n', b:sexp_count, 0, 1)")
  (defplug000 :x "sexp_flow_to_prev_leaf_tail"
    "<Esc>:<C-u>call sexp#leaf_flow('v', v:prevcount, 0, 1)<CR>")
  (defplug101 :n "sexp_flow_to_next_leaf_tail" "sexp#leaf_flow('n', b:sexp_count, 1, 1)")
  (defplug000 :x "sexp_flow_to_next_leaf_tail"
    "<Esc>:<C-u>call sexp#leaf_flow('v', v:prevcount, 1, 1)<CR>")

  ; -- Adjacent top element
  (defplug100 :n "sexp_move_to_prev_top_element" "sexp#move_to_adjacent_element('n', b:sexp_count, 0, 0, 1)")
  (defplug000 :x "sexp_move_to_prev_top_element"
    "<Esc>:<C-u>call sexp#move_to_adjacent_element('v', v:prevcount, 0, 0, 1)<CR>")
  (defplug110 :o "sexp_move_to_prev_top_element" "sexp#move_to_adjacent_element('o', b:sexp_count, 0, 0, 1)")
  (defplug100 :n "sexp_move_to_next_top_element" "sexp#move_to_adjacent_element('n', b:sexp_count, 1, 0, 1)")
  (defplug000 :x "sexp_move_to_next_top_element"
    "<Esc>:<C-u>call sexp#move_to_adjacent_element('v', v:prevcount, 1, 0, 1)<CR>")
  (defplug110 :o "sexp_move_to_next_top_element" "sexp#move_to_adjacent_element('o', b:sexp_count, 1, 0, 1)")

  ; -- Adjacent element selection
  ; Unlike the other directional motions, calling this from normal mode places
  ; us in visual mode, with the adjacent element as our selection.
  (defplug100 :n "sexp_select_prev_element" "sexp#docount(b:sexp_count, 'sexp#select_adjacent_element', 'n', 0)")
  (defplug100 :x "sexp_select_prev_element" "sexp#docount(b:sexp_count, 'sexp#select_adjacent_element', 'v', 0)")
  (defplug110 :o "sexp_select_prev_element" "sexp#docount(b:sexp_count, 'sexp#select_adjacent_element', 'o', 0)")
  (defplug100 :n "sexp_select_next_element" "sexp#docount(b:sexp_count, 'sexp#select_adjacent_element', 'n', 1)")
  (defplug100 :x "sexp_select_next_element" "sexp#docount(b:sexp_count, 'sexp#select_adjacent_element', 'v', 1)")
  (defplug110 :o "sexp_select_next_element" "sexp#docount(b:sexp_count, 'sexp#select_adjacent_element', 'o', 1)")

  ; Commands
  ; -- Indent S-Expression
  (defplug110 :n "sexp_indent"     "sexp#indent(0, b:sexp_count)")
  (defplug110 :n "sexp_indent_top" "sexp#indent(1, b:sexp_count)")

  ; -- Wrap list
  (defplug110 :n "sexp_round_head_wrap_list"  "sexp#wrap('f', '(', ')', 0, g:sexp_insert_after_wrap)")
  (defplug100 :x "sexp_round_head_wrap_list"  "sexp#wrap('v', '(', ')', 0, g:sexp_insert_after_wrap)")
  (defplug110 :n "sexp_round_tail_wrap_list"  "sexp#wrap('f', '(', ')', 1, g:sexp_insert_after_wrap)")
  (defplug100 :x "sexp_round_tail_wrap_list"  "sexp#wrap('v', '(', ')', 1, g:sexp_insert_after_wrap)")
  (defplug110 :n "sexp_square_head_wrap_list" "sexp#wrap('f', '[', ']', 0, g:sexp_insert_after_wrap)")
  (defplug100 :x "sexp_square_head_wrap_list" "sexp#wrap('v', '[', ']', 0, g:sexp_insert_after_wrap)")
  (defplug110 :n "sexp_square_tail_wrap_list" "sexp#wrap('f', '[', ']', 1, g:sexp_insert_after_wrap)")
  (defplug100 :x "sexp_square_tail_wrap_list" "sexp#wrap('v', '[', ']', 1, g:sexp_insert_after_wrap)")
  (defplug110 :n "sexp_curly_head_wrap_list"  "sexp#wrap('f', '{', '}', 0, g:sexp_insert_after_wrap)")
  (defplug100 :x "sexp_curly_head_wrap_list"  "sexp#wrap('v', '{', '}', 0, g:sexp_insert_after_wrap)")
  (defplug110 :n "sexp_curly_tail_wrap_list"  "sexp#wrap('f', '{', '}', 1, g:sexp_insert_after_wrap)")
  (defplug100 :x "sexp_curly_tail_wrap_list"  "sexp#wrap('v', '{', '}', 1, g:sexp_insert_after_wrap)")

  ; -- Wrap element
  (defplug110 :n "sexp_round_head_wrap_element"  "sexp#wrap('e', '(', ')', 0, g:sexp_insert_after_wrap)")
  (defplug100 :x "sexp_round_head_wrap_element"  "sexp#wrap('v', '(', ')', 0, g:sexp_insert_after_wrap)")
  (defplug110 :n "sexp_round_tail_wrap_element"  "sexp#wrap('e', '(', ')', 1, g:sexp_insert_after_wrap)")
  (defplug100 :x "sexp_round_tail_wrap_element"  "sexp#wrap('v', '(', ')', 1, g:sexp_insert_after_wrap)")
  (defplug110 :n "sexp_square_head_wrap_element" "sexp#wrap('e', '[', ']', 0, g:sexp_insert_after_wrap)")
  (defplug100 :x "sexp_square_head_wrap_element" "sexp#wrap('v', '[', ']', 0, g:sexp_insert_after_wrap)")
  (defplug110 :n "sexp_square_tail_wrap_element" "sexp#wrap('e', '[', ']', 1, g:sexp_insert_after_wrap)")
  (defplug100 :x "sexp_square_tail_wrap_element" "sexp#wrap('v', '[', ']', 1, g:sexp_insert_after_wrap)")
  (defplug110 :n "sexp_curly_head_wrap_element"  "sexp#wrap('e', '{', '}', 0, g:sexp_insert_after_wrap)")
  (defplug100 :x "sexp_curly_head_wrap_element"  "sexp#wrap('v', '{', '}', 0, g:sexp_insert_after_wrap)")
  (defplug110 :n "sexp_curly_tail_wrap_element"  "sexp#wrap('e', '{', '}', 1, g:sexp_insert_after_wrap)")
  (defplug100 :x "sexp_curly_tail_wrap_element"  "sexp#wrap('v', '{', '}', 1, g:sexp_insert_after_wrap)")

  ; -- Insert at list terminal
  (defplug110 :n "sexp_insert_at_list_head" "sexp#insert_at_list_terminal(0)")
  (defplug110 :n "sexp_insert_at_list_tail" "sexp#insert_at_list_terminal(1)")

  ; -- Raise list
  (defplug110 :n "sexp_raise_list"    "sexp#docount(b:sexp_count, 'sexp#raise', 'n', 'sexp#select_current_list', 'n', 0, 0)")
  (defplug100 :x "sexp_raise_list"    "sexp#docount(b:sexp_count, 'sexp#raise', 'v', '')")
  (defplug110 :n "sexp_raise_element" "sexp#docount(b:sexp_count, 'sexp#raise', 'n', 'sexp#select_current_element', 'n', 1)")
  (defplug100 :x "sexp_raise_element" "sexp#docount(b:sexp_count, 'sexp#raise', 'v', '')")

  ; -- Convolute
  ; Note: convolute takes pains to preserve cursor position: hence, 'nojump'.
  (defplug111 :n "sexp_convolute" "sexp#convolute(b:sexp_count, 'n')")

  ; -- Splice list
  (defplug110 :n "sexp_splice_list" "sexp#splice_list(b:sexp_count)")

  ; -- Swap list
  (defplug110 :n "sexp_swap_list_backward" "sexp#docount(b:sexp_count, 'sexp#swap_element', 'n', 0, 1)")
  (defplug110 :n "sexp_swap_list_forward"  "sexp#docount(b:sexp_count, 'sexp#swap_element', 'n', 1, 1)")
  (defplug000 :x "sexp_swap_list_forward"
    "<Esc>:<C-u>call sexp#docount(v:prevcount, 'sexp#swap_element', 'v', 1, 1)<CR>")

  ; -- Swap element
  (defplug110 :n "sexp_swap_element_backward" "sexp#docount(b:sexp_count, 'sexp#swap_element', 'n', 0, 0)")
  (defplug000 :x "sexp_swap_element_backward"
    "<Esc>:<C-u>call sexp#docount(v:prevcount, 'sexp#swap_element', 'v', 0, 0)<CR>")
  (defplug110 :n "sexp_swap_element_forward"  "sexp#docount(b:sexp_count, 'sexp#swap_element', 'n', 1, 0)")
  (defplug000 :x "sexp_swap_element_forward"
    "<Esc>:<C-u>call sexp#docount(v:prevcount, 'sexp#swap_element', 'v', 1, 0)<CR>")

  ; -- Emit/capture element
  (defplug110 :n "sexp_emit_head_element"    "sexp#docount(b:sexp_count, 'sexp#stackop', 'n', 0, 0)")
  (defplug100 :x "sexp_emit_head_element"    "sexp#docount(b:sexp_count, 'sexp#stackop', 'v', 0, 0)")
  (defplug110 :n "sexp_emit_tail_element"    "sexp#docount(b:sexp_count, 'sexp#stackop', 'n', 1, 0)")
  (defplug100 :x "sexp_emit_tail_element"    "sexp#docount(b:sexp_count, 'sexp#stackop', 'v', 1, 0)")
  (defplug110 :n "sexp_capture_prev_element" "sexp#docount(b:sexp_count, 'sexp#stackop', 'n', 0, 1)")
  (defplug100 :x "sexp_capture_prev_element" "sexp#docount(b:sexp_count, 'sexp#stackop', 'v', 0, 1)")
  (defplug110 :n "sexp_capture_next_element" "sexp#docount(b:sexp_count, 'sexp#stackop', 'n', 1, 1)")
  (defplug100 :x "sexp_capture_next_element" "sexp#docount(b:sexp_count, 'sexp#stackop', 'v', 1, 1)")

  ; Insert mode mappings
  ; -- Insert opening delimiter
  (imapexpr "<Plug>(sexp_insert_opening_round)" "sexp#opening_insertion('(')")
  (imapexpr "<Plug>(sexp_insert_opening_square)" "sexp#opening_insertion('[')")
  (imapexpr "<Plug>(sexp_insert_opening_curly)" "sexp#opening_insertion('{')")
  ; -- Insert closing delimiter
  (imapexpr "<Plug>(sexp_insert_closing_round)" "sexp#closing_insertion(')')")
  (imapexpr "<Plug>(sexp_insert_closing_square)" "sexp#closing_insertion(']')")
  (imapexpr "<Plug>(sexp_insert_closing_curly)" "sexp#closing_insertion('}')")
  ; -- Insert double quote
  (imapexpr "<Plug>(sexp_insert_double_quote)" "sexp#quote_insertion('\"')")
  ; -- Delete paired delimiters
  (imapexpr "<Plug>(sexp_insert_backspace)" "sexp#backspace_insertion()")
)

{: setup}
