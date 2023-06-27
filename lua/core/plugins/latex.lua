return {
  'ryleelyman/latex.nvim',
  opts = {
    conceals = {
      enabled = {
        "greek",
        "math",
        "font"
      },
      add = {}
    },
    imaps = {
      enabled = false,
      add = {},
      default_leader = "`"
    },
    surrounds = {
      enabled = false,
      command = "c",
      environment = "e",
    }
  }
}
