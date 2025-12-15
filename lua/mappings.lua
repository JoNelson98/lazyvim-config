require "nvchad.mappings"

-- Split mappings into submodules for clarity
pcall(require, "mappings.core")
pcall(require, "mappings.terminal")
pcall(require, "mappings.completion")
pcall(require, "mappings.tmux_panes")
