vim.cmd [[
try
  colorscheme dracula
  highlight Normal ctermbg=none
" colorscheme gruvbox
catch /^Vim\%((\a\+)\)\=:E185/
  colorscheme default
  set background=dark
endtry
]]
