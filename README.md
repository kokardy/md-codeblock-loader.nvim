# md-codeblock-loader.nvim
neovim plugin for writing file contents into markdown code block

## Requires
- "nvim-treesitter/nvim-treesitter"
- tree-sitter markdown
## Install
```lua
use({
    "kokardy/md-codeblock-loader.nvim", 
    requires = { "nvim-treesitter/nvim-treesitter" },
})
```

```vim
:TSInstall markdown
```

### Usage

#### Load entire file
```vim
:lua require("md-codeblock-loader.nvim").load("test.py")
```

#### Load file from 2nd line
```vim
:lua require("md-codeblock-loader.nvim").load("test.py", 2)
```

#### Load file from 2nd line to 10th line
```vim
:lua require("md-codeblock-loader.nvim").load("test.py", 2, 10)
```

```python
```
