" vim: set et sw=4 ts=4 sts=4 fdm=marker ff=unix fenc=utf8
"
" hunter 的 VIM 配置文件
"
"   author: hunter<tangbao1113@gmail.com>
"     date: 2010-10-13
"快捷键：逗号+空格 关闭search后的高亮 noh
"快捷键：F5 运行python程序
"快捷键：F3 打开taglist
"快捷键：F4 打开NERDTree
au BufRead *.py map <buffer> :w<CR> :!/usr/bin/env python %<CR>
"设置显示Tab键
set listchars=tab:>-,trail:-
set list
"运行Python脚本的按键映射
map <F5> :!"python" %<CR>
" 获得当前目录
function! CurrectDir()
	return substitute(getcwd(), "", "", "g")
endfunction

" 跳过页头注释，到首行实际代码
func! GotoFirstEffectiveLine()
  let l:c = 0
  while l:c<line("$") && (
        \ getline(l:c) =~ '^\s*$'
        \ || synIDattr(synID(l:c, 1, 0), "name") =~ ".*Comment.*"
        \ || synIDattr(synID(l:c, 1, 0), "name") =~ ".*PreProc$"
        \ )
    let l:c = l:c+1
  endwhile
  exe "normal ".l:c."Gz\<CR>"
endf

"修改切换窗口的快捷键
map <c-j> <c-w>j
map <c-k> <c-w>k
map <c-l> <c-w>l
map <c-h> <c-w>h
" 返回当前时间
func! GetTimeInfo()
    return strftime('%Y-%m-%d %A %H:%M:%S')
endfunction


" =========
" 环境配置
" =========
" 保留历史记录
set history=400

" 行控制
set nocompatible  "不兼容 vi
set whichwrap+=<,>,h,l "光标移动
set textwidth=80 "自动换行

" 标签页
"set tabpagemax=8
"set showtabline=2

" 控制台响铃
"set noerrorbells
"set novisualbell
"set t_vb= "close visual bell
"set mat=2
" 减少刷新和重画
set lz

" set magic on
set magic

" 修改 leader 键的快捷键
let mapleader = ","
let g:mapleader = ","

" 快速保存
nmap <leader>w :w!<cr>
nmap <leader>f :find<cr>

" 行号和标尺
set number
set ruler
set rulerformat=%15(%c%V\ %p%%%)

" 命令行于状态行
set ch=1
set statusline=\ [File]\ %F%m%r%h%y[%{&fileformat},%{&fileencoding}]\ %w\ \ [PWD]\ %r%{CurrectDir()}%h\ %=\ [Line]%l/%L\ %=\[%P]
set ls=2 " 始终显示状态行

" 搜索
set hlsearch
set showmatch
set mat=2
set incsearch

" 默认添加/g
"set gdefault

" 制表符
set tabstop=4
set expandtab
set smarttab
set shiftwidth=4
set softtabstop=4

" 状态栏显示目前所执行的指令
set showcmd



" 缩进
set autoindent
set smartindent

" 自动重新读入
set autoread

" 插入模式下使用 <BS>、<Del> <C-W> <C-U>
set backspace=indent,eol,start

" 设定在任何模式下鼠标都可用
"set mouse=a
"set selection=exclusive
"set selectmode=mouse,key

" 备份和缓存
set nobackup
set noswapfile
set nowritebackup

" 自动完成
set complete=.,w,b,u,t,i,k
set completeopt=longest,menu

" 代码折叠
set foldmethod=manual

" 保证语法高亮
syntax on
hi Comment ctermfg =blue

" should not break clone
set wildignore+=.git

" 中文帮助
set helplang=cn

" 搜索时忽略大小写
set ignorecase
set smartcase

" 当 buff 被丢弃时隐藏它
set bufhidden=hide


" 通过使用: commands命令，告诉我们文件的哪一行被改变过
set report=0

" 在被分割的窗口间显示空白，便于阅读
"set fillchars=vert:\ ,stl:\ ,stlnc:\

" 光标移动到buffer的顶部和底部时保持3行距离
set scrolloff=3

" 自动格式化
set formatoptions=tcrqn

" 去除工具栏
set go-=T

" 用空格键来开关折叠
set foldenable
nnoremap <space> @=((foldclosed(line('.')) < 0) ? 'zc' : 'zo')<CR>

