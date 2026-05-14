local augroup = vim.api.nvim_create_augroup
local languagesGroup = augroup("Language", {})

local augroup = vim.api.nvim_create_augroup
local utilsGroup = augroup("Utils", {})
local autocmd = vim.api.nvim_create_autocmd

-- Open pdf at external app
autocmd("BufReadCmd", {
	group = utilsGroup,
	pattern = "*.pdf",
	callback = function()
		local filename = vim.fn.shellescape(vim.api.nvim_buf_get_name(0))
		vim.cmd("silent !zathura " .. filename .. " &")
		vim.cmd("let tobedeleted = bufnr('%') | b# | exe \"bd! \" . tobedeleted")
	end,
})

-- Open images at external app
autocmd("BufReadCmd", {
	group = utilsGroup,
	pattern = { ".png", ".jpg", ".jpeg", ".gif", "*.webp" },
	callback = function()
		local filename = vim.fn.shellescape(vim.api.nvim_buf_get_name(0))
		vim.cmd("silent !eyestalk " .. filename .. " &")
		vim.cmd("let tobedeleted = bufnr('%') | b# | exe \"bd! \" . tobedeleted")
	end,
})

-- Lsp config
autocmd("LspAttach", {
	group = languagesGroup,
	callback = function(e)
		local opts = { buffer = e.buf }
		vim.keymap.set("n", "gd", function()
			vim.lsp.buf.definition()
		end, opts)
		vim.keymap.set("n", "K", function()
			vim.lsp.buf.hover()
		end, opts)
		vim.keymap.set("n", "<leader>vws", function()
			vim.lsp.buf.workspace_symbol()
		end, opts)
		vim.keymap.set("n", "<leader>vd", function()
			vim.diagnostic.open_float()
		end, opts)
		vim.keymap.set("n", "<leader>vca", function()
			vim.lsp.buf.code_action()
		end, opts)
		vim.keymap.set("n", "<leader>vrr", function()
			vim.lsp.buf.references()
		end, opts)
		vim.keymap.set("n", "<leader>vrn", function()
			vim.lsp.buf.rename()
		end, opts)
		vim.keymap.set("i", "<C-h>", function()
			vim.lsp.buf.signature_help()
		end, opts)
		vim.keymap.set("n", "[d", function()
			vim.diagnostic.goto_next()
		end, opts)
		vim.keymap.set("n", "]d", function()
			vim.diagnostic.goto_prev()
		end, opts)
	end,
})

local save_group = vim.api.nvim_create_augroup("SmartFormatAndSave", { clear = true })
local function clear_cmdarea()
	vim.defer_fn(function()
		vim.api.nvim_echo({}, false, {})
	end, 800)
end

-- Helper
local allowed_extensions = {
	lua = true,
	py = true,
	go = true,
	nix = true,
	cpp = true,
	c = true,
}

local function is_allowed(buf)
	local name = vim.api.nvim_buf_get_name(buf)
	local ext = vim.fn.fnamemodify(name, ":e"):lower()

	if ext == "" then
		return false
	end

	return allowed_extensions[ext] == true
end

-- Format before save
vim.api.nvim_create_autocmd("BufWritePre", {
	group = save_group,
	callback = function(args)
		local buf = args.buf

		if not is_allowed(buf) then
			return
		end

		require("conform").format({
			bufnr = buf,
			async = false,
		})
	end,
})

-- Smaert auto-save
autocmd({ "InsertLeave", "BufLeave", "FocusLost" }, {
	group = save_group,
	callback = function(args)
		local buf = args.buf or 0

		if not is_allowed(buf) then
			return
		end

		if vim.bo[buf].modified and vim.bo[buf].buftype == "" then
			vim.cmd("silent update")
			local time = os.date("%I:%M %p")
			vim.api.nvim_echo({ { "󰄳", "LazyProgressDone" }, { " file autosaved at " .. time } }, false, {})
			clear_cmdarea()
		end
	end,
})

-- restore the last position
autocmd("BufReadPost", {
	group = save_group,
	pattern = { "*" },
	callback = function()
		local line = vim.fn.line("'\"")
		if line > 1 and line <= vim.fn.line("$") then
			vim.cmd('normal! g`"zv')
		end
	end,
})

-- Auto-create missing directories on save
local auto_mkdir_group = augroup("auto_mkdir", { clear = true })
autocmd("BufWritePre", {
	group = auto_mkdir_group,
	callback = function(event)
		if event.match:match("^%w%w+://") then
			return
		end
		local dir = vim.fn.fnamemodify(event.match, ":p:h")
		vim.fn.mkdir(dir, "p")
	end,
})
