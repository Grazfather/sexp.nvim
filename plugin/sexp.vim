
"              o8o
"              '"'
"  oooo    ooooooo ooo. .oo.  .oo.        .oooo.o  .ooooo. oooo    ooooo.ooooo.
"   `88.  .8' `888 `888P"Y88bP"Y88b      d88(  "8 d88' `88b `88b..8P'  888' `88b
"    `88..8'   888  888   888   888 8888 `"Y88b.  888ooo888   Y888'    888   888
"     `888'    888  888   888   888      o.  )88b 888    .o .o8"'88b   888   888
"      `8'    o888oo888o o888o o888o     8""888P' `Y8bod8P'o88'   888o 888bod8P'
"                                                                      888
"                                                                     o888o
"  Author:   guns <self@sungpae.com>
"  License:  MIT
"  Homepage: https://github.com/guns/vim-sexp

if exists('g:sexp_loaded')
    finish
endif
let g:sexp_loaded = 1

""" Global State {{{1

if !exists('g:sexp_insert_after_wrap')
    let g:sexp_insert_after_wrap = 1
endif

""" Functions {{{1


" Calls repeat#set() and registers a one-time CursorMoved handler to correctly
" set the value of g:repeat_tick.
"
" cf. https://github.com/tpope/vim-repeat/issues/8#issuecomment-13951082
function! sexp#repeat_set(buf, count)
    call repeat#set(a:buf, a:count)
    augroup sexp_repeat
        autocmd!
        autocmd CursorMoved <buffer> let g:repeat_tick = b:changedtick | autocmd! sexp_repeat
    augroup END
endfunction
