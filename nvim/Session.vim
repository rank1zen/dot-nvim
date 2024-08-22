let SessionLoad = 1
let s:so_save = &g:so | let s:siso_save = &g:siso | setg so=0 siso=0 | setl so=-1 siso=-1
let v:this_session=expand("<sfile>:p")
silent only
silent tabonly
cd ~/dotfiles/nvim
if expand('%') == '' && !&modified && line('$') <= 1 && getline(1) == ''
  let s:wipebuf = bufnr('%')
endif
let s:shortmess_save = &shortmess
if &shortmess =~ 'A'
  set shortmess=aoOA
else
  set shortmess=aoO
endif
badd +58 lua/core/mappings-leader.lua
badd +40 lua/core/functions.lua
badd +229 init.lua
badd +141 lua/core/plugins/orgmode.lua
badd +1 after/ftplugin/org.lua
badd +40 ~/Dropbox/org/uni.org
badd +1 colors/zoom.lua
badd +26 ~/Dropbox/org/configs.org
badd +348 ~/.local/share/nvim/site/pack/deps/start/mini.nvim/lua/mini/hues.lua
badd +3 ~/Dropbox/org/refile.org
badd +1 ~/Dropbox/org/things.org
badd +1 a
badd +42 lua/core/plugins/nvim-lspconfig.lua
badd +1 lua/core/mappings.lua
badd +1 after/ftplugin/templ.lua
badd +1 after/ftplugin/sql.lua
badd +2 after/ftplugin/go.lua
badd +28 ~/.local/share/nvim/site/pack/deps/opt/nvim-lspconfig/lua/lspconfig/ui/windows.lua
badd +1 ~/yujin/internal/postgres/summonerv4.model.go
badd +1 lua/core/plugins/nvim-treesitter.lua
badd +1 lua/core/plugins/conform.lua
badd +1 lua/core/settings.lua
badd +1074 ~/.local/share/nvim/site/pack/deps/start/mini.nvim/lua/mini/visits.lua
badd +1 man://setup(2)
argglobal
%argdel
edit init.lua
argglobal
balt lua/core/functions.lua
setlocal fdm=manual
setlocal fde=0
setlocal fmr={{{,}}}
setlocal fdi=#
setlocal fdl=0
setlocal fml=1
setlocal fdn=20
setlocal fen
silent! normal! zE
let &fdl = &fdl
let s:l = 20 - ((3 * winheight(0) + 26) / 52)
if s:l < 1 | let s:l = 1 | endif
keepjumps exe s:l
normal! zt
keepjumps 20
normal! 0
tabnext 1
if exists('s:wipebuf') && len(win_findbuf(s:wipebuf)) == 0 && getbufvar(s:wipebuf, '&buftype') isnot# 'terminal'
  silent exe 'bwipe ' . s:wipebuf
endif
unlet! s:wipebuf
set winheight=1 winwidth=20
let &shortmess = s:shortmess_save
let s:sx = expand("<sfile>:p:r")."x.vim"
if filereadable(s:sx)
  exe "source " . fnameescape(s:sx)
endif
let &g:so = s:so_save | let &g:siso = s:siso_save
set hlsearch
nohlsearch
doautoall SessionLoadPost
unlet SessionLoad
" vim: set ft=vim :
