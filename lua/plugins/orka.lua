local dir = vim.env.ORKA_NVIM_DIR
if not dir or vim.fn.isdirectory(dir) == 0 then return {} end

return { dir = dir }
