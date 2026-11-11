return {
  enabled = false,
  'nvim-mini/mini.nvim',
  version = '*',
  config = function()
    local animate = require('mini.animate')
    animate.setup( {scroll = {
    enable = true,
    timing = animate.gen_timing.linear({
      duration = 200,
      unit = 'total',
    }),
    subscroll = animate.gen_subscroll.equal({
      max_output_steps = 120,
    }),
  },})
  end
}
