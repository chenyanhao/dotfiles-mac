
"设置取消备份 禁止临时文件生成
set nobackup
set noswapfile

"显示行号
set number

" 高亮显示当前行
set cursorline

"设置鼠标可用
set mouse=a         	

"设置按退格键时可以一次删除4个空格，即 hungry-delete
set smarttab 

" 设置格式化时制表符占用空格数，默认为 8
set shiftwidth=4

" 共享外部剪切板
set clipboard=unnamed


" 定义快捷键的前缀，即<Leader>
let mapleader = "\<Space>"

" noremap <space> :

" 水平切分分屏
nnoremap <leader>w- :sp<CR>  " <C-w>s 也可以
" 竖直切分分屏
nnoremap <leader>w/ :vsp<CR> " <C-w>v 也可以

nnoremap w+ <C-w>+
nnoremap w- <C-w>-
nnoremap w> <C-w>>
nnoremap w< <C-w><
nnoremap <leader>ww <C-w><C-w>  " 切换窗口

" 在 insert 和 command 下可以使用 EMACS 快捷键
" moving aroung in insert mode
inoremap <C-p> <Up>
inoremap <C-n> <Down>
inoremap <C-b> <Left>
inoremap <C-f> <Right>
inoremap <C-a> <Home>
inoremap <C-e> <End>

" moving aroung in command mode
cnoremap <C-p> <Up>
cnoremap <C-n> <Down>
cnoremap <C-b> <Left>
cnoremap <C-f> <Right>
cnoremap <C-a> <Home>
cnoremap <C-e> <End>

" C-c C-v to yank and pull。
" 输入不可见字符时需要先输入前导键 C-v，如果这里设置 C-v 是粘贴，则会冲突，自行取舍
" vnoremap <C-c> "+y
" map <C-v> "+p
" imap <C-v> <ESC>"+pa
" vmap <C-v> d"+p

" 支持 C-a 全选
nnoremap <C-a> ggvG


" 设置tab键切换 buffer
nmap <TAB> :bn<cr>
nmap <C-TAB> :bp<cr> 



" 水平分屏打开内置终端
nnoremap <leader>t-    :sp term://$SHELL<CR>
" 竖直分屏打开内置终端
nnoremap <leader>t/    :vsp term://$SHELL<CR>
" 由终端模式退回到 normal 模式
tnoremap <leader>tn    <C-\><C-n>
" 直接退出终端模式并退出(e-exit)终端窗口
tnoremap <leader>te    <C-\><C-n> :q!<CR>



call plug#begin()
Plug 'terryma/vim-expand-region' 
Plug 'tpope/vim-surround'
Plug 'scrooloose/nerdtree' 
Plug 'xuyuanp/nerdtree-git-plugin' 
Plug 'preservim/nerdcommenter'
Plug 'vim-airline/vim-airline'
Plug 'easymotion/vim-easymotion'
Plug 'terryma/vim-multiple-cursors'
Plug 'Yggdroot/LeaderF'
call plug#end()



"=============================插件相关 start ===============================
" --------- nerdcommenter --------
" add spaces after comment delimiters
let g:NERDSpaceDelims = 1
" use compact syntax for prettified multi-line comments
let g:NERDCompactSexyComs = 1
" show hidden file
let NERDTreeShowHidden=1


" --------- nerdtree  --------
" open NERDTree automatically when vim starts up
autocmd vimenter * NERDTree


" --------- leaderF  --------
" 悬浮窗口展示
let g:Lf_WindowPosition = 'popup'
" 展示预览
let g:Lf_PreviewInPopup = 1


" --------- vim-expand-region  --------
vmap v <Plug>(expand_region_expand)
vmap V <Plug>(expand_region_shrink)

"=============================插件相关 end  ===============================

