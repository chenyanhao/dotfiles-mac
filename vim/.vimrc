
"============================== start =======================================
" 处理各个操作系统之间、命令行和GUI之间的差异性配置
" -----------------------------------------------------------------------------
"  < 判断操作系统是否是 Windows 还是 Linux >
" -----------------------------------------------------------------------------
let g:isWindows = 0
let g:isMac = 0
let g:isLinux = 0
if (has("win32") || has("win64") || has("win95") || has("win16"))
    let g:isWindows = 1
elseif (has("mac"))
    let g:isMac = 1
else
    let g:isLinux = 1
endif



" -----------------------------------------------------------------------------
"  < 判断是终端还是 Gvim >
" -----------------------------------------------------------------------------
let g:isGUI = 0
if has("gui_running")
    let g:isGUI = 1
else
    let g:isGUI = 0
endif
  


if (g:isWindows == 1) && (g:isGUI == 1) 
    " 格式为，字体类型：字体大小：字符集：显示质量，例如，Consolas:h12:cGB2312:qDRAFT
    set guifont=Consolas:h12
endif

"========================== end ===========================================



"=============================Vim-Plugin start ===============================
call plug#begin('~/.vim/plugged') " plugin managemant: vim-plug
Plug 'colepeters/spacemacs-theme.vim' " theme of spaceemacs
Plug 'terryma/vim-expand-region' 
Plug 'tpope/vim-surround'

 " The Vim plugin will pick up fzf binary available on the system. fzf#install() is optional, it makes sure that you have the latest binary
