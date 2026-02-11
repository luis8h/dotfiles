# dotfiles repo


## getting started
#### installation
-   `sudo apt install stow build-essentials -y`
-   `git clone https://github.com/luis8h/dotfiles.git ~/dotfiles`
-   `cd ~/dotfiles`
-   `stow . -v --adopt` **`--adopt` adopts the already existing files**
-   `git restore .` **watch out, this goes back to the last commit and therefore deletes the changes adopted from the existing files**

## known issues
#### nvim
-   when using gradle project, java lsp is not woring when the java version of the gradle project is not installed (lsp shows everything as error)
-   jdtls might not detect the root dir of a maven project. -> just create a `.git` dir even if not using git to make the detectino more reliable, somehow it does not work with `pom.xml` ...

#### tmux
- when exiting i3 session and logging back in, the global clipboard in tmux is not working any more. to fix this just use `tmux kill-server` and then restart tmux

#### macos
- the iterm2 remap modifier trick does only work if it does not have permissions in apple system settings (otherwise window management will also use the other key...)
- disable in "privacy security -> Accessebility -> iterm (disable)"

## usefull tips
#### nvim
-   clang project setup: use `bear -- make` (`sudo apt install bear -y`) instead of `make` to generate `compile_commands.json` -> clangd will recoginze the project
-   changing tabwidth in neovim:
    * `:set tabstop=2`
    * `:set shiftwidth=2`
    * `:set expandtab`
- lsp configuration: use [this link](https://github.com/neovim/nvim-lspconfig/blob/master/doc/configs.md) for online docs or just run `:help lspconfig-all` in nvim.

#### ghostty os specific config
This is implemented by including a non existing file in the ghostty config that can be created by linking another file to it. This is done automatically on macos by adding the following to `.profile`:
```sh
if [[ "$OSTYPE" == "darwin"* ]]; then
    ln -sf ~/.config/ghostty/macos.conf ~/.config/ghostty/os-specific
fi
```


#### latex/markdown grammar checking
- download the ngramms model from [this link](https://languagetool.org/download/ngram-data/) (choose the desired languages)
- put it into the directory `~/models/ngrams/<language-code>`
- [full guide](https://medium.com/@Erik_Krieg/free-and-open-source-grammar-correction-in-neovim-using-ltex-and-n-grams-dea9d10bc964)

#### device specific configuration
Device specific configuration like environment variables are set in the
`.dotfiles-settings` file in the home directory. If existing, this file is
automaticly sourced in the `.profile` file. <br>
An example would be the data directory which is needed for the nvim-telescope
find files command.
**example:**
```shell
export H8_DEVICE=yoga-laptop
export "H8_DATA_DIR"="/mnt/data"
export "H8_KBASE_DIR"="/mnt/data/kbase"
```

## macos
#### kanata (self built for newest version)
- (brew has also newest version, but is currently not working -> no output when typing)
- install karabiner elements (using brew)
- activate karabiner in login items -> driver extensions (on info symbol)
- open karabiner and then quit it
- `git clone https://github.com/jtroo/kanata && cd kanata`
- `cargo build`   # --release optional, not really perf sensitive
- `sudo target/debug/kanata --cfg <your_configuration_file>`
- start kanata with all three configs: `sudo kanata -c ./config1.kbd -c ./config2.kbd ...`
- if error: under privacy and security add kanata (path/to/kanata/binary) to input monitoring
- command example: `sudo target/debug/kanata -c ~/dotfiles/.config/kanata/macos/config-macos-default.kbd -c ~/dotfiles/.config/kanata/macos/config-macos-moon.kbd -c ~/dotfiles/.config/kanata/macos/config-macos-keyboard.kbd`

#### iterm2 setup
- install using brew
- load settings from folder in dotfiles
- when setting settings manually watch out that bracketed paste mode is activated on the copy paste command
- change text size: `LMET=`

#### modifier keys (deprecated - not needed any more because iterm2 supports direct modifier remapping)
macos has some keybinds on command key and some on ctrl which are normally only on ctrl. To make this like any other os i used karabiner. Karabiner remaps the control+letter keys to command+letter in all applications. Only kitty is excluded, because tmux and nvim need the default ctrl behavior to work.
The following code block is used to achieve this:
``` json
"conditions": [
    {
        "bundle_identifiers": [
            "^((?!net\\.kovidgoyal\\.kitty).)*$"
        ],
        "type": "frontmost_application_if"
    }
],
```
If another application should also be added just add it to the array. The name (bundle identifier) can be found out using this command: `osascript -e 'id of app "Application Name"'`.


## tmux plugin customization
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


## regolith customization (deprecated - not used any more)
To change a regolith keybinding look into `/usr/share/regolith/...`.
There are several files which are all included by the main file.
The variables in these files can be set via the `.config/i3/Xresources` file.
For additional shortcuts just add to `.config/i3/regolith3/i3/config`.

changing wallpaper: probably in gnome tweaks
changing look to dracula:
-   `sudo apt install regolith-look-dracula -y`
-   `regolith-look set dracula`
-   to list all looks: regolith-look list