" =====================
" 配置多语言环境
" 默认为 UTF-8 编码
" =====================
if has("multi_byte")
    set encoding=utf-8
    " English messages only
    "language messages zh_CN.utf-8

    if has('win32')
        language english
        let &termencoding=&encoding
    endif

    set fencs=utf-8,gbk,chinese,latin1
    set formatoptions+=mM
    set nobomb " 不使用 Unicode 签名

    if v:lang =~? '^\(zh\)\|\(ja\)\|\(ko\)'
        set ambiwidth=double
    endif
else
    echoerr "Sorry, this version of (g)vim was not compiled with +multi_byte"
endif

" =========
" AutoCmd
" =========
if has("autocmd")
    filetype plugin indent on
    
    "" 括号自动补全
    "func! AutoClose()
        ":inoremap ( ()<ESC>i
        ":inoremap " ""<ESC>i
        ":inoremap ' ''<ESC>i
        ":inoremap { {}<ESC>i
        ":inoremap [ []<ESC>i
        ":inoremap ) <c-r>=ClosePair(')')<CR>
        ":inoremap } <c-r>=ClosePair('}')<CR>
        ":inoremap ] <c-r>=ClosePair(']')<CR>
    "endf

    "function! ClosePair(char)
        "if getline('.')[col('.') - 1] == a:char
            "return "\<Right>"
        "else
            "return a:char
        "endif
    "endf

    "augroup vimrcEx
        "au!
        "autocmd FileType text setlocal textwidth=80
        "autocmd BufReadPost *
                    "\ if line("'\"") > 0 && line("'\"") <= line("$") |
                    "\   exe "normal g`\"" |
                    "\ endif
    "augroup END

    " make ; do the same thing as :
    nnoremap ; :

    " strip all trailing whitespace in the current file
    nnoremap <leader>W :%s/\s\+$//<cr>:let @/=''<CR>

    "clear search
    nnoremap <leader><space> :noh<cr>

    " fold tag
    nnoremap <leader>ft Vatzf

    " reselect the text that was just pasted
    nnoremap <leader>v V`]

    " quickly open up my vimrc file
    nnoremap <leader>ev <C-w><C-v><C-l>:e $MYVIMRC<cr>

    " return to normal mode by jj
    inoremap jj <ESC>
    
    " split windows
    nnoremap <leader>w <C-w>v<C-w>l

    
    " JavaScript 语法高亮
    au FileType html,javascript let g:javascript_enable_domhtmlcss = 1

    au FileType javascript set omnifunc=javascriptcomplete#CompleteJS
    
    " 增加 ActionScript 语法支持
    au BufNewFile,BufRead,BufEnter,WinEnter,FileType *.as setf actionscript 

    " 增加 Objective-C 语法支持
    au BufNewFile,BufRead,BufEnter,WinEnter,FileType *.m,*.h setf objc
    
    " 给各语言文件添加 Dict
    if has('win32')
        au FileType php setlocal dict+=$VIM/vimfiles/dict/php_funclist.dict
        au FileType css setlocal dict+=$VIM/vimfiles/dict/css.dict
        au FileType javascript setlocal dict+=$VIM/vimfiles/dict/javascript.dict
    else
        au FileType php setlocal dict+=~/.vim/dict/php_funclist.dict
        au FileType css setlocal dict+=~/.vim/dict/css.dict
        au FileType javascript setlocal dict+=~/.vim/dict/javascript.dict
    endif

endif

" =========
" 图形界面
" =========
if has('gui_running')
    " 只显示菜单
    set guioptions=mcr

    if has('gui_macvim')
        set guioptions+=e
    endif

    " 高亮光标所在的行
    set cursorline

    " 编辑器配色
     "colorschem morning 

    if has("gui_macvim")
        set guifont=YaHei\ Consolas\ Hybrid:h16
        set guifontwide=YaHei\ Consolas\ Hybrid:h16
        set confirm

        set lines=28 columns=108
        set macmeta

        let s:lines=&lines
        let s:columns=&columns
        func! FullScreenEnter()
            set lines=999 columns=999
            set fu
        endf

        " Set QuickTemplatePath
        let g:QuickTemplatePath = $HOME.'/.vim/templates/'

        " 如果为空文件，则自动设置当前目录为桌面
        lcd ~/Desktop/

        " 自动切换到文件当前目录
        set autochdir
    endif
endif

" =========
" 快捷键
" =========

" 标签相关的快捷键
map tn :tabnext<cr>
map tp :tabprevious<cr>
map td :tabnew <cr>
map te :tabedit
map tc :tabclose<cr>

" Map space to / (search)
map <space> /

