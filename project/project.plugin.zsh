# CLI support for jumping between projects
#
# See README.md for details

function p() {
  project "$@"
}

function project() {
  emulate -L zsh
  local action project_alias project_folder config_file

  config_file="$HOME/.config/project_jump.config"

  action="jump"

  if [[ "$1" == "new" ]]; then
    action="new"
    project_folder="$2"
    project_alias="$3"
  elif [[ -n "$1" ]]; then
    project_alias="$1"
  else
    __project_help
    return 1
  fi

  if [[ "$action" == "jump" ]]; then
    # Check if the config file exists
    if [[ ! -f "$config_file" ]]; then
        echo "Configuration file not found: $config_file"
        return 1
    fi

    # Search for the alias in the config file
    project_folder=$(grep "^$project_alias " "$config_file" | awk '{print $2}')

    if [[ -z "$project_folder" ]]; then
      echo "No entry to project $project_alias found."
      return 1
    fi

    # Navigate to the directory
    cd "$project_folder" || return 1
  elif [[ "$action" == "new" ]]; then
    # Add a new entry
    # Check if the directory exists
    if [[ ! -d "$project_folder" ]]; then
      echo "Directory does not exist: $project_folder"
      return 1
    fi

    if [[ -z "$project_alias" ]]; then
      echo "Missing project alias."
      return 1
    fi
    
    # Append the alias to the config file
    echo "${project_alias} ${project_folder}" >> "$config_file"
    
    echo "New project added: ${project_folder} -> ${project_folder}"
  else
    echo "ERROR: Unkown action $action"
    echo "Please check zsh plugin."
    return 69
  fi
}

function __project_help() {
  cat <<EOT
Usage: project [project_alias] - Jumps to the folder set fro the project_alias in ~/.config/project.conf
       project new [project_folder] [project_alias] - Add a new project entry

Alias: p

Examples:
  project myproject         # Jump to the 'myproject' directory
  project new myproject ~/code   # Add a new project entry for 'myproject' for the proejct folder ~/code
  p myproject
EOT
}
