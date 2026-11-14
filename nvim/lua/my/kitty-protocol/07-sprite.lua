-- 1 Init image
-- Esc_Ga=T,i=id,f=100,z=100;payloadEsc\
-- 2. Set Frames
-- Esc_Ga=f,i=id,f=100,z=100;payloadEsc\
-- 3. Start animation
-- Esc_Ga=a,i=id,s=3,v=1Esc\
--

function show_image(file, a)
  local content = vim.fn.readblob(file)
  local content64 = vim.base64.encode(content)

  local command = string.format(
    "\027_Ga=%s,i=1,f=100,z=100;%s\027\\",
    a,
    content64
  )

  vim.api.nvim_ui_send(command)
end

show_image("pacman_1.png", "T")
show_image("pacman_2.png", "f")
show_image("pacman_3.png", "f")
show_image("pacman_4.png", "f")

vim.api.nvim_ui_send(
  "\027_Ga=a,i=1,s=3,v=1\027\\"
)
