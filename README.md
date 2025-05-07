## This is a simple neovim plugin that allows you to have a vscode-like peek on function and variable definitions.

## how to use

default keymappings to open floating window of definition under cursor in normal mode:

```vim
<leader>gd
```

## how to install

⇁lazy
```lua
return {
    "gfkoeb/ezprev.nvim"
}
```
⇁packer
```lua
use {
    "gfkoeb/ezprev.nvim"
}
```
