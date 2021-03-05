runtime! archlinux.vim
execute pathogen#infect()

" --- SETTINGS -------------------------------------------------------------- "

"    set mouse=a                " Enable Mouse 'a'=for all modes
    set incsearch              " Incremental Search
    set hlsearch               " Highlight when searching 
    set nocompatible           " Arrow move Compatible
    set background=dark        " Background
    set history=700            " History length
    set number                 " Show line Numbers
    set expandtab              " Auto expand tabs to space
    set autoindent             " Auto indent after a {
    set smartindent            " Auto indent General    
    set textwidth=0            " Linewidth to endless
    set nowrap                 " Do not wrap lines automatically
    set backspace=start,eol    " Repair wired terminal/vim settings
    set ignorecase             " caseinsensitive searches
    set showmode               " always show command or insert mode
    set ruler                  " show line and column information
    set showmatch              " show matching brackets
    set formatoptions=tcqor
    set whichwrap=b,s,<,>,[,]
    set complete+=kspell       " Autocomplete when spell check (Ctrl+N / Ctrl+P) 
    set tabstop=4
    set shiftwidth=4
    set expandtab
    set smarttab
    set splitbelow
    set noerrorbells visualbell t_vb=
    syntax on                  " Code Syntax Highlighting
"    set ttimeoutlen=0          " Performace Tweaks 
"    set timeoutlen=1000
    set ttyfast 
    au InsertEnter * set timeout
    au InsertLeave * set notimeout


    " create persistance state files 
    set undofile
    set undodir=/home/sam/.vim-tmp/    " Set undo file
    set directory=/home/sam/.vim-tmp/  " Set Swap file location
    set backupdir=/home/sam/.vim-tmp/ " Set Backup file dir

" --- FUNCTIONS ------------------------------------------------------------- "

 " --- Highlight 80 Char Overflow
    " By Default only show if line > 80
    highlight ColorColumn ctermbg=magenta
    autocmd VimEnter,WinEnter,BufWinEnter * call matchadd('ColorColumn', '\%81v', 100)


 " --- Toggle Line allways show    
    let s:activatedh = 0
    function! Highlight_char80()
        if s:activatedh == 0
           let s:activatedh = 1
           set colorcolumn=81
        else
            let s:activatedh = 0
            set colorcolumn=0
        endif
    endfunction
	


 " --- Open in Current tab if empty, else newtab
    function! OpenNew(fileName)
        if bufname("%") == ""
            " Current is empty - Open here
            :execute ":e" fnameescape(a:fileName)
            ":e a:fileName <CR>
        else 
            " Not empty - new tab
            :execute ":tabnew" fnameescape(a:fileName)
            ":tabnew a:fileName <CR>
        endif     
    endfunction


 " --- Toggle Between modes for line numbers 
    function! NumberToggle()
      if(&relativenumber == 1)
        set relativenumber!
      else
        set relativenumber
      endif
    endfunc

	function! ToggleMouse()
		" check if mouse is enabled
		if &mouse == 'nv'
			" disable mouse
			set mouse=
		else
			" enable mouse everywhere
			set mouse=n
		endif
	endfunc


	"" write functions to 
    " http://vim.wikia.com/wiki/Remove_unwanted_spaces

    " remove leading whitespace
    " :%s/^\s\+


    " remove trailing whitespace
    " :%s/\s\+$




" --- QUICK ACCESS ---------------------------------------------------------- "
    nnoremap <leader>v :call OpenNew("~/.vimrc")<CR>
    nnoremap <leader>b :call OpenNew("~/.bashrc")<CR>
    nnoremap <leader>a :call OpenNew("~/.bash_aliases")<CR>
    nnoremap <leader>i :call OpenNew("~/.i3/config")<CR>

" --- TEXT FORMATTING MAP --------------------------------------------------- "

    "JSON
    nmap =j :%!jq .<CR>

    "CSV
    nmap =c :%!column -t -s ','<CR>

    "BIN->HEX
    nmap =h :%!xxd<CR><ESC>

    "HEX->BIN
    nmap =b :%!xxd -r<CR><ESC>
    
    "Lazy set python db trace
    nmap =t oimport ipdb; ipdb.set_trace()<ESC>

    "Exec current buffer in shell 
    :command Exec :silent :w !bash
    nmap =e :Exec<CR><ESC>

    "Line insert 
    nmap =l o# ---------------------------------------------------------------------------<ESC>
