filetype plugin indent on
syntax on
nnoremap c "_c

" Options
set title
set bg=dark
set encoding=utf-8
set wildmode=longest,list,full
set sessionoptions-=options
set nocompatible
set showtabline=0
set nowrap sidescroll=1
set sidescrolloff=1
set noshowcmd
set noshowmode
set pumblend=20
set tags+=~/.config/nvim/systags

" Environment variables
let g:indentLine_fileTypeExclude = ['alpha']
let g:sql_type_default = 'mysql'
let form_enhanced_color=1
let readline_has_bash = 1
let msql_sql_query = 1
let nroff_is_groff = 1
let perl_no_scope_in_variables = 1
let php_sql_query = 1
let phtml_sql_query = 1
let python_highlight_all = 1
let g:plaintex_delimiters = 1
let postscr_fonts=1
let postscr_ghostscript=1
let perl_include_pod = 0
let postscr_encodings=1
let filetype_frm = "form"
let b:preprocs_as_sections = 1

" I found this scroll remap in the manual, but I find it more useful to have it scroll the next split instead.
	" map <C-U> <C-Y><C-Y><C-Y><C-Y><C-Y><C-Y><C-Y><C-Y><C-Y><C-Y><C-Y><C-Y><C-Y>
	" map <C-D> <C-E><C-E><C-E><C-E><C-E><C-E><C-E><C-E><C-E><C-E><C-E><C-E><C-E>

" Scroll the next vertical split down
"nnoremap <C-E> :wincmd l<CR><C-e>:wincmd h<CR>
" Scroll the next vertical split up
"nnoremap <C-Y> :wincmd l<CR><C-y>:wincmd h<CR>
" Side-scroll the next vertical split to the right
"nnoremap <C-M> :wincmd l<CR>zl:wincmd h<CR>
" Side-scroll the next vertical split to the left
" nnoremap <C-> :wincmd l<CR>zh:wincmd h<CR>

" Copy function below (why not simply yap?)
  " nmap <leader>yyb V}y}p<CR>
" " Zoom in
"   function! ComeCloser()
"     :vnew :vertical resize 50
"     :wincmd l
"   endfunction
"   nnoremap <C-w>x :call ComeCloser()<CR>

" Placeholder navigation through  portals
  map ,, :keepp /<++><CR>ca<
  imap ,, <esc>:keepp /<++><CR>ca<

" Drop some portals
" [a]ppend [p]ortal after contiguous text under the cursor
  nnoremap ,ap :normal! viWA <++><Esc>
" [i]nsert [p]ortal before the word under the cursor
  nnoremap ,ip :normal! bi<++> <Esc>2w
" Replace contiguous text under the cursor with a portal, then selects
" the next word (in case you'd want to replace it with a portal too)
  nnoremap \, :normal viWc<++><ESC>wviW
" Replace contiguous text with portals while in visual modes too
  xnoremap \, <ESC>viWc<++><ESC>wviW
" TODO: make it a portal function lol

