source $VIMRUNTIME/vimrc_example.vim
"source $VIMRUNTIME/mswin.vim
if has('win32')
	behave mswin
endif

set nocompatible              " 去除VI一致性,必须
filetype off                  " 必须

" 设置包括vundle和初始化相关的runtime path
set rtp+=~/.vim/bundle/Vundle.vim
"set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
" 另一种选择, 指定一个vundle安装插件的路径
"call vundle#begin('~/some/path/here')
"call vundle#begin($VIM.'/vimfiles')

" 让vundle管理插件版本,必须
Plugin 'VundleVim/Vundle.vim'

"自己的插件
Plugin 'scrooloose/nerdtree'
"Plugin 'jistr/vim-nerdtree-tabs'
"Plugin 'vim-scripts/The-NERD-tree'
Plugin 'easymotion/vim-easymotion'
Plugin 'tpope/vim-surround'
Plugin 'stephpy/vim-php-cs-fixer'
Plugin 'altercation/vim-colors-solarized'
Plugin 'vim-airline/vim-airline'
Plugin 'vim-airline/vim-airline-themes'
Plugin 'junegunn/vim-easy-align'
Plugin 'ctrlpvim/ctrlp.vim'
"Plugin 'flazz/vim-colorschemes'


" 以下范例用来支持不同格式的插件安装.
" 请将安装插件的命令放在vundle#begin和vundle#end之间.
" Github上的插件
" 格式为 Plugin '用户名/插件仓库名'
"Plugin 'tpope/vim-fugitive'
" 来自 http://vim-scripts.org/vim/scripts.html 的插件
" Plugin '插件名称' 实际上是 Plugin 'vim-scripts/插件仓库名' 只是此处的用户名可以省略
"Plugin 'L9'
" 由Git支持但不再github上的插件仓库 Plugin 'git clone 后面的地址'
"Plugin 'git://git.wincent.com/command-t.git'
" 本地的Git仓库(例如自己的插件) Plugin 'file:///+本地插件仓库绝对路径'
"Plugin 'file:///home/gmarik/path/to/plugin'
" 插件在仓库的子目录中.
" 正确指定路径用以设置runtimepath. 以下范例插件在sparkup/vim目录下
"Plugin 'rstacruz/sparkup', {'rtp': 'vim/'}
" 安装L9，如果已经安装过这个插件，可利用以下格式避免命名冲突
"Plugin 'ascenator/L9', {'name': 'newL9'}

" 你的所有插件需要在下面这行之前
call vundle#end()            " 必须
filetype plugin indent on    " 必须 加载vim自带和插件相应的语法和文件类型相关脚本
" 忽视插件改变缩进,可以使用以下替代:
"filetype plugin on
"
" 简要帮助文档
" :PluginList       - 列出所有已配置的插件
" :PluginInstall    - 安装插件,追加 `!` 用以更新或使用 :PluginUpdate
" :PluginSearch foo - 搜索 foo ; 追加 `!` 清除本地缓存
" :PluginClean      - 清除未使用插件,需要确认; 追加 `!` 自动批准移除未使用插件
"
" 查阅 :h vundle 获取更多细节和wiki以及FAQ
" 将你自己对非插件片段放在这行之后
"---------------------------------------------------------------
" NERDTree config
map <F2> :NERDTreeToggle<CR>
"autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTreeType") && b:NERDTreeType == "primary") | q | endif
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree")) | q | endif
"第一条是说使用F2键快速调出和隐藏它；
"第二条是关闭vim时，如果打开的文件除了NERDTree没有其他文件时，它自动关闭，减少多次按:q!。
"如果想打开vim时自动打开NERDTree，可以如下设定
autocmd vimenter * NERDTree

"设置宽度
let NERDTreeWinSize=25
if has('win32')
	"windows注册表文件忽略
	let NERDTreeIgnore = ['\~$','\.pyc$','\*NTUSER*','\*ntuser*','\NTUSER.DAT','\ntuser.ini'] 
endif

"NERDTress File highlighting
function! NERDTreeHighlightFile(extension, fg, bg, guifg, guibg)
	exec 'autocmd filetype nerdtree highlight ' . a:extension .' ctermbg='. a:bg .' ctermfg='. a:fg .' guibg='. a:guibg .' guifg='. a:guifg
	exec 'autocmd filetype nerdtree syn match ' . a:extension .' #^\s\+.*'. a:extension .'$#'
endfunction

