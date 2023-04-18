local sexp_filetypes = "clojure,scheme,lisp,timl,fennel"
local function sexp_create_mappings(a, b)
  return vim.call("sexp#sexp_create_mappings")
end
local function create_autocmd()
  if (string.len(sexp_filetypes) ~= 0) then
    return vim.api.nvim_create_autocmd("FileType", {pattern = sexp_filetypes, group = vim.api.nvim_create_augroup("sexp-filetypes", {clear = true}), callback = sexp_create_mappings})
  else
    return nil
  end
end
local function setup(opts)
  print("setup")
  return create_autocmd()
end
return {setup = setup}