" Quick enclosures
  map \l i[<Esc>ea]<Esc>
  map \p i(<Esc>ea)<Esc>
  map \c i{<Esc>ea}<Esc>
  map \" i"<Esc>ea"<Esc>
  map \q i"<Esc>ea"<Esc>
  map \' i'<Esc>ea'<Esc>
  map \` i`<Esc>ea`<Esc>

" select inside enclosures
  nnoremap ;p vi)
  nnoremap ;< vi>

  nnoremap <leader>fm :g/^@.*:$/,+1,/^@.*:$/-1 normal gggqG<CR>
" Visual markdown codeblocks insertions
  vnoremap <leader>bi xO```<CR>```<Esc>kp<Esc>kA
" adding a mapping to insert a codeblock with a specific language
" ending with dapP puts the codeblock in the paste register for easy pasting
  vnoremap <leader>bv xO```<CR>```<Esc>kp<Esc>kAvim<Esc>dapP}

" It would be better to have it pipe it's output to another buffer like VimTTS
" lua func that directly pipes &filetype codeblocks to [tts] markdown tab-page
" but I'm not sure how to make it work with vimscript. I'll have to look into it.
" TODO: refactor to redirect codeblocks to daily vimwiki
vnoremap <leader>B xO```<CR>```<Esc>kp<Esc>k$:call InsertSyntax()<CR>dapP}
  function! InsertSyntax()
    filetype plugin indent off
    let ft = &filetype
    put =ft
    normal! kJx
    filetype plugin indent on
  endfunction

" bash-like commandline mappings
	" start of line
	cnoremap <C-A>  <Home>
	" back one character
	cnoremap <C-B>  <Left>
	" delete character under cursor
	cnoremap <C-D>  <Del>
	" end of line
	cnoremap <C-E>  <End>
	" forward one character
	cnoremap <C-F>  <Right>
	" recall newer command-line
	cnoremap <C-N>  <Down>
	" recall previous (older) command-line
	cnoremap <C-P>  <Up>
	" back one word
	cnoremap <Esc><C-B> <S-Left>
	" forward one word
	cnoremap <Esc><C-F> <S-Right>

" Dot commands over visual blocks
	vnoremap . :normal .<CR>
" Quick next inside selections
  vnoremap ;p <ESC>vi)
  vnoremap ;< <ESC>vi>
" Quick selections
  vnoremap ,\ <ESC>wviW
" Same but selects contiguous text from normal mode
  nnoremap VV viWy/<C-R>"<CR>
" Quick selection searches
  nnoremap * viWy/<C-R>"<CR>
" yank next inner parentheses
  nnoremap ;) vi)y/<C-R>"<CR>

" Search over visual selection allowing for [v]isual motions or targeted selections
" pressing [n]ext starts search and [N]ext goes back as expected and the search query looks cleaner
  xnoremap n y/<C-R>"<CR>

" kinda more complicated version of the above but might be useful to escape metachars
  xnoremap * :<C-u>call <SID>VSetSearch()<CR>/<C-R>=@/<CR><CR>
  xnoremap # :<C-u>call <SID>VSetSearch()<CR>?<C-R>=@/<CR><CR>
  function s:VSetSearch()
     let temp = @s
     norm! gv"sy
     let @/ = '\V' . substitute(escape(@s, '/\'), '\n', '\\n', 'g')
     let @s = temp
  endfunction

" Function for <cword> expansion search
  "function! ExpandCword()
  "  let g:word = expand("<cword>")
  "  execute ":help " .. g:word
  "endfunction
  "nnoremap _u <cmd>call ExpandCword()<CR>

" Indent lines taking the first line as reference
  map ;f :set ai<CR>}{a                                                          <Esc>WWmmkD`mi<CR><Esc>kkddpJgq}'mJO<Esc>j
" Remove trailing whitespace joining consecutive indented lines
	map ;b   GoZ<Esc>:g/^$/.,/./-j<CR>Gdd<Esc>
	map ;n   GoZ<Esc>:g/^[ <Tab>]*$/.,/[^ <Tab>]/-j<CR>Gdd<Esc>

" Spell-check set to <leader>o, 'o' for 'orthography':
	map <leader>o :setlocal spell! spelllang=en_us<CR>
" Replace ex mode with gq
	map Q gq
" Check file in shellcheck:
	map <leader>SC :!clear && shellcheck -x %<CR>
" Replace all is aliased to S.
	nnoremap S :%s//g<Left><Left>
" Compile document, be it groff/LaTeX/markdown/etc.
	map <leader>,cc :w! \| !compiler "%:p"<CR>
" Open corresponding .pdf/.html or preview
	map <leader>,op :!opout "%:p"<CR>
"  sudo bypass
	cabbrev w!! execute 'silent! write !sudo tee % >/dev/null' <bar> edit!

" make changed text stands out in diffs
	if &diff
	    highlight! link DiffText MatchParen
	endif

  " Count stuff
	" :%s/./&/gn          (characters)
	" :%s/\i\+/&/gn       (words)
	" :%s/^//n            (lines)
	" :%s/the/&/gn        ("the" anywhere)
	" :%s/\<the\>/&/gn    ("the" as a word)

  " rename files to .bla
	" :r !ls *.c
	" :%s/\(.*\).)c/mv & \1.bla
	" :w !sh
	" :q!

" if exists(':tnoremap')
"    tnoremap <Esc><Esc> <C-\><C-n>
" endif
"
if !exists("autocommands_loaded")
  let autocommands_loaded = 1
