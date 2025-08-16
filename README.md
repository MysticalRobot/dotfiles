# dotfiles

configurations for some of the applications i use in 
my macOS setup. \
currently, everything with a gui of its own is using the gruvbox theme


## alacritty

- i use alacritty instead of the default terminal because it allows for more 
customization 

## yazi

- i use yazi as a terminal based file explorer, and i have it integrated with 
neovim
- i gravitated towards it because you can traverse directories with vim keybinds
- i haven't really configured anything besides the theme

## nvim

- i use neovim as an ide
- this configuration is based on a prerelease version of neovim (v0.12),
and so it makes use of the new builtin plugin manager and improved lsp setup
for a simpler configuration (perfect opportunity to join this side if you ask me)

## tmux

- i use tmux to create panes while in the terminal and persist terminal sessions 
so that i can jump right back into what i was doing
- i also have this configured so it works seamlessly with neovim

## karabiner

- i use karabiner elements to bind ctrl-[ to esc on my laptop so that it is 
consistent with my neovim bindings
- this rule can be found from lines 20-50 in karabiner.json

## yabai

- i use yabai to simplify window management on my laptop
- you may have already guessed it, but i was drawn to it because not only does it
kinda look cool, but i can also use vim-like bindings to change windows

## skhd

- i use skhd to give myself the ability to change windows in yabai with vim like 
commands

## opencode

- i use opencode to interact with agentic models in neovim and the terminal when i 
reach my limits for gemini-cli

## gemini-cli 

- i use gemini-cli to interact with google gemini models in neovim and the terminal 

--- 

## honorable mentions

while not in this directory, but in my zsh configuration, i use eza and zoxide 
as nicer alternatives to ls and cd respectively, and i use vimium in my 
browser to ingrain vim movements into my soul
