# dotfiles repo


### how to use?

#### installation
-   `sudo apt install stow build-essentials -y`
-   `git clone https://github.com/luis8h/dotfiles.git ~/dotfiles`
-   `cd ~/dotfiles`
-   `stow . -v --adopt`
-   `git restore .`


### documentation / keybindings

#### i3
- ```leader``` alt
- ```leader + shift + o``` cycle workspace between monitors
- ```leader + 1``` open workspace 1
- ```leader + shift + 1``` move window to workspace 1
- ```leader + h/j/k/l``` navigate through windows
- ```leader + shift + h/j/k/l``` move windows around
- ```leader + r``` enter resize mode (use h/j/k/l to resize)
- ```leader + ?``` show shortcuts

#### tmux
##### shortcuts
- ```ctrl + space``` prefix
- ```prefix + c``` create new window
- ```prefix + 1``` switch to window 1
- ```prefix + alt + l/h``` next/previous window
- ```prefix + :``` enter command
- ```prefix + &``` close window
- ```prefix + %``` split window verticaly
- ```prefix + "``` split window horizontaly
- ```prefix + h/j/k/l``` navigate through panes
- ```prefix + {/}``` switch panes
- ```prefix + q``` show pane numbers
- ```prefix + z``` zoom into pane
- ```prefix + !``` turn pane into window
- ```prefix + x``` close pane
- ```prefix + s``` list sessions
- ```prefix + w``` show sessions with windows (attach with enter)
- ```prefix + I``` install plugins when in tmux.conf
- ```prefix + ctrl-s``` save session
- ```prefix + ctrl-r``` restore session
- terminal selection plugin:
    - ```prefix + [``` enter selection mode in terminal
    - ```v``` go into visual mode
    - ```prefix + y``` yank selection
    - ```ctrl + v``` toggle line and rectangle select

##### commands
- ```:swap-window -s 2 -t 1``` swap windows
- ```:new``` new session in tmux
- ```tmux new -s my-session``` create session (-s optional)
- ```tmux ls``` list all sessions
- ```tmux attach``` reattach to session (most recent)
- ```tmux attach -t my-session``` reattach to specific session
- ```tmux source ~/.config/tmux/tmux.conf``` source tmux.conf after plugin
installation or config changes

##### [more ...](https://tmuxcheatsheet.com/)

#### vim
##### shortcuts (not the basic vim movements)
- general
    - ```<leader>``` space
    - ```<leader>u``` toggle undo tree
    - ```<leader>gs``` open git
- netrw file browser
    - ```%``` create file
    - ```d``` create directory
    - ```D``` delete file/directory
    - ```<leader>pv``` open file browser
    - ```<C-r>``` refresh directories
    - ```i``` change fire tree representation
- fuzzy finder
    - ```<leader>pf``` find files (all)
    - ```<C-p>``` find files (git)
    - ```<leader>ps``` find files by text in file
- harpoon
    - ```<leader>a``` add current file to harpoon
    - ```<C-e>``` toggle harpoon menu
    - ```<C-(m|t|n|s)>``` navigate to harpoon file 1, 2, 3, 4 (h replaced with m)
- lsp
    - ```<C-(p|n)>``` navigate through completion list
    - ```<C-y>``` accepts completion
    - ```<C-Space>``` start/open completion
    - ```<leader>gd``` go to definition
    - ```<leader>vca``` show code actions
    - ```<leader>vd``` open floating text to see full error message
    - ```<leader>vrr``` show all references
    - ```<leader>vrn``` rename variable/method/...
- editing
    - ```=``` auto align selected code
    - ```(J|K)``` move selected text up and down
    - ```J``` append line underneath to current line
    - ```<C-(d|u)>``` move page up and down
    - ```zz``` center current line
    - ```<leader>p``` replace text with text in buffer (keeps buffered text)
    - ```<leader>y``` yank to system clipboard
    - ```<leader>d``` deleting to void register
    - ```<C-f>``` search for project (tmux sessions)
    - ```<leader>-s``` replace current word
    - ```<leader>-x``` make file executable without quitting vim


##### commands
- ```:h rtp``` display config paths
- ```:so``` source file
- ```:PackerSync``` install packer plugins (after :so)
- ```:Mason``` opens Mason to install language server etc.
- ```:verbose map <C-h>``` show keymap of C-h