"guibg=NONE not none
call NERDTreeHighlightFile('jade',   'green',   'none', 'green',   'NONE')
call NERDTreeHighlightFile('ini',    'yellow',  'none', 'yellow',  'NONE')
call NERDTreeHighlightFile('md',     'blue',    'none', '#3366FF', 'NONE')
call NERDTreeHighlightFile('yml',    'yellow',  'none', 'yellow',  'NONE')
call NERDTreeHighlightFile('config', 'yellow',  'none', 'yellow',  'NONE')
call NERDTreeHighlightFile('conf',   'yellow',  'none', 'yellow',  'NONE')
call NERDTreeHighlightFile('json',   'yellow',  'none', 'yellow',  'NONE')
call NERDTreeHighlightFile('html',   'yellow',  'none', 'yellow',  'NONE')
call NERDTreeHighlightFile('styl',   'cyan',    'none', 'cyan',    'NONE')
call NERDTreeHighlightFile('css',    'cyan',    'none', 'cyan',    'NONE')
call NERDTreeHighlightFile('coffee', 'Red',     'none', 'red',     'NONE')
call NERDTreeHighlightFile('js',     'Red',     'none', '#ffa500', 'NONE')
call NERDTreeHighlightFile('php',    'Magenta', 'none', '#ff00ff', 'NONE')
"---------------------------------------------------------------
"vim-php-cs-fixer config
"https://github.com/FriendsOfPHP/PHP-CS-Fixer/releases
nnoremap <silent><leader>dd :call PhpCsFixerFixDirectory()<CR>
nnoremap <silent><leader>ff :call PhpCsFixerFixFile()<CR>
" If php-cs-fixer is in $PATH, you don't need to define line below
let g:php_cs_fixer_path = "\"" . $VIM . "\\php-cs-fixer.phar\"" " define the path to the
"let g:php_cs_fixer_path = $VIM . "/php-cs-fixer.phar" " define the path to the
" php-cs-fixer.phar

" If you use php-cs-fixer version 1.x
let g:php_cs_fixer_level = "symfony"                   " options: --level (default:symfony)
let g:php_cs_fixer_config = "default"                  " options: --config
" If you want to define specific fixers:
"let g:php_cs_fixer_fixers_list = "linefeed,short_tag" " options: --fixers
"let g:php_cs_fixer_config_file = '.php_cs'            " options:
"--config-file
" End of php-cs-fixer version 1 config params

" If you use php-cs-fixer version 2.x
let g:php_cs_fixer_rules = "@PSR2"          " options: --rules (default:@PSR2)
let g:php_cs_fixer_cache = ".php_cs.cache --using-cache=no" " options: --cache-file
"let g:php_cs_fixer_config_file = '.php_cs' " options: --config
" End of php-cs-fixer version 2 config params

let g:php_cs_fixer_php_path = "php"               " Path to PHP
let g:php_cs_fixer_enable_default_mapping = 0     " Enable the mapping by default (<leader>pcd)
let g:php_cs_fixer_dry_run = 0                    " Call command with dry-run option
let g:php_cs_fixer_verbose = 0                    " Return the output of command if 1, else an inline information.

"之前自己写的自动格式化php代码，美中不足的是弹出窗口询问
func! MyPhpFmt()
	let t:thePath = expand("%:p")
	"vnew
	"execute 'silent .!php ' . $HOME . '\php-cs-fixer.phar fix ' . t:thePath . ' --rules=@PSR2 --using-cache=no'
	let s:output = system('php ' . $VIM . '\php-cs-fixer.phar fix ' . t:thePath . ' --rules=@PSR2 --using-cache=no')
	echo s:output
	"e! t:thePath
endfunc
"noremap <silent><a-l> :call MyPhpFmt()<CR>
"---------------------------------------------------------------
"使用插件主题，执行下面两行

if has('gui_running')
else
	set t_Co=256
	let g:solarized_termcolors=256
	let g:solarized_termtrans = 1
	let g:solarized_degrade = 1
	let g:solarized_contrast="high"
endif

set background=dark
colorscheme solarized
"call togglebg#map("<F1>")
"---------------------------------------------------------------
"vim-airline

let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#left_sep = ' '
"let g:airline#extensions#tabline#left_alt_sep = '|'
let g:airline#extensions#tabline#formatter = 'unique_tail'
set fillchars+=vert:\|
hi clear VertSplit
"hi vertsplit cterm=NONE ctermbg=NONE guifg=NONE guibg=NONE

let g:airline_theme='solarized'
let g:airline_solarized_bg='dark'
"---------------------------------------------------------------
" vim-easy-align config

" Start interactive EasyAlign in visual mode (e.g. vipga)
xmap gl <Plug>(EasyAlign)

" Start interactive EasyAlign for a motion/text object (e.g. gaip)
nmap gl <Plug>(EasyAlign)
"---------------------------------------------------------------

"解决中文乱码
"set fileencoding=utf-8这项设置默认以utf8打开文件
set fileencodings=utf-8,chinese,cp936,latin-1
if has("win32")
	set encoding=chinese
else
	set encoding=utf-8
endif
"解决菜单乱码
if has('gui_running')
	source $VIMRUNTIME/delmenu.vim
	source $VIMRUNTIME/menu.vim
endif
"解决consle输出乱码
if has('win32')
	language messages zh_CN.utf-8
endif

