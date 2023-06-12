# Project

A ZSH plugin that allows direct jumping into project folders.

## Installation

> This is the installation guide for oh-my-zsh.

1. Clone the repo `git clone ...`
2. Copy this folder `project` to `$ZSH_CUSTOM/plugin/project`
3. Enable the plugin in `~/.zshrc`.
   - Add the value project to the plugins. `plugins=(project ...)`

## Concept

The idea is a simple way to switch between projects and its environments. The environment is done via the `autoenv` plugin,
this leaves a way to jump between projects. There is the plugin `jump_folder` but it has more functionality than needed
and therefore takes longer to load at shell start.

Therefore this little plugin was developed.

### Mecahism to switch folder

The plugin basically has a config file that maps the project name to the folder location. Therefore the switch of project
is done by calling the comamnd and the project name. Then you `cd` into the project folder.

The config file is located at `~/.config/project_jump/project_list` and the file has the following structure:
```text
<project-name><space><folder-location>

projectA /home/horse/Dev/Work/ProjectA 
```

The command to switch is `project`.

`project projectA`

In order to shorten it only the first letter `p` is also possible. `p projectA`.

*NEW**

Instead of a project name you can pass the keyword new with a project name and the project location. This
sets up a new project location to jump into.

#### Autocomplete

In order to make it easier, there should be autocomplete that prints out the possible projects to jump into
by a simple tab.
