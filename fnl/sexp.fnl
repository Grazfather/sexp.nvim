;                                                                   o8o
;                                                                   '"'
;   .oooo.o  .ooooo. oooo    ooooo.ooooo.    ooo. .oo.  oooo    ooooooo ooo. .oo.  .oo.
;  d88(  "8 d88' `88b `88b..8P'  888' `88b   `888P"Y88b  `88.  .8' `888 `888P"Y88bP"Y88b
;  `"Y88b.  888ooo888   Y888'    888   888    888   888   `88..8'   888  888   888   888
;  o.  )88b 888    .o .o8"'88b   888   888    888   888    `888'    888  888   888   888
;  8""888P' `Y8bod8P'o88'   888o 888bod8P' o o888o o888o    `8'    o888oo888o o888o o888o
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
  (create-autocmd))


{
 ; Temp exports

 ; Real exports
 : setup}
