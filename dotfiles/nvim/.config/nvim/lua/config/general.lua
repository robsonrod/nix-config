vim.opt.path:append( "**")
local cwd = vim.fn.getcwd()
vim.opt.path:append(cwd .. "/**")

