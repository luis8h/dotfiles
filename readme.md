# dotfiles repo

test

### new to learn/use
-   neoclip
-   `//` for searching after selected text
-   H and L for jumping to begin/end of line
-   indenting in visual mode
-   fugitive gs
-   gitsigns (more view not do)
-   neogit

### how to use?

#### installation
-   `sudo apt install stow build-essentials -y`
-   `git clone https://github.com/luis8h/dotfiles.git ~/dotfiles`
-   `cd ~/dotfiles`
-   `stow . -v --adopt`
-   `git restore .`

#### notes
-   if tmux plugins not working delete plugin directory and run the install with prefix + I in tmux.conf again
-   if local dns is not working disable ubuntu default dns server (bind9 doc)
-   mounting ntfs file system on linux: `/dev/nvme1n1p2 /mnt/data ntfs-3g rw 0 0` in /etc/fstab
-   when using gradle project, java lsp is not woring when the java version of the gradle project is not installed (lsp shows everything as error)
-   changing resolution of displays: `xrandr --output <display-output-name> --scale 1.4x1.4`
-   getting display output names: `xrandr | grep connected | grep -v disconnected | awk '{print $1}'`
-   clang project setup: use `bear -- make` (`sudo apt install bear -y`) instead of `make` to generate `compile_commands.json` -> clangd will recoginze the project

### device specific configuration
Device specific configuration like environment variables are set in the
`.dotfiles-settings` file in the home directory. If existing, this file is
automaticly sourced in the `.profile` file. <br>
An example would be the data directory which is needed for the nvim-telescope
find files command.

### how to setup autocleaning of downloads directory at startup
-   `crontab -e` to access cron config file
-   append the following line: `@reboot ~/.scripts/clean-downloads.sh`

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
    - ```g then <Ctrl-g>``` shows word count (works also with selected text)
- netrw file browser
    - ```%``` create file
    - ```d``` create directory
    - ```D``` delete file/directory
    - ```<leader>pv``` open file browser
    - ```<C-r>``` refresh directories
    - ```i``` change fire tree representation
    - ```-``` go 1 directory back
    - ```cd``` make browse directory current directory
    - ```o``` enter file/directory in new window (horizontaly)
    - ```v``` enter file/directory in new window (verticaly)
    - ```t``` enter file/direcotry in new tab
    - ```gt/gT``` go to next/previous tab
- netrw hiding
    - ```a``` toggle hide hidden directories (hiding list)
    - ```gh``` toggle dot-files hiding
- netrw bookmarks
    - ```mb``` bookmark current directory
    - ```gb``` go to last bookmarked directory
    - ```qb``` show history/bookmars
    - ```qf``` display file info
- netrw marking
    - ```mf``` mark file
    - ```mf``` unmark files
    - ```mc``` copy marked files to marked-file target directory
    - ```mt``` current browsing directory becomes markfile target
    - ```mm``` move marked files to target
    - ```mr``` mark files/directories using regexp
    - ```mu``` unmark all marked files
    - ```mz``` toggle compression of marked files
- surrounding
    - note: replaces default keybind ```S``` with ```T```
    - ```ysw(``` surround word with () (use <)> for no whitespaces)
    - ```yss"``` surround current line with "
    - ```T"``` surround selection with "
    - ```ds"``` delete " surrounding (not in visual mode)
    - ```cs"'``` change surrounding " to ' (not in visual mode)
    - ```ysa"(``` surrounds with ( around "
    - ```cst``` change html tag surrounding
    - ```dst``` delete surrounding html tag
    - ```yswf``` surrounds word with function (also possible in v mode with S) (c and d also possible to change/delete function)
    - custom aliases: c = ```
- treesj (expand code over multiple lines)
    - ```mt``` toggle split
    - ```ms``` split
    - ```mj``` join
    - ```Mt``` recursive toggle (also works with s and j
- leap (better navigation) ---- replaced with flash.nvim
    - note: replaces ```s``` and ```S``` keybindings - possible equivalents:
        - ```s``` = ```cl``` (or ```xi```)
        - ```S``` = ```cc```
        - ```v_s``` = ```v_c``` (v_ for stands for when being in visual mode)
        - ```v_S``` = ```Vc```
    - ```s``` search forward
    - ```S``` search backwards
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
- spelling
    - ```<leader>z``` enable spelling
    - ```zde``` change spelllang to de
    - ```zen``` change spelllang to en_us
    - ```z=``` show list of correct spelled words
    - ```zg``` add word to dictionary
    - ```zG``` ignore word temporary
    - ```[s``` go to previous mistake
    - ```]s``` go to next mistake


##### commands
- ```:h rtp``` display config paths
- ```:so``` source file
- ```:PackerSync``` install packer plugins (after :so)
- ```:Mason``` opens Mason to install language server etc.
- ```:verbose map <C-h>``` show keymap of C-h



### tmux plugin customization

#### fzf-tmux

**this is a github issue copy where fzf tmux customizatino is explained**

This is a good idea, this feature is supported via 09e5e0b.

Preselect session, window or pane
Simply bind a key to execute the shell script

bind-key "C-l" run-shell -b "/home/sainnhe/.tmux/plugins/tmux-fzf/scripts/session.sh"
All available shell scripts can be found in /path/to/tmux-fzf/scripts.

Preselect action
Pass a parameter to the shell script:

bind-key "C-l" run-shell -b "/home/sainnhe/.tmux/plugins/tmux-fzf/scripts/session.sh attach"
Will execute attach session.

Available actions:

scripts/session.sh: attach, detach, rename, kill
scripts/window.sh: switch, link, move, swap, rename, kill
scripts/pane.sh: switch, break, join, swap, layout, kill, resize
scripts/clipboard.sh: system, buffer
scripts/process.sh: display, tree, terminate, kill, interrupt, continue, stop, quit, hangup
Add frequently used actions to the user menu
For example, in ~/.tmux.conf:

TMUX_FZF_MENU=\
"attach session\n/home/sainnhe/.tmux/plugins/tmux-fzf/scripts/session.sh attach\n"\
"rename window\n/home/sainnhe/.tmux/plugins/tmux-fzf/scripts/window.sh rename\n"
will add attach session and rename window to the user menu.

or watch online [here](https://github.com/sainnhe/tmux-fzf/issues/6#issuecomment-578750879)


### regolith customization
To change a regolith keybinding look into `/usr/share/regolith/...`.
There are several files which are all included by the main file.
The variables in these files can be set via the `.config/i3/Xresources` file.
For additional shortcuts just add to `.config/i3/regolith3/i3/config`.

changing wallpaper: probably in gnome tweaks
changing look to dracula:
-   `sudo apt install regolith-look-dracula -y`
-   `regolith-look set dracula`
-   to list all looks: regolith-look list
