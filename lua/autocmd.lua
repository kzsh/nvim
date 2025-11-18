vim.cmd([[
"==========================================================
" FileType-specific formatting
"==========================================================
autocmd BufRead,BufNewFile *.applescript      setlocal filetype=applescript
autocmd BufRead,BufNewFile *.avdl             setlocal filetype=avdl
autocmd BufRead,BufNewFile Jenkinsfile*       setlocal filetype=groovy
autocmd BufRead,BufNewFile *Jenkinsfile       setlocal filetype=groovy
autocmd BufRead,BufNewFile .babelrc           setlocal filetype=json
autocmd BufRead,BufNewFile .eslintrc          setlocal filetype=json
autocmd BufRead,BufNewFile .stylelintrc       setlocal filetype=json
autocmd BufRead,BufNewFile coc-settings.json  setlocal filetype=jsonc
autocmd BufRead,BufNewFile tsconfig.json      setlocal filetype=jsonc
autocmd BufRead,BufNewFile *.kt               setlocal filetype=kotlin
autocmd BufRead,BufNewFile *.kt               setlocal filetype=kotlin
autocmd BufRead,BufNewFile *.markdown         setlocal filetype=markdown
autocmd BufRead,BufNewFile *.md               setlocal filetype=markdown
autocmd BufRead,BufNewFile *.mkd              setlocal filetype=markdown
autocmd BufRead,BufNewFile *.jbuilder         setlocal filetype=ruby
autocmd BufRead,BufNewFile Podfile*           setlocal filetype=ruby
autocmd BufRead,BufNewFile Vagrantfile*       setlocal filetype=ruby
autocmd BufRead,BufNewFile Dockerfile*        setlocal filetype=dockerfile
autocmd BufRead,BufNewFile *.dockerfile       setlocal filetype=dockerfile
autocmd BufRead,BufNewFile *-Dockerfile       setlocal filetype=dockerfile
autocmd BufRead,BufNewFile *-dockerfile       setlocal filetype=dockerfile
autocmd BufRead,BufNewFile .envrc             setlocal filetype=sh
autocmd BufRead,BufNewFile *.swift            setlocal filetype=swift
autocmd BufRead,BufNewFile *.ts               setlocal filetype=typescript
autocmd BufRead,BufNewFile *.tsx              setlocal filetype=typescript.tsx
autocmd BufRead,BufNewFile *.dust             setlocal filetype=dust
autocmd BufRead,BufNewFile *.mongo.js         setlocal filetype=mongodb.javascript
autocmd BufRead,BufNewFile *.handlebars       setlocal filetype=mustache
autocmd BufRead,BufNewFile requirements.txt   setlocal filetype=python
autocmd BufRead,BufNewFile *.ipynb            setlocal filetype=python
autocmd BufRead,BufNewFile .gitignore*        setlocal filetype=conf
autocmd BufRead,BufNewFile *sxhkdrc           setlocal filetype=sxhkdrc
autocmd BufRead,BufNewFile *.cypher           setlocal filetype=cypher
autocmd BufRead,BufNewFile rules              setlocal filetype=make
autocmd BufRead,BufNewFile .swcrc             setlocal filetype=json
autocmd BufRead,BufNewFile *.yml.template     setlocal filetype=yaml
autocmd BufRead,BufNewFile .xinitrc           setlocal filetype=sh
autocmd BufRead,BufNewFile default.conf       setlocal filetype=conf

" set Tabs per file-type.  (current unused, see above)
autocmd Filetype html setlocal ts=2 sts=2 sw=2
autocmd Filetype css setlocal ts=2 sts=2 sw=2
autocmd Filetype tag setlocal ts=2 sts=2 sw=2 syntax=ON
autocmd Filetype xml setlocal ts=2 sts=2 sw=2
autocmd Filetype jsp setlocal ts=2 sts=2 sw=2
autocmd Filetype ruby setlocal ts=2 sts=2 sw=2
autocmd Filetype javascript setlocal ts=2 sts=2 sw=2
autocmd Filetype mongodb.javascript setlocal ts=2 sts=2 sw=2 syntax=javascript
autocmd Filetype typescript setlocal ts=2 sts=2 sw=2
autocmd Filetype m setlocal ts=4 sts=4 sw=4
autocmd Filetype h setlocal ts=4 sts=4 sw=4
autocmd Filetype wflow setlocal ts=4 sts=4 sw=4 syntax=ON
autocmd Filetype plist setlocal ts=4 sts=4 sw=4 syntax=ON
autocmd Filetype swift setlocal ts=2 sts=2 sw=2
autocmd Filetype applescript setlocal ts=4 sts=4 sw=4 noexpandtab syntax=ON
autocmd Filetype groovy setlocal ts=4 sts=4 sw=4 syntax=ON
autocmd Filetype kotlin setlocal ts=4 sts=4 sw=4
autocmd Filetype markdown setlocal conceallevel=0 spell
autocmd Filetype json setlocal conceallevel=0
autocmd Filetype gitconfig setlocal ts=2 sts=2 sw=2 noexpandtab syntax=ON
autocmd Filetype fugitiveblame setlocal syntax=ON
autocmd Filetype git* setlocal spell syntax=ON
autocmd Filetype sxhkdrc setlocal ts=2 sts=2 sw=2 noexpandtab syntax=ON syntax=conf
" autocmd Filetype vim setlocal syntax=ON
autocmd Filetype make setlocal syntax=ON
" autocmd Filetype toml setlocal syntax=ON
" autocmd Filetype dockerfile setlocal syntax=ON
" autocmd Filetype yaml setlocal syntax=ON
autocmd Filetype xf86conf setlocal syntax=ON
" autocmd Filetype c setlocal syntax=ON
" autocmd Filetype cpp setlocal syntax=ON
" autocmd Filetype lua setlocal syntax=ON
autocmd Filetype cypher setlocal syntax=ON commentstring=//\ %s
autocmd Filetype checkhealth setlocal syntax=ON
autocmd Filetype diff setlocal syntax=ON
autocmd Filetype csv setlocal syntax=ON
autocmd Filetype svelte setlocal tabstop=2 softtabstop=2 shiftwidth=2
autocmd Filetype conf setlocal syntax=ON
autocmd Filetype vimwiki setlocal ts=2 sts=2 sw=2 syntax=ON


autocmd FileType json syntax match Comment +\/\/.\+$+

autocmd Filetype javascript setlocal makeprg=pretty-quick\ --pattern\ %
autocmd Filetype typescript setlocal makeprg=pretty-quick\ --pattern\ %


"==========================================================
" Run Autocommit on TODO.md
"==========================================================
let g:notes_path = expand("$NOTES_DIR")
augroup autoCommitChangesToNotes
  au!
  " TODO: don't execute todo commit for any TODO.md file anywhere.
  autocmd BufWritePre ~/notes/** silent! execute('!' . g:notes_path . '/autocommit.sh')
augroup END

"==========================================================
" Start terminal in insert mode
"==========================================================
autocmd TermOpen * startinsert
autocmd TermLeave * setlocal number
autocmd TermEnter * setlocal nonumber


]])
