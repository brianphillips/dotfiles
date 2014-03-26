let perl_fold=1

" Add Perl "use" statement {{{3
function! PerlAddUseStatement()
  let l:save_iskeyword = &l:iskeyword
    setlocal iskeyword=48-57,_,A-Z,a-z,:
    let l:package = input('Package? ', expand('<cword>'))
    let &l:iskeyword = l:save_iskeyword

    " skip if that use statement already exists
    if (search('^use\s\+'.l:package, 'bnw') == 0)
        " below the last use statement, except for some special cases
        let l:line = search('^use\s\+\(constant\|strict\|warnings\|parent\|base\|5\)\@!','bnw')
        " otherwise, below the ABSTRACT (see Dist::Zilla)
        if (l:line == 0)
            let l:line = search('^# ABSTRACT','bnw')
        endif
        " otherwise, below the package statement
        if (l:line == 0)
            let l:line = search('^package\s\+','bnw')
        endif
        " if there isn't a package statement either, put it below
        " the last use statement, no matter what it is
        if (l:line == 0)
            let l:line = search('^use\s\+','bnw')
        endif
        " if there are no package or use statements, it might be a
        " script; put it below the shebang line
        if (l:line == 0)
            let l:line = search('^#!','bnw')
        endif
        " if l:line still is 0, it just goes at the top
        call append(l:line, 'use ' . l:package . ';')
    endif
endfunction
" }}}3

map <leader>us :<C-u>call PerlAddUseStatement()<CR>
