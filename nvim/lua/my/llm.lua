local function ask(paramater)
  local prompt_value = {
    prompt = [[
Yuo are an agent that return lua code.
Rules:
- Output ONLY Lua code
- Use line breaks in the code


]] .. "--" .. paramater,
    n_predict = 64
  }

  local raw_result = vim.fn.system({
    "curl",
    "http://localhost:8080/completion",
    "-H", "Content-Type: application/json",
    "-s",
    "-d",
    vim.json.encode(prompt_value)
  })

  local json = vim.json.decode(raw_result)

  print(json.content)
  local lines = vim.split(json.content, "\n")
  vim.api.nvim_buf_set_lines(0, -1, -1, false, lines)
end

vim.api.nvim_create_user_command("Ask", function (opt)
  ask(opt.args)
end,
{nargs = 1}
)