" --- KEY BINDINGS ---------------------------------------------------------- "


    " Prevent Accidental Encryption / skip save
    map! X<CR> x<CR>
    map! W<CR> w<CR>
    map  W<CR> w<CR>

    " Force sudo write using ':w!!'
    cmap w!! w !sudo tee > /dev/null %

    " Quick buffer next / prev
    nnoremap <C-[> :bp<CR>
    nnoremap <C-]> :bn<CR>


    " Remap Freeze flow control to save file
    :nmap <c-s> :w<CR>
    :imap <c-s> <Esc>:w<CR>a


    " Search for visually selected text
    " note that '*' will work for word under cursor [vim default]
    vnoremap // y/<C-R>"<CR>


    " Non-Escape key exit from insert mode
    imap <C-c> <Esc>l

    " Move from Insert -> visual block Mode
    imap <c-v> <esc><C-v>                   
    
    " Disable Replace mode by <Insert>, use (Shift-R)
    nnoremap <Insert> i
    inoremap <Insert> <Esc>l


    " Prevent Accidental Encryption / skip save
    map! X<CR> x<CR>
    map! W<CR> w<CR>
    map  W<CR> w<CR>
   

    " Paragraph Move Ctrl+Up, normal,visual, select
    " Paragraph Move Ctrl+Up, insert 
    " Paragraph Move Ctrl+Dwn, normal,visual, select
    " Paragraph Move Ctrl+Dwn, insert
    map  <ESC>Ob })
    map  <ESC>Oa {(
    map! <ESC>Oa {(
    map! <ESC>Ob })

    " Ctrl+a Move Line start
    map  <C-alt-a> <ESC>  <home>

    map <C-o> <ESC>

    " Ctrl+e move line end
    map  <C-e> <ESC>  <end>

    " Fix paste from visual mode
    vmap <C-S-v> <ESC>a "+p

	" Refresh vimrc without exit    
    nnoremap <leader>r :so $MYVIMRC<CR>
    " save and close all
    nnoremap <leader>c :qa<CR>
    " tabnew shortcut
    nnoremap <leader>d :tabnew<CR>

    cabbrev E Explore

    " Ctrl+h/  Ctrl+l ti move between tabs
    nnoremap <C-l> gt
    nnoremap <C-h> gT

  	" Spell Check Prev/Next wrong word
"	nnoremap <C-z> [sz=0`] 
"    nnoremap <C-x> ]sz=0`]

" --- TOGGLES --------------------------------------------------------------- "
" F1 File Browser
   noremap <F1> :NERDTreeToggle<CR>
   inoremap <F1> :NERDTreeToggle<CR>

" F2 Paste mode for line indents
    set pastetoggle=<F2>    

" F3 Paste mode for line indents
    nnoremap <F3> :call NumberToggle()<cr>

" F4 Line numbers 
    noremap <F4> :set invnumber <CR>:GitGutterToggle <CR>
    inoremap <F4> <C-O>:set invnumber<CR>:GitGutterToggle <CR>

" F5 QUICK SAVE
"    nnoremap <F5> :call ToggleMouse()<CR>

" F6` Toggle 80 Char indicator 
   nnoremap <F6> :call Highlight_char80()<CR>
     
" F7 Text wrap
    nnoremap <F7> :set wrap! wrap?<CR>
    imap <F7> <C-O><F7>
 
" F8 Search Highlight
    noremap  <F8> :set hlsearch! hlsearch?<CR>  
    imap <F8> <C-O><F8>

" F9 Remove Trailing Whitespace 
    nnoremap <F9> :let _s=@/<Bar>:%s/\s\+$//e<Bar>:let @/=_s<Bar><CR>

" F10 Spell Checker (Use: [s, ]s, z=)
    nnoremap <F10> :setlocal spell! spelllang=en<CR>
    " nnoremap <F10> :setlocal spell! spelllang=en_gb <CR>
    imap <F10> <C-O><F10>

" F11 Run Bash
   nnoremap <F11> :terminal ipython<CR>

" F12 Run Bash
   nnoremap <F12> :terminal bash<CR>

"" File Browser - Ctrl-X
"    map <silent> <C-X> :NERDTreeToggle<CR>
"    imap <C-X> <esc> :NERDTreeToggle<CR>




" --- COLOUR SCHEME --------------------------------------------------------- "

	" Set Line Number Background as black
    highlight LineNr ctermbg=234

	" Set Vertical split Line as Solid Black
    hi VertSplit    term=NONE cterm=bold ctermfg=16    ctermbg=16


	" Set Empty buffer as gray
    highlight NonText ctermbg=239

    " Set Cursor Line Colour Scheme 
    hi CursorLine cterm=NONE
    hi CursorLineNR ctermbg=red
    "hi CursorLineNR ctermbg=88

    " Only Show Cursor line in Active Buffer
    augroup CLNRSet
        au!
        au VimEnter,WinEnter,BufWinEnter * setlocal cursorline
        au WinLeave * setlocal nocursorline
    augroup END

    " VIM spell checker to underline     
    hi clear SpellBad
    hi SpellBad cterm=underline,bold ctermfg=red

" --- PLUGIN CONFIG --------------------------------------------------------- "

    " Latex-Box 
    "    filetype plugin on
    "    set grepprg=grep\ -nH\ $*
    "    filetype indent on
    "    let g:tex_flavor='latex'
    "    let g:Tex_DefaultTargetFormat = 'pdf'
    "    let g:Tex_CompileRule_pdf = 'latexmk -pdf -f $*'
    "    set iskeyword+=:

    " Fuzzy search  -  (https://github.com/ctrlpvim/ctrlp.vim)
    set runtimepath^=~/.vim/bundle/ctrlp.vim
    let g:ctrlp_show_hidden = 1


    " Vim-airline  -  (http://vimawesome.com/plugin/vim-airline)
    let g:airline_theme='distinguished'             " Select Theme from  ~/.vim/bundle/vim-airline-themes/autoload/airline/themes
    set t_Co=256                                    " Enable Colours 
    set laststatus=2                                " Show airline bar for single files
    set noshowmode                                  " Hide --INSERT-- from bottom status bar

    " Append Current User to Status Bar    
    call airline#parts#define_raw('user', '%{$USER} ')
    let g:airline_section_y = airline#section#create_right([ 'user' , 'ffenc'])

    " Enable vim-airline bufferbar replacment 
    let g:airline#extensions#tabline#enabled = 1

    " Setup Symbols 
    if !exists('g:airline_symbols')
        let g:airline_symbols = {}
    endif
    let g:Powerline_symbols = 'fancy'
    let g:airline_left_sep = ''
    let g:airline_right_sep = ''
    let g:airline_symbols.linenr = '␊'
    let g:airline_symbols.linenr = '␤'
    let g:airline_symbols.linenr = '¶'
    let g:airline_symbols.branch = '↝'
    let g:airline_symbols.paste = 'PASTE'
