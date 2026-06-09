-- 启用 OSC 52 剪贴板支持
vim.g.clipboard = {
    name = 'OSC 52',
    copy = {
        ['+'] = require('vim.ui.clipboard.osc52').copy('+'),
        ['*'] = require('vim.ui.clipboard.osc52').copy('*'),
    },
    paste = {
        ['+'] = require('vim.ui.clipboard.osc52').paste('+'),
        ['*'] = require('vim.ui.clipboard.osc52').paste('*'),
    },
}

-- (可选) 添加一个视觉反馈，并在每次复制时自动触发同步
vim.api.nvim_create_autocmd('TextYankPost', {
    callback = function()
        vim.highlight.on_yank() -- 高亮显示刚刚复制的内容
        local copy_to_plus = require('vim.ui.clipboard.osc52').copy('+')
        copy_to_plus(vim.v.event.regcontents)
    end,
})