Plug 'junegunn/fzf' , { 'do': { -> fzf#install() } }
" Plug 'junegunn/fzf' 
 " 注意 fzf.vim 实际上是 fzf 的一个 vim 前端，因此和 fzf 要一起安装才可以使用。fzf.vim 使得使用方式学习成本更低。fzf 直接使用具有一定的学习成本。
Plug 'junegunn/fzf.vim'

Plug 'Yggdroot/LeaderF' " leaderf 和 fzf 各有所长，配合使用。Windows 下 fzf 安装不便的话，可以用 leaderf。注意，leaderf 依赖 python，如果 vim 版本没有 python 支持，推荐用fzf

Plug 'scrooloose/nerdtree' " 树形目录
Plug 'xuyuanp/nerdtree-git-plugin' " nerdtree 中显示出文件的修改状态，开箱即用
Plug 'vim-airline/vim-airline'
Plug 'easymotion/vim-easymotion'
Plug 'terryma/vim-multiple-cursors'
Plug 'preservim/nerdcommenter'
call plug#end()
"=============================Vim-Plugin start ===============================



"=============================插件相关 start ===============================
" --------- theme --------
colorscheme spacemacs-theme

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

" --------- fzf  --------
let g:fzf_layout = {'down': '~40%'}

" --------- alrline  --------
" tabline注意分清tab和buffer，它既会显示tab，也会显示buffer。配置时注意区分清楚
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#formatter = 'unique_tail' " 显示标签的样式为只显示文件名
let g:airline#extensions#tabline#buffer_nr_show = 1 " tabline中buffer显示编号，然后输入命令 `:b num` 即可跳转到编号为num的buffer


" --------- vim-expand-region  --------
vmap v <Plug>(expand_region_expand)
vmap V <Plug>(expand_region_shrink)

"=============================插件相关 end  ===============================



"========================== start ===========================================
"    Vim最最最基本配置
"    Better-Defaults
"    
"
"————————————————— start —————————————————————
"关闭vi的一致性模式 避免以前版本的一些Bug和局限
set nocompatible

"配置backspace键工作方式
set backspace=indent,eol,start

" vim 自身命令行模式智能补全
set wildmenu

"显示行号
set number

"设置在编辑过程中右下角显示光标的行列信息
set ruler

"在状态栏显示正在输入的命令
set showcmd

"设置历史记录条数
set history=25

"设置取消备份 禁止临时文件生成
set nobackup
set noswapfile

" 允许在有未保存的修改时切换缓冲区，此时的修改由 vim 负责保存
set hidden

" 高亮显示当前行/列
set cursorline
" set cursorcolumn

"设置C/C++方式自动对齐
set autoindent
set cindent

"开启语法高亮功能
syntax enable
" 允许用指定语法高亮配色方案替换默认方案
syntax on

"指定配色方案为256色
set t_Co=256


" 禁止显示滚动条
" set guioptions-=l
" set guioptions-=L
" set guioptions-=r
" set guioptions-=R
" 禁止显示菜单和工具条
set guioptions-=m
set guioptions-=T

" 总是显示状态栏
set laststatus=2



" 让配置变更立即生效
autocmd BufWritePost $MYVIMRC source $MYVIMRC


" 开启实时搜索功能，即输入内容时就显示搜索结果
set incsearch
"设置搜索时忽略大小写
set ignorecase
"设置搜索时高亮匹配项
set hlsearch

" 禁止光标闪烁
set gcr=a:block-blinkon0

" 配置光标形状
set guicursor=n-v-c:block " normal-visual-command mode, use block style cursor
set guicursor+=i-ci:ver30 " insert or Command-line insert mode, user ver style cursor
set guicursor+=r-cr:hor30 " replace or Command-Line replace mode, user hor style cursor


"设置鼠标可用
set mouse=a

" 共享外部剪切板
set clipboard=unnamed
set clipboard=unnamedplus

" 设置编辑时制表符占用空格数
set tabstop=4

" 设置格式化时制表符占用空格数
set shiftwidth=4

"让 vim 把连续数量的空格视为一个制表符，这样按退格键时可以一次删除 4 个空格
set softtabstop=4
"设置按退格键时可以一次删除4个空格
set smarttab

"将Tab键自动转换成空格 真正需要Tab键时使用[Ctrl + V + Tab]
set expandtab

"设置编码方式
set encoding=utf-8
"自动判断编码时 依次尝试一下编码
set fileencodings=ucs-bom,utf-8,utf-16,gbk,big5,gb18030,latin1
set termencoding=utf-8

" 检测文件类型
filetype on
" 针对不同的文件采用不同的缩进方式
filetype indent on
" 允许插件
filetype plugin on
" 启动智能补全
filetype plugin indent on

" 基于缩进或语法进行代码折叠  
" 操作：za，打开或关闭当前折叠；zM，关闭所有折叠；zR，打开所有折叠。
"set foldmethod=indent
set foldmethod=syntax
" 启动 vim 时关闭折叠代码
set nofoldenable


set smartindent


" set auto-indenting on for programming
set ai          
 
" automatically show matching brackets. works like it does in bbedit.               
set showmatch  

" turn on the "visual bell" - which is much quieter than the "audio blink"                 
set vb 

" show the current mode                         
set showmode                   
"———————————————— end ——————————————————————



"——————————————— start ———————————————————————
"add by cyh 2016/5/31


" 定义快捷键的前缀，即<Leader>
let mapleader = "\<Space>"

" noremap <space> :


" 水平切分分屏
nnoremap <leader>w- :sp<CR>  " <C-w>s 也可以
" 竖直切分分屏
nnoremap <leader>w/ :vsp<CR> " <C-w>v 也可以


nnoremap <s-up> <C-w>+    " 纵向变长
nnoremap <s-down> <C-w>-  " 纵向变短
nnoremap <s-right> <C-w>> " 往右
nnoremap <s-left> <C-w><  " 往左
nnoremap <C-w> <C-w><C-w>  " 切换窗口


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

nnoremap <C-a> ggvG


" 设置tab键切换 buffer
nmap <TAB> :bn<cr>
nmap <C-TAB> :bp<cr>  

"above add by cyh
"————————————————— end —————————————————————

"========================== end ===========================================





