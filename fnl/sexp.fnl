;              o8o
;              '"'
;  oooo    ooooooo ooo. .oo.  .oo.        .oooo.o  .ooooo. oooo    ooooo.ooooo.
;   `88.  .8' `888 `888P"Y88bP"Y88b      d88(  "8 d88' `88b `88b..8P'  888' `88b
;    `88..8'   888  888   888   888 8888 `"Y88b.  888ooo888   Y888'    888   888
;     `888'    888  888   888   888      o.  )88b 888    .o .o8"'88b   888   888
;      `8'    o888oo888o o888o o888o     8""888P' `Y8bod8P'o88'   888o 888bod8P'  .nvim
;                                                                      888
;                                                                     o888o
;  Author:   guns <self@sungpae.com>
;            Ported by Grazfather <grazfather@gmail.com>
;  License:  MIT
;  Homepage: https://github.com/Grazfather/vim-sexp.nvim

; TODO: Put into a config map and let setup override these
(var sexp_filetypes "clojure,scheme,lisp,timl,fennel")

(fn sexp-create-mappings [a b]
  (vim.call "sexp#sexp_create_mappings")
)

(fn create-autocmd []
  ; Setup autocommand to create mappings for each sexp filetype
  (when (not= (string.len sexp_filetypes) 0)
    (vim.api.nvim_create_autocmd
      "FileType"
      {:pattern sexp_filetypes
       :group (vim.api.nvim_create_augroup :sexp-filetypes {:clear true})
       :callback sexp-create-mappings})
    ))

(fn setup [opts]
  (print "setup")
  (create-autocmd)
  ; (sexp-create-mappings)
  )


{: setup}
