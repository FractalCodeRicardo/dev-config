
local function ask(text)
  local prompt_values = {
    model =  "qwen2.5-coder:1.5b",
    system = "You are a code generator. Output ONLY valid Lua code. Do not add explanations, comments, markdown, or backticks.",
    prompt = text,
    stream = false,
    n_predict = 32
  }

  local raw_result = vim.fn.system({
    "curl",
    "http://localhost:11434/api/generate",
    "-H", "Content-Type: application/json",
    "-s",
    "-d",
    vim.json.encode(prompt_values)
  })

  local json = vim.json.decode(raw_result)

  local lines = vim.split(json.response, "\n")

  if #lines > 0 then
    table.remove(lines, 1)
  end

  if #lines > 0 then
    table.remove(lines, #lines)
  end
  vim.api.nvim_buf_set_lines(0, -1, -1, false, lines)
end

vim.api.nvim_create_user_command("Ask", function (opt)
  ask(opt.args)
end,
{nargs = 1}
)