"使Vim显示和TextMate相同的不可见字符
"set list
"set listchars=tab:?\ ,eol:?

"主题
"colorscheme torte

"字体
if ( has('gui_running') && has('win32'))
	"set guifont=Consolas:h10
	set guifont=Andale_Mono:h10,Menlo:h10,Consolas:h10,Courier_New:h10
endif

"自动保存
"let autosave=5
"au FocusLost * :wa

"关闭自动换行
set nowrap

"设置自动缩进
set autoindent
"设置（软）制表符宽度为4
set tabstop=4
set softtabstop=4
"设置缩进的空格数为4
set shiftwidth=4

"一行长度，暂时取消，自动折行有点烦
"set textwidth=80
"在多字节字符处可以折行。在拼接两行时（重新格式化，或者是手工使用“J”命令），如果前一行的结尾或后一行的开头是多字节字符，则不插入空格，非常适合中文
set formatoptions+=mM
"第80列高亮
"set colorcolumn=80

"行号和相对行号，需要同时打开，效果最好
set nu
set relativenumber

"tab line 只显示文件名
"set guitablabel=%t

"tab bar color
"hi TabLine     ctermfg=Black     ctermbg=DarkGreen cterm=NONE
"hi TabLineFill ctermfg=Black     ctermbg=DarkGreen cterm=NONE
"hi TabLineSel  ctermfg=DarkGreen ctermbg=Black     cterm=NONE

"禁止vim生成 un~ ，奇怪的是设置了这三个NERDTree就会强制提示文件无法加载，设置 |wincmd P可解决
set noundofile
set nobackup
set noswapfile
"set undodir=~/.vim/undo0,~/.vim/undo1
"交换文件路径
set directory=~/.vim/swp0,~/.vim/swp1

"----------map&cmd------------

"设置自动补全
"inoremap ' ''<ESC>i
"inoremap " ""<ESC>i
inoremap ( ()<ESC>i
inoremap [ []<ESC>i
inoremap { {}<ESC>i

"设置跳出自动补全的括号
func! SkipPair()  
	if getline('.')[col('.') - 1] == ')' || getline('.')[col('.') - 1] == ']'
		|| getline('.')[col('.') - 1] == '"' || getline('.')[col('.') - 1] == "'"
		|| getline('.')[col('.') - 1] == '}'  
		return "\<ESC>la"  
	else  
		return "\t"  
	endif  
endfunc  
" 将tab键绑定为跳出括号  
""inoremap <TAB> <c-r>=SkipPair()<CR>

" shift tab pages
map <S-Left> :tabp<CR>
map <S-Right> :tabn<CR>

" Save session on quitting Vim
autocmd VimLeave * NERDTreeClose
autocmd VimLeave * mksession! $HOME/Last.session

" Restore session on starting Vim
"autocmd VimEnter * call MySessionRestoreFunction()
fu! MySessionRestoreFunction()
	execute 'so Last.session'
endfunction
"---------leader------------
"重新选择刚刚粘贴的文本
nnoremap <leader>v V`]

"折叠标签
nnoremap <leader>ft Vatzf

"去除当前文件中所有行尾的空格
nnoremap <leader>W :%s/\s\+$//<cr>:let @/=''<CR>
"---------------------------
"添加作者
func! SetAuthor()
    call append(line("."),"/**") 
    call append(line(".")+1, "*   Copyright (C) ".strftime("%Y")." All rights reserved.")
    call append(line(".")+2, "*") 
    call append(line(".")+3, "*   FileName      ：".expand("%:t")) 
    call append(line(".")+4, "*   Author        ：xxxx")
    call append(line(".")+5, "*   Email         ：xxx@xxx.com")
    call append(line(".")+6, "*   Date          ：".strftime("%Y年%m月%d日")) 
    call append(line(".")+7, "*   Description   ：") 
    call append(line(".")+8, "*/") 
endfunc


"---------------------------
"重定义按键
"inoremap jk <esc>
"---------------------------

"-------------gvim----------
"自动最大化
if has('win32')
	au GUIEnter * simalt ~x
else
	au GUIEnter * call MaximizeWindow()
endif

if has('win32')
	function! MaximizeWindow()
		silent !wmctrl -r :ACTIVE: -b add,maximized_vert,maximized_horz
	endfunction

	"全屏
	if has('gui_running') && has("win32")
		map <F11> :call libcallnr($VIM . "/gvimfullscreen.dll", "ToggleFullScreen", 0)<CR>
	endif

	"保持窗口最上层

	"gVim remove toolbar
	set guioptions-=T
	set guioptions-=L
	set guioptions-=r
	"gVim remove Menu
	set guioptions-=m
endif
"---------------------------

"显示并把根目录树置为www并切换上一个window
autocmd VimEnter * silent NERDTree www | wincmd p

" autoload _vimrc保存后自动生效
if has('win32')
	autocmd! bufwritepost _vimrc source %
else
	autocmd! bufwritepost .vimrc source %
endif
