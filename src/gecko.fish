#!/usr/bin/env fish

function gecko
    set -x env_path ~/.config/gecko

    function errorMsg
        set msg $argv[1]
        set_color -o red
        echo "❌ $msg"
        set_color normal
    end

    function successMsg
        set msg $argv[1]
        set_color -o blue
        echo "✅ $msg"
        set_color normal
    end

    function envExist
        set name $argv[1]
        if test -d "$env_path/$name"
            return 0
        else
            return 1
        end
    end
    function geckoExist
        if test ! -d $env_path
            mkdir -p $env_path
        end
    end

    function listEnv
        set envList (ls $env_path)

        for env in $envList
            echo $env
        end

    end

    function create
        set name $argv[1]
        set python_version $argv[2]

        geckoExist

        if envExist $name
            errorMsg "This env already exist"
            return 1
        end

        if test -n "$python_version"
            set python_path "$HOME/.pyenv/versions/$python_version/bin/python"
            if test ! -x "$python_path"
                errorMsg "Python version $python_version not found in pyenv"
                return 1
            end
        else
            set python_path python
        end

        "$python_path" -m venv "$env_path/$name"
        successMsg "Env has been created"
        echo -e "\nYou can activate the new env with:\n"
        echo "gecko -a $name"
    end

    function remove
        set name $argv[1]
        if envExist $name
            if test -n $VIRTUAL_ENV
                if test "$VIRTUAL_ENV" = "$env_path/$name"
                    deactivate
                end
            end
            rm -rf "$env_path/$name"
            successMsg "$name has been removed"
            return 0
        else
            errorMsg "Env do not exist"
            return 1
        end
    end

    function activate
        set name $argv[1]
        if envExist $name
            source "$env_path/$name/bin/activate.fish"
        else
            errorMsg "Env do not exist"
            return 1
        end
    end

    function _help
        echo -e "🦎 Usage:\n"
        echo -e "gecko [OPTIONS] <arguments>\n"
        echo "Options:"
        echo "-h, --help     Show this help"
        echo "-c, --create   Create environment (requires name)"
        echo "-a, --activate Activate environment (requires name)"
        echo "-r, --remove   Remove environment (requires name)"
        echo "-l, --list     List environments"
        echo -e "\n"
        echo "Examples:"
        echo "gecko --create myenv"
        echo "gecko --activate myenv"
        echo "gecko --remove myenv"
        echo "gecko --list"
        echo "'deactivate' to exit from the active env"
        echo -e "\n"
    end
    set -l opts (fish_opt -s h -l help)
    set opts $opts (fish_opt -s c -l create -r)
    set opts $opts (fish_opt -s p -l python -r)  # New: --python/-p to specify version
    set opts $opts (fish_opt -s a -l activate -r)
    set opts $opts (fish_opt -s r -l remove -r)
    set opts $opts (fish_opt -s l -l list)
    argparse $opts -- $argv

    #############
    # Show help #
    #############
    if set -ql _flag_h
        _help
    end

    ####################
    # Create a new env #
    ####################
    if set -ql _flag_c
        set python_ver ""
        if set -ql _flag_p
            set python_ver $_flag_p
        end
        create $_flag_c $python_ver

    end

    #################
    # Acitavate env #
    #################
    if set -ql _flag_a
        activate $_flag_a

    end

    ##############
    # Remove env #
    ##############
    if set -ql _flag_r
        remove $_flag_r
    end

    if set -ql _flag_l
        listEnv

    end
end
