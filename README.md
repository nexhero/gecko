
# Table of Contents

1.  [Features](#orgab67acc)
2.  [Installation](#org0559be7)
3.  [Notes](#orgee68bac)
4.  [Commands](#orgefedd2b)

![img](./assets/gecko_image.jpg)

A Fish shell command-line tool for managing Python virtual environments. It allows creating, activating, removing, and listing environments, with support for specifying Python versions via pyenv.


<a id="orgab67acc"></a>

# Features

-   Create virtual environments with specified Python versions
-   Activate and deactivate environments
-   Remove environments
-   List all available environments
-   Easy to use with command-line flags


<a id="org0559be7"></a>

# Installation

    git clone https://github.com/nexhero/gecko.git
    cd gecko
    makepkg -si


<a id="orgee68bac"></a>

# Notes

-   This script works with Arch-based distributions as Fish and pyenv are available in their repositories
-   The environments are stored in \`~/.config/gecko\`
-   Use \`deactivate\` to exit from an active environment


<a id="orgefedd2b"></a>

# Commands

-   \`&#x2013;create <name>\`: Creates a new environment. Optional \`&#x2013;python <version>\` to specify Python version.
-   \`&#x2013;activate <name>\`: Activates the specified environment.
-   \`&#x2013;remove <name>\`: Removes the specified environment.
-   \`&#x2013;list\`: Lists all environments.
-   \`&#x2013;help\`: Displays help information.

