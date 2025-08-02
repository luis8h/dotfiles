## current state
- eww can be installed like described in the official docs and added to path manually (not in autosetup yet)
- `eww deamon` starts the daemon
- `eww open powermenu --id primary --arg arg1=other` is an example of how to start a bar
- `eww close primary` to close this bar
- `eww kill` to stop the daemon
- There are a some ai generated python scripts in this directory which do not work. The idea is, to create like a manager software which updates variables in the eww bar dynamically. Maybe it would be better to do this in go like [here](https://github.com/owenrumney/eww-bar/tree/master).