"
 autocmd User AlphaReady set showtabline=0 | autocmd BufUnload <buffer> set showtabline=2
"
"	let s:paren_hl_on = 0
"	function s:Highlight_Matching_Paren()
"	  if s:paren_hl_on
"	    match none
"	    let s:paren_hl_on = 0
"	  endif
"
"	  let c_lnum = line('.')
"	  let c_col = col('.')
"
"	  let c = getline(c_lnum)[c_col - 1]
"	  let plist = split(&matchpairs, ':\|,')
"	  let i = index(plist, c)
"	  if i < 0
"	    return
"	  endif
"	  if i % 2 == 0
"	    let s_flags = 'nW'
"	    let c2 = plist[i + 1]
"	  else
"	    let s_flags = 'nbW'
"	    let c2 = c
"	    let c = plist[i - 1]
"	  endif
"	  if c == '['
"	    let c = '\['
"	    let c2 = '\]'
"	  endif
"	  let s_skip ='synIDattr(synID(line("."), col("."), 0), "name") ' ..
"		\ '=~?	"string\\|comment"'
"	  execute 'if' s_skip '| let s_skip = 0 | endif'
"
"	  let [m_lnum, m_col] = searchpairpos(c, '', c2, s_flags, s_skip)
"
"	  if m_lnum > 0 && m_lnum >= line('w0') && m_lnum <= line('w$')
"	    exe 'match Search /\(\%' .. c_lnum .. 'l\%' .. c_col ..
"		  \ 'c\)\|\(\%' .. m_lnum .. 'l\%' .. m_col .. 'c\)/'
"	    let s:paren_hl_on = 1
"	  endif
"	endfunction

	"autocmd CursorMoved,CursorMovedI * call s:Highlight_Matching_Paren()

  " autocmd! BufEnter * autocmd FileType <buffer> ++once execute "normal! <CR>"

