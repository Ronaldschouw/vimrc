# Vim configuration

## Default options

Default options from Debian system are included, so when 'cloning' repository
there are always pulled in and loaded if available (`defaults.vim`).

The following values are set:
  1. disabled
     1. mouse usage (completely)
     1. swapfile
  1. text-related
     1. `tabstop=2`
     1. `textwidth=79`
     1. textwrapping
     1. `expandtabs`
     1. `viminfo` in `~/.vim` folder
  1. search related
     1. case-insensitive + smart case
     1. highlight searches
     1. fix for format options
  1. netrw (`:Sex`)
     1. banner disabled
     1. tree listening
  1. key mappings:
     1. `<C-s>` toggle "spellcheck" mode (see notes)
     1. `<C-p>` toggles "paste" mode


## Colorscheme

Included is the "xoria256"-colorscheme which author uses for a number of years
already. Probably came from: https://www.vim.org/scripts/script.php?script_id=2140
*update: added custom theme colors/draxor*


## Visual Diff

To ease the use of the build-in `vimdiff`, 2 functions are added:
  1. `:Xdiff` open "vim diff" in separate split window
  1. `:Zdiff` to close the "vim diff" split window


## Visual indent

  1. `tabstop=2`
  1. Start visual block, use `<Tab>` or `<S-Tab>` to alter indentation
     1. Alternatively: `<` or `>`


## Bash folding

Autocommands to enable `bash`-folding are added.


## Line numbers

Linenumbering depends on current vim-mode:
  1. `command`: relative linenumbers are shown
  1. `insert`: normal linenumbers are shown
  1. `:Nonu`: temporarily disable linenumbers


## Auto completion

To use auto completion, simply start typing and hit `<Tab>`. It will auto
complete words it knows about. Though one needs to add plugins
if one wants to have completion for required languages (though `Python` is
already added).


## Tabbing

  1. new tab: `ctrl-t` (\<enter\>, type or \<tab\>)
  1. previous tab: `ctrl-left`
  1. next tab: `ctrl-right`
  1. splits -> tabs: `ctrl-w` `shift-t`
  1. undo tabbing: `ctrl-t` `q`


## Window switching

Shortcuts to jump to:

  1. left window: `ctrl-h`
  1. right window: `ctrl-l`
  1. upper window: `ctrl-k`
  1. lower window: `ctrl-j`


## Filetypes

A few specific filetype settings were added.
(haproxy, yaml, tmux, vim, text, tex, python, php, markdown, scss)


## Statusline

Below is an example of the statusline:

```
master ~/.vim/vimrc* 21:16:38 08-jul-2018 [unix][utf-8][paste][EN_US] (vim) asc:109 0007,0036  180:03%
```

Fields explained:
  1. git branch
  1. filename
  1. an asterisk denotes a file change
  1. date last file change (on disk)
  1. file-format
  1. file-encoding
  1. paste-mode
  1. spellcheck language
  1. detected file-type
  1. ascii code character under cursor
  1. character position in line
  1. line-number
  1. total number of lines
  1. percent current cursor position in file


## Plugins

Added a few plugins; though some changed to the likings of the author.
Each plugin has a link to the original source.

  1. `plugin/badwhitespace.vim`: show trailing whitespaces
  1. `plugin/foldtext.vim`: customized foldtext
  1. `plugin/gitbranch.vim`: function(s) to retrieve current branch
  1. `ftplugin/python.vim`: python folds
