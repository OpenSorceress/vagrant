" au BufNewFile,BufRead *.bash_aliases set filetype=sh ; to overrule an existing filetype
au BufRead,BufNewFile *.bash_aliases setfiletype sh ; to set it only if no filetype has been detected for this extension
