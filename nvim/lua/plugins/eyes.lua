return {
  enabled = true,
  "FractalCodeRicardo/eyes-wide-bright",
  config = function()
    require("eyes-wide-bright").setup({
      mode = "normal" -- options: "normal", "warm", "cold"
    })
  end
}
