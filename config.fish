function typewrite
    for arg in $argv
        for i in (seq (string length $arg))
            echo -n (string sub -s $i -l 1 $arg)
            sleep 0.01
        end
    end
    echo ""
end
function fish_greeting
#    export LANG=C.UTF-8
#    export LC_ALL=C.UTF-8

        typewrite ""
        typewrite " Hallo, " (whoami) "!"
        typewrite " Willkommen zurück! Heute ist " (env LANG=de_DE.UTF-8 date '+%A, %B %d, %Y') "."
        typewrite " Ein neuer Tag ist eine leere Leinwand. Mal sie nach deinen Wünschen! 🚀"
        typewrite ""

    # Display the figlet banner with lolcat
    figlet -f Bloody "DevSnx" | lolcat -a -d 1

end
#OhMyPosh theme
oh-my-posh init fish --config $HOME/.poshthemes/wholespace.omp.json | source
#oh-my-posh init fish --config $HOME/.poshthemes/cert.omp.json | source
if status is-interactive
    # Commands to run in interactive sessions can go here
end

# Custom colors for fish
set -g fish_color_autosuggestion brblack
set -g fish_color_cancel -r
set -g fish_color_command bright green
set -g fish_color_comment red
set -g fish_color_cwd green
set -g fish_color_cwd_root red
set -g fish_color_end green
set -g fish_color_error brred
set -g fish_color_escape brcyan
set -g fish_color_history_current --bold
set -g fish_color_host normal
set -g fish_color_host_remote yellow
set -g fish_color_normal normal
set -g fish_color_operator brcyan
set -g fish_color_param cyan
set -g fish_color_quote yellow
set -g fish_color_redirection cyan --bold
set -g fish_color_search_match bryellow --background=brblack
set -g fish_color_selection white --bold --background=brblack
set -g fish_color_status red
set -g fish_color_user brgreen
set -g fish_color_valid_path --underline
set -g fish_key_bindings fish_default_key_bindings
set -g fish_pager_color_completion normal
set -g fish_pager_color_description yellow --italics
set -g fish_pager_color_prefix normal --bold --underline
set -g fish_pager_color_progress brwhite --background=cyan
set -g fish_pager_color_selected_background -r
set -gx TERMINAL xterm
set -g theme_nerd_fonts yes
set -gx PATH /snap/bin $PATH
#set -x LANG de_DE.UTF-8
#set -x LC_ALL de_DE.UTF-8
set -g LANG C.UTF-8
set -g LC_ALL C.UTF-8

#Alias
alias osc='docker exec -it simplecloud-server /bin/bash'
# Alias für lsd mit Optionen, die ähnliche Ausgabe wie ls -ls bieten
alias ls='lsd -l --size short --total-size'
