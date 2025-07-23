local icons = require("mini.icons")

icons.setup({
  default = {
    default = { glyph = "󰈚" },
    extension = { glyph = "󰈚" },
    file = { glyph = "󰈚" },
    filetype = { glyph = "󰈚" },
  },
  directory = {
    public = { glyph = "󰉌", hl = "MiniIconsBlue" },
  },
  extension = {
    ocaml = { glyph = "", hl = "MiniIconsOrange" },
    re = { glyph = "", hl = "MiniIconsRed" },
    res = { glyph = "", hl = "MiniIconsRed" },
    txt = { glyph = "󰈚", hl = "MiniIconsMagenta" },
    go = { glyph = "", hl = "MiniIconsBlue" },
    yml = { glyph = "󰰳", hl = "MiniIconsMagenta" },
    yaml = { glyph = "󰰳", hl = "MiniIconsMagenta" },
    toml = { glyph = "󰰤", hl = "MiniIconsMagenta" },
    png = { glyph = "󰸭", hl = "MiniIconsGreen" },
    jpg = { glyph = "󰈥", hl = "MiniIconsBlue" },
    gif = { glyph = "󰵸", hl = "MiniIconsMagenta" },
    csv = { glyph = "󱃡", hl = "MiniIconsGreen" },
    mp4 = { glyph = "󰌲", hl = "MiniIconsCyan" },
    mkv = { glyph = "󰌲", hl = "MiniIconsOrange" },
    doc = { glyph = "󰈭", hl = "MiniIconsBlue" },
    zip = { glyph = "󰗄", hl = "MiniIconsGreen" },
    fish = { glyph = "" }, --   󱆃
    lock = { glyph = "󰌾", hl = "MiniIconsRed" },
    -- jsx = { hl = "MiniIconsBlue" },
    -- tsx = { hl = "MiniIconsPurple" },
  },
  file = {
    ["Makefile"] = { glyph = "󰦬", hl = "MiniIconsOrange" }, --   󱌢
    ["makefile"] = { glyph = "󰦬", hl = "MiniIconsOrange" }, --   󱌢
    ["COPYING"] = { glyph = "", hl = "MiniIconsBlue" },
    ["LICENSE"] = { glyph = "󰑺", hl = "MiniIconsYellow" }, -- 󰯂
    [".eslintrc.js"] = { glyph = "󰱺", hl = "MiniIconsYellow" },
    [".node-version"] = { glyph = "󰋘", hl = "MiniIconsGreen" },
    [".prettierrc"] = { glyph = "", hl = "MiniIconsPurple" },
    [".yarnrc.yml"] = { glyph = "", hl = "MiniIconsBlue" },
    ["eslint.config.js"] = { glyph = "󰱺", hl = "MiniIconsYellow" },
    [".eslintrc.cjs"] = { glyph = "󰱺", hl = "MiniIconsYellow" },
    ["package.json"] = { glyph = "", hl = "MiniIconsGreen" },
    ["tsconfig.json"] = { glyph = "", hl = "MiniIconsAzure" },
    ["tsconfig.build.json"] = { glyph = "", hl = "MiniIconsAzure" },
    ["yarn.lock"] = { glyph = "", hl = "MiniIconsBlue" },
    ["lazy-lock.json"] = { hl = "MiniIconsRed" },
    ["kitty.conf"] = { glyph = "" },
    [".tmux.conf"] = { glyph = "", hl = "MiniIconsMagenta" },
    ["tmux.conf"] = { glyph = "", hl = "MiniIconsMagenta" },
    [".terraformrc"] = { glyph = "󱁢", hl = "MiniIconsBlue" },
    ["terraform.rc"] = { glyph = "󱁢", hl = "MiniIconsBlue" },
    ["Dockerfile"] = { glyph = "󰡨", hl = "MiniIconsBlue" },
    ["compose.yml"] = { glyph = "", hl = "MiniIconsOrange" },
    ["compose.yaml"] = { glyph = "", hl = "MiniIconsOrange" },
    ["docker-compose.yml"] = { glyph = "", hl = "MiniIconsOrange" },
    ["docker-compose.yaml"] = { glyph = "", hl = "MiniIconsOrange" },
    ["go.mod"] = { glyph = "", hl = "MiniIconsBlue" },
    ["go.sum"] = { glyph = "", hl = "MiniIconsRed" },
    ["biome.json"] = { glyph = "", hl = "MiniIconsBlue" }, -- 󱘗 󰒔 󰾒 
    [".eslintrc.json"] = { glyph = "", hl = "MiniIconsBlue" },
    ["tailwind.config.ts"] = { glyph = "󱏿", hl = "MiniIconsCyan" },
    ["package-lock.json"] = { glyph = "", hl = "MiniIconsRed" },
    ["README.md"] = { glyph = "", hl = "MiniIconsBlue" },
    ["init.lua"] = { glyph = "", hl = "MiniIconsGreen" },
    [".env"] = { glyph = "", hl = "MiniIconsMagenta" },
    [".toml "] = { glyph = "󰰤", hl = "MiniIconsMagenta" },
  },
  lsp = {
    ["function"] = { glyph = "󰡱", hl = "MiniIconsCyan" },
  },
})

