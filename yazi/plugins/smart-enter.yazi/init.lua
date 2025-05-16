---@diagnostic disable: undefined-global

return {
	entry = function()
		local h = ex.active.current.hovered
		-- if h and h.cha.is_dir then
		-- 	ya.manager_emit("enter", {})
		-- 	return
		-- end

		if #args > 0 and args[1] == "detach" then
			os.execute(string.format('opener detach "%s"', h.url))
		else
			ya.manager_emit("open", {})
		end
	end,
}
