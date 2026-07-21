_stegos_build() {
    local cur prev words cword
    _init_completion || return
    
    if [[ $cword -eq 1 ]]; then
        local recipes=$(find ${STEGOS_WORKSPACE}/stegos/meta-stegos/recipes-* -maxdepth 2 -name "*.bb" -exec basename {} .bb \; 2>/dev/null | sed 's/_[0-9].*//g')
        COMPREPLY=( $(compgen -W "$recipes" -- "$cur") )
    elif [[ $prev == "-c" ]]; then
        COMPREPLY=( $(compgen -W "clean cleanall compile fetch rootfs" -- "$cur") )
    fi
}
complete -F _stegos_build stegos-build

_stegos_run() {
    local cur prev words cword
    _init_completion || return
    
    if [[ $prev == "-d" || $prev == "--drive" ]]; then
        _filedir '@(img|ext4)'
    else
        COMPREPLY=( $(compgen -W "-g --gui -d --drive" -- "$cur") )
    fi
}
complete -F _stegos_run stegos-run

_stegos_inject_apps() {
    local cur prev words cword
    _init_completion || return
    
    if [[ $cword -eq 1 ]]; then
        local apps=$(ls ${STEGOS_WORKSPACE}/stegos-apps-base 2>/dev/null)
        COMPREPLY=( $(compgen -W "$apps" -- "$cur") )
    elif [[ $cword -eq 2 ]]; then
        _filedir '@(img|ext4)'
    fi
}
complete -F _stegos_inject_apps stegos-inject-apps
