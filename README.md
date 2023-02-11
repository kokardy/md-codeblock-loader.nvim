# md-codeblock-loader.nvim
neovim plugin that write file contents into markdown code block

## Install
```lua
use({"kokardy/md-codeblock-loader.nvim"})
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
