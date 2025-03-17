-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

-- keymap.lua

-- Function to open an external terminal and run a command
local function open_external_terminal(cmd)
  -- Use Terminator to keep the terminal open
  vim.cmd('!terminator --title="Shell Script Output" -e"' .. cmd .. '; read;"')
end

-- Function to check if the current file is a Python file
local function is_python_file()
  return vim.bo.filetype == "python"
end

-- Function to check if the current file is a LaTeX file
local function is_latex_file()
  return vim.bo.filetype == "tex"
end

-- Function to check if the current file is a shell script
local function is_shell_file()
  return vim.bo.filetype == "sh"
end

-- Function to save and run the current Python file in an external terminal
local function run_python_file()
  if is_python_file() then
    vim.cmd("w") -- Save the file
    local filepath = vim.fn.expand("%:p") -- Get the full path of the current file
    local cmd = string.format('python "%s"', filepath) -- Build the command to run the file
    open_external_terminal(cmd) -- Open external terminal and run the command
  else
    print("Not a Python file!") -- Notify the user if it's not a Python file
  end
end

-- Function to save, compile the current LaTeX file with pdflatex, and open the PDF
local function compile_latex_file()
  if is_latex_file() then
    vim.cmd("w") -- Save the file
    local filepath = vim.fn.expand("%:p") -- Get the full path of the current file
    local filename = vim.fn.expand("%:r") -- Get the file name without extension
    local cmd = string.format('pdflatex "%s" && open "%s.pdf"', filepath, filename) -- Build the command
    open_external_terminal(cmd) -- Open external terminal and run the command
  else
    print("Not a LaTeX file!") -- Notify the user if it's not a LaTeX file
  end
end

-- Function to save and run the current shell script in an external terminal
local function run_shell_file()
  if is_shell_file() then
    vim.cmd("w") -- Save the file
    local filepath = vim.fn.expand("%:p") -- Get the full path of the current file
    local cmd = string.format('bash "%s"', filepath) -- Build the command to run the file
    open_external_terminal(cmd) -- Open external terminal and run the command
  else
    print("Not a shell script file!") -- Notify the user if it's not a shell script file
  end
end

-- Function to handle the keybinding logic
local function handle_keymap()
  if is_python_file() then
    run_python_file()
  elseif is_latex_file() then
    compile_latex_file()
  elseif is_shell_file() then
    run_shell_file()
  else
    print("Unsupported file type!") -- Notify the user if the file type is unsupported
  end
end

-- Define keybindings for all modes
local modes = { "n", "v", "i", "c" } -- Normal, Visual, Insert, Command-line modes
for _, mode in ipairs(modes) do
  vim.api.nvim_set_keymap(
    mode,
    "<F12>",
    "", -- No direct command; we'll use a Lua function
    {
      noremap = true,
      silent = false,
      callback = function()
        if mode == "i" or mode == "c" then
          vim.cmd("stopinsert") -- Exit Insert or Command-line mode
        end
        handle_keymap()
      end,
    }
  )
end