"Switch to current dir
map <leader>cd :cd %:p:h<cr>



" 直接看代码
nmap <C-c><C-f> :call GotoFirstEffectiveLine()<cr>
            
" 按下 Q 不进入 Ex 模式，而是退出
nmap Q :x<cr

" 使用 tab 及 shift-tab 进行缩排
nmap <tab> V>
nmap <s-tab> V<
vmap <tab> >gv
vmap <s-tab> <gv
autocmd BufNewFile *.py 0r ~/.vim/template/pythonconfig.py
autocmd BufNewFile *.html 0r ~/.vim/template/htmlconfig.html
" 映射光标控制
imap <M-h> <Left>
imap <M-j> <Down>
imap <M-k> <Up>
imap <M-l> <Right>

" 开关 tags 窗口
map <F3> :TlistToggle<CR>

" =========
" 插件
" =========

" html, css校验
autocmd FileType html,xhtml,css nmap <F3> :make<cr><cr>:copen<cr>

" 自动完成设置 禁止在插入模式移动的时候出现 Complete 提示
let g:acp_completeOption='.,w,b,u,t,i,k'
let g:acp_mappingDriven = 1
let g:acp_behaviorSnipmateLength = 1



" ===========
" 其它
" ===========

"修改 vmirc 后自动生效
map <leader>s :source ~/.vimrc<cr>
autocmd! bufwritepost .vimrc source ~/.vimrc

" Rainbows!修改括号的颜色
nmap <leader>R :RainbowParenthesesToggle<CR>

"输入,e命令时,后面跟上当前目录结果
if has("unix")
	map ,e :e <C-R>=expand("\%:p:h") . "/" <CR>
else
	map ,e :e <C-R>=expand("\%:p:h") . "\\" <CR>
endif
	
"输入,c命令时,后面跟上当前目录结果
if has("unix")
	map ,c :cd <C-R>=expand("\%:p:h") . "/" <CR>
else
	map ,c :cd <C-R>=expand("\%:p:h") . "\\" <CR>
endif

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Vundle init
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
let root = '~/.vim/bundle'
if !isdirectory(expand(root).'/vundle')
  exec '!git clone http://github.com/gmarik/vundle.git '.root.'/vundle'
endif

filetype off                   " required!
set rtp+=~/.vim/bundle/vundle/
call vundle#rc()

" let Vundle manage Vundle
" required! 
Bundle 'gmarik/vundle'

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Plugin configuration
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" from github
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
Bundle 'tpope/vim-fugitive'
Bundle 'chrisbra/histwin.vim'
Bundle 'msanders/snipmate.vim'
Bundle 'rstacruz/sparkup', {'rtp': 'vim/'}

" Haml
Bundle "tpope/vim-haml"

" Tag List
Bundle "vim-scripts/taglist.vim"
let Tlist_Ctags_Cmd='/usr/bin/ctags'
let Tlist_Show_One_File=1
let Tlist_Exit_OnlyWindow=1
let Tlist_Use_Right_Window=1

" NerdTree
Bundle "wycats/nerdtree"
let NERDTreeIgnore=['\.pyc$', '\.rbc$', '\~$']
noremap <F4> :NERDTreeToggle<CR>
"配置NERD Tree 文件浏览器"
let NERDTreeWinPos = "left" "where NERD tree window is placed on the screen
let NERDTreeWinSize = 30 "size of the NERD tree

" NerdCommenter
Bundle "ddollar/nerdcommenter"

Bundle "hallettj/jslint.vim"
nmap <leader>jc :JSLintToggle<cr>
let g:JSLintHighlightErrorLine=0

Bundle 'Shougo/neocomplcache'
let g:neocomplcache_enable_at_startup = 1 

Bundle 'ervandew/supertab'
let g:SuperTabDefaultCompletionType = "context"

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" from git repo
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
Bundle 'git://git.wincent.com/command-t.git'

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" from vim script Sites
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

Bundle "fugitive.vim"
Bundle "L9"
Bundle 'genutils'
Bundle 'rainbow_parentheses.vim'
Bundle 'LargeFile'
Bundle 'FencView.vim'
Bundle 'mru.vim'
Bundle 'vimcdoc'
Bundle 'jsbeautify'
Bundle 'JavaScript-Indent'

" (HT|X)ml tool
Bundle "ragtag.vim"

" VimCommander
Bundle "vimcommander"
noremap <silent> <F11> :cal VimCommanderToggle()<CR> 

filetype plugin indent on     " required! 
