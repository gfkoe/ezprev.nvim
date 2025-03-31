## This is a simple neovim plugin that allows you to have a vscode-like peek on files and function definitions

simply hover over the function or a file import and press your keybinding to open a floating window with the definition.

## how to install

lazy.nvim:
```lua
return {
    "gfkoeb/ezprev.nvim"
}
```
## how to use

default keymappings to open floating window of definition under cursor in normal mode:

```vim
<leader>gd
```

Thank you to ```rmagatti/goto-preview``` for the inspiration. Find the project here: [link](https://github.com/rmagatti/goto-preview)
