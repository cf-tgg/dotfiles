M = {}

-- vim.cmd([[
-- 		function! s:expand(expr) abort
-- 		  return exists('*DotenvExpand') ? DotenvExpand(a:expr) : expand(a:expr)
-- 		endfunction
-- 	]])
--
-- -- Custom function to source DATABASE_URL from pass
-- vim.cmd([[
-- 	     function! s:env(var) abort
-- 	return exists('*DotenvGet') ? DotenvGet(a:var) : eval('$'.a:var)
-- 	     endfunction
-- 	     " Set the DATABASE_URL by sourcing it from pass
-- 	     let g:db = trim(system('pass mongoDB_Locale'))
--
-- 	     if empty(g:db)
-- 		let g:db = s:env('DBUI_URL')
-- 	     endif
-- 	   ]])
--
-- -- Input validation
-- -- vim.cmd('echom "DB_URL: " . g:db')

return M
