call plug#begin() 
Plug 'preservim/NERDTree' 
Plug 'SirVer/UltiSnips'
Plug 'honza/vim-snippets'
Plug 'lervag/vimtex'
Plug 'Valloric/YouCompleteMe'
Plug 'rakr/vim-one'
#Plug '907th/vim-auto-save'
#Plug 'xuhdev/vim-latex-live-preview'
#Plug 'altercation/vim-colors-solarized'
call plug#end()

let g:UltiSnipsExpandTrigger       = '<Tab>'    " use Tab to expand snippets
let g:UltiSnipsJumpForwardTrigger  = 'ji'    " use Tab to move forward through tabstops
let g:UltiSnipsJumpBackwardTrigger = '<S-Tab>'  " use Shift-Tab to move backward through tabstops

" Use both `UltiSnips` and `MySnippets` as snippet directories
let g:UltiSnipsSnippetDirectories=["UltiSnips", "MySnippets"]

let g:UltiSnipsSnippetDirectories=[$HOME.'/.vim/plugged/UltiSnips']          " using Vim

filetype on             " enable filetype detection
filetype plugin on      " load file-specific plugins
filetype indent on      " load file-specific indentation

syntax enable

" Viewer options: One may configure the viewer either by specifying a built-in
" viewer method:
let g:vimtex_view_method = 'skim'
let maplocalleader = ","

"----------Settings for xuhdev/vim-latex-live-preview
#autocmd Filetype tex setl updatetime=1 "To set the update time for live view
#let g:livepreview_previewer='open -a skim'

" Define a custom shortcut to trigger VimtexView
nmap <localleader>v <plug>(VimtexView)
nnoremap <localleader>m <Cmd>:call UltiSnips#RefreshSnippets()<CR>
nnoremap <localleader>wq <Cmd>:wq<CR>
nnoremap <localleader>q <Cmd>:q<CR>
nnoremap <localleader>w <Cmd>:w<CR>

set number

"Credit joshdick
"Use 24-bit (true-color) mode in Vim/Neovim when outside tmux.
"If you're using tmux version 2.2 or later, you can remove the outermost $TMUX check and use tmux's 24-bit color support
"(see < http://sunaku.github.io/tmux-24bit-color.html#usage > for more information.)
if (empty($TMUX))
  if (has("nvim"))
    "For Neovim 0.1.3 and 0.1.4 < https://github.com/neovim/neovim/pull/2198 >
    let $NVIM_TUI_ENABLE_TRUE_COLOR=1
  endif
  "For Neovim > 0.1.5 and Vim > patch 7.4.1799 < https://github.com/vim/vim/commit/61be73bb0f965a895bfb064ea3e55476ac175162 >
  "Based on Vim patch 7.4.1770 (`guicolors` option) < https://github.com/vim/vim/commit/8a633e3427b47286869aa4b96f2bfc1fe65b25cd >
  " < https://github.com/neovim/neovim/wiki/Following-HEAD#20160511 >
  if (has("termguicolors"))
    set termguicolors
  endif
endif

function! g:UltiSnips_Complete()
  call UltiSnips#ExpandSnippet()
  if g:ulti_expand_res == 0
    if pumvisible()
      return "\<C-n>"
    else
      call UltiSnips#JumpForwards()
      if g:ulti_jump_forwards_res == 0
        return "\<TAB>"
      endif
    endif
  endif
  return ""
endfunction

function! g:UltiSnips_Reverse()
  call UltiSnips#JumpBackwards()
  if g:ulti_jump_backwards_res == 0
    return "\<C-P>"
  endif

  return ""
endfunction


if !exists("g:UltiSnipsJumpForwardTrigger")
  let g:UltiSnipsJumpForwardTrigger = "<tab>"
endif
if !exists("g:UltiSnipsJumpBackwardTrigger")
  let g:UltiSnipsJumpBackwardTrigger="<s-tab>"
endif

au InsertEnter * exec "inoremap <silent> " . g:UltiSnipsExpandTrigger     . " <C-R>=g:UltiSnips_Complete()<cr>"
au InsertEnter * exec "inoremap <silent> " .     g:UltiSnipsJumpBackwardTrigger . " <C-R>=g:UltiSnips_Reverse()<cr>"

#autocmd TextChanged,TextChangedI <buffer> silent write
#let g:auto_save = 1

let g:airline_theme='one'
colorscheme one
" set background=dark " for the dark version
set background=light " for the light version