" *restore-cursor* *last-position-jump*
  "augroup RestoreCursor
  "  autocmd!
  "  autocmd BufRead * autocmd FileType <buffer> ++once
  "    \ let s:line = line("'\"")
  "    \ | if s:line >= 1 && s:line <= line("$") && &filetype !~# 'commit'
  "    \      && index(['xxd', 'gitrebase'], &filetype) == -1
  "    \ |   execute "normal! g`\""
  "    \ | endif
  "augroup END

" Disables automatic commenting on newline:
   autocmd FileType * setlocal formatoptions-=c formatoptions-=r formatoptions-=o
" Runs a script that cleans out tex build files whenever I close out of a .tex file.
   autocmd VimLeave *.tex !texclear %

" Ensure files are read as what I want:
   autocmd BufRead,BufNewFile /tmp/calcurse*,~/.calcurse/notes/* set filetype=markdown
   autocmd BufRead,BufNewFile *.ms,*.me,*.mom set filetype=groff
   autocmd BufRead,BufNewFile *.tex set filetype=tex
   autocmd BufRead,BufNewFile {*.[1-9],man://*,*.man} set filetype=man

" Automatically deletes all trailing whitespace and newlines at end of file on save. & reset cursor position
    autocmd BufWritePre * let currPos = getpos(".")
    autocmd BufWritePre * %s/\s\+$//e
    autocmd BufWritePre * %s/\n\+\%$//e
" add trailing newline for ANSI C standard
    autocmd BufWritePre *.[ch] %s/\%$/\r/e
    autocmd BufWritePre *neomutt* %s/^--$/-- /e
" dash-dash-space signature delimiter in emails
    autocmd BufWritePre * call cursor(currPos[1], currPos[2])
" When shortcut files are updated, renew bash and ranger configs with new material:
    autocmd BufWritePost bm-files,bm-dirs !shortcuts
" Run xrdb whenever Xdefaults or Xresources are updated.
    autocmd BufRead,BufNewFile {Xresources,Xdefaults,xresources,xdefaults} set filetype=xdefaults
    autocmd BufWritePost {Xresources,Xdefaults,xresources,xdefaults} !xrdb %
" Recompile dwmblocks on config edit.
    autocmd BufWritePost ~/.local/src/dwmblocks/config.h !cd ~/.local/src/dwmblocks/ ; sudo make install && { killall -q dwmblocks ; setsid -f dwmblocks ; }
    autocmd BufWritePost ~/.local/src/dwm/config.h !cd ~/.local/src/dwm/ && { sudo make install && wmreup }
" Auto-create parent directories (except for URIs "://").
    autocmd BufWritePre,FileWritePre * if @% !~# '\(://\)' | call mkdir(expand('<afile>:p:h'), 'p') | endif
" Set the default file type for termcap files
    autocmd BufNewFile,BufRead /etc/termcaps/* let b:ptcap_type = "term" | set filetype=ptcap

    autocmd InsertEnter * match none
    command -bar -nargs=? -complete=help HelpCurwin execute s:HelpCurwin(<q-args>)
    function s:HelpCurwin(subject) abort
      let mods = 'silent noautocmd keepalt'
      if !s:did_open_help
        execute mods .. ' help'
        execute mods .. ' helpclose'
        let s:did_open_help = v:true
      endif
      if !empty(getcompletion(a:subject, 'help'))
        execute mods .. ' edit ' .. &helpfile
        set buftype=help
      endif
      return 'help ' .. a:subject
    endfunction

    vnoremap <silent> <leader>h :<,'>:HelpCurwin<CR>

    " let g:autoPreview = 0
    "   augroup AutoPreview ++once
    "   autocmd!
    "     au! CursorHold *.txt ++nested exe "silent! ptag " .. expand("<cword>")
    "     au! FileType help,man ++nested call PreviewWord()
    "     au! CursorHold *.[ch] ++nested exe "silent! ptag " .. expand("<cword>")
    "     au! CursorHold *.[ch] ++nested call PreviewWord()
    "   augroup END

    " function! ToggleAutoPreview()
    "   if g:autoPreview == 1
    "     let g:autoPreview = 0
    "     augroup AutoPreview
    "       let updatetime = 350
    "       autocmd!
    "     augroup END
    "     echo "AutoPreview disabled"
    "   else
    "       let g:autoPreview = 1
    "       let updatetime = 2000
    "       augroup AutoPreview
    "       autocmd!
    "         au! CursorHold *.txt ++nested exe "silent! ptag " .. expand("<cword>")
    "         au! CursorHold <buffer>FileType=help,man ++nested exe "silent! ptag " .. expand("<cword>")
    "         au! FileType help,man ++nested call PreviewWord()
    "         au! CursorHold *.[ch] ++nested exe "silent! ptag " .. expand("<cword>")
    "         au! CursorHold *.[ch] ++nested call PreviewWord()
    "       augroup END
    "       echo "AutoPreview enabled"
    "     endif
    " endfunction
    " nnoremap <leader>AP :call ToggleAutoPreview()<CR>

    " function PreviewWord()
    "     if g:autoPreview == 0
    "       return
    "     endif
    "     if &previewwindow
    "       return
    "     endif
    "     let w = expand("<cword>")
    "     if w =~ '\a'
    "       silent! wincmd P
    "       if &previewwindow
    "         match none
    "         wincmd p
    "       endif
    "       try
    "          exe "ptag " .. w
    "       catch
    "         return
    "       endtry
    "       silent! wincmd P
    "       if &previewwindow
    "      if has("folding")
    "        silent! .foldopen
    "      endif
    "      call search("$", "b")
    "      let w = substitute(w, '\\', '\\\\', "")
    "      call search('\<\V' .. w .. '\>')
    "      hi previewWord term=bold gui=underline ctermbg=Grey guibg=#1f1f2e
    "      exe 'match previewWord "\%' .. line(".") .. 'l\%' .. col(".") .. 'c\k*"'
    "      set filetype=help
    "         wincmd p
    "       endif
    "     endif
    " endfunction
" Load command shortcuts generated from bm-dirs and bm-files via shortcuts script.
" here leader is ";". so ":vs ;cfz" will expand into ":vs /home/<user>/.config/zsh/.zshrc"
    silent! source ~/.config/nvim/shortcuts.vim
endif

set runtimepath^=~/.vim runtimepath+=~/.vim/after
let &packpath = &runtimepath
source ~/.vimrc

" vim: set ft=vim sw=2 ts=2 sts=2 et:
