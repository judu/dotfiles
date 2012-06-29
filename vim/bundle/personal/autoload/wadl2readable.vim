function! Wadl2readable()
	silent! v/path\|name/d
	silent! %s/^\(\s*\).*method.*name="\([^"]*\)".*$/\1method: \2/
	silent! %s;^\(\s*\).*path="\([^"]*\)".*$;\1/\2;
	silent! %s/^\(\s*\).*param.*name="\([^"]*\)".*header.*type="\([^"]*\)".*$/\1header: \2 -> \3/
	silent! %s/^\(\s*\).*param.*name="\([^"]*\)".*type="\([^"]*\)".*$/\1param: \2 -> \3/
	silent! normal gg
endfunction


command! WadlToReadable call Wadl2readable()
