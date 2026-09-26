-- Shift + Arrow selection
vim.keymap.set("n", "<S-Down>", "Vj", { noremap = true, silent = true })
vim.keymap.set("n", "<S-Up>", "Vk", { noremap = true, silent = true })
vim.keymap.set("v", "<S-Down>", "j", { noremap = true, silent = true })
vim.keymap.set("v", "<S-Up>", "k", { noremap = true, silent = true })
vim.keymap.set("n", "<S-Left>", "v", { noremap = true, silent = true })
vim.keymap.set("n", "<S-Right>", "v", { noremap = true, silent = true })
vim.keymap.set("v", "<S-Right>", "l", { noremap = true, silent = true })
vim.keymap.set("v", "<S-Left>", "h", { noremap = true, silent = true })

-- Select all
vim.keymap.set("n", "<C-a>", "ggVG", { noremap = true, silent = true })

-- Copy/Cut/Paste system clipboard
vim.keymap.set({ "n", "v" }, "<C-c>", '"+y', { noremap = true, silent = true })
vim.keymap.set({ "n", "v" }, "<C-x>", '"+d', { noremap = true, silent = true })
vim.keymap.set("n", "<C-v>", '"+p', { noremap = true, silent = true })
vim.keymap.set("v", "<C-v>", '"+p', { noremap = true, silent = true })

-- Visual mode: duplicate selection below
vim.keymap.set("v", "<C-S-Down>", ":t'><CR>gv", { noremap = true, silent = true })

-- Move lines up/down
vim.keymap.set("n", "<A-Up>", ":m .-2<CR>==", { noremap = true, silent = true })
vim.keymap.set("n", "<A-Down>", ":m .+1<CR>==", { noremap = true, silent = true })
vim.keymap.set("v", "<A-Up>", ":m '<-2<CR>gv=gv", { noremap = true, silent = true })
vim.keymap.set("v", "<A-Down>", ":m '>+1<CR>gv=gv", { noremap = true, silent = true })

-- Ctrl+L -> go to end of line in insert mode
vim.keymap.set("i", "<C-l>", "<C-o>$", { noremap = true, silent = true })

-- Ctrl+Shift+L -> go to start of line (first non-blank) in insert mode
vim.keymap.set("i", "<C-A-l>", "<C-o>^", { noremap = true, silent = true })

vim.keymap.set("n", "T", vim.cmd.term)
vim.keymap.set("t", "<C-A-t>", "<C-\\><C-n>")



--C functions
local function compile_run_and_exit_c()
  local filepath = vim.fn.expand("%:p")
  local filedir = vim.fn.expand("%:p:h")
  local filename_no_ext = vim.fn.expand("%:t:r")

  local output_dir = filedir .. "/outputs"
  local output_path = output_dir .. "/" .. filename_no_ext

  -- Create 'outputs' folder if not exists
  vim.fn.mkdir(output_dir, "p")

  -- Open terminal split
  vim.cmd("botright split | terminal")
  vim.cmd("wincmd j")

  local term_job_id = vim.b.terminal_job_id
  local compile_cmd = "cc " .. filepath .. " -o " .. output_path .. " && " .. output_path .. "\n"
  vim.fn.chansend(term_job_id, compile_cmd)

  -- Schedule terminal close 3 seconds after output
  vim.defer_fn(function()
    -- Ensure we're still in a terminal buffer
    if vim.api.nvim_buf_is_valid(0) and vim.bo.buftype == "terminal" then
      -- Close terminal safely
      vim.api.nvim_input("<C-\\><C-n>:close<CR>")
    end
  end, 3000)
end
vim.keymap.set("n", "<F9>", compile_run_and_exit_c, { desc = "Compile, run, and close C file terminal after 3s" })

local function compile_and_run_c()
  local filepath = vim.fn.expand("%:p")
  local filedir = vim.fn.expand("%:p:h")
  local filename_no_ext = vim.fn.expand("%:t:r")

  local output_dir = filedir .. "/outputs"
  local output_path = output_dir .. "/" .. filename_no_ext

  -- Kreiraj 'outputs' folder ako ne postoji
  vim.fn.mkdir(output_dir, "p")

  -- Otvori terminal u donjem splitu
  vim.cmd("botright split | terminal")
  vim.cmd("wincmd j")

  local term_job_id = vim.b.terminal_job_id
  local compile_cmd = "cc " .. filepath .. " -o " .. output_path .. " && " .. output_path .. "\n"
  vim.fn.chansend(term_job_id, compile_cmd)
end
vim.keymap.set("n", "<F10>", compile_and_run_c, { desc = "Compile and run C file" })


--Java make shortcut
local function run_make()
  vim.cmd("botright split | terminal")
  vim.cmd("wincmd j")

  local term_job_id = vim.b.terminal_job_id
  vim.fn.chansend(term_job_id, "make\n")
end

vim.keymap.set("n", "<F11>", run_make, { desc = "Run make in terminal" })



--Java shortcuts
local function open_terminal_in_the_right_path()
  local filepath = vim.fn.expand("%:p")
  local parent = vim.fn.fnamemodify(filepath, ":h:h:h:h:h:h")
  vim.cmd("belowright split | terminal")
  vim.cmd("wincmd j")
  local term_job_id = vim.b.terminal_job_id
  vim.fn.chansend(term_job_id, "cd " .. parent .. "\n")
end

vim.keymap.set("n", "<S-j>", open_terminal_in_the_right_path, { noremap = true, silent = true })

