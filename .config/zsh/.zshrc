# Luke's config for the Zoomer Shell

# Enable colors and change prompt:
autoload -U colors && colors	# Load colors
PS1="%B%{$fg[red]%}[%{$fg[yellow]%}%n%{$fg[green]%}@%{$fg[blue]%}%M %{$fg[magenta]%}%~%{$fg[red]%}]%{$reset_color%}$%b "
setopt autocd		# Automatically cd into typed directory.
stty stop undef		# Disable ctrl-s to freeze terminal.
setopt interactive_comments

# History in cache directory:
HISTSIZE=10000000
SAVEHIST=10000000
HISTFILE="${XDG_CACHE_HOME:-$HOME/.cache}/zsh/history"

# Load aliases and shortcuts if existent.
[ -f "${XDG_CONFIG_HOME:-$HOME/.config}/shell/shortcutrc" ] && source "${XDG_CONFIG_HOME:-$HOME/.config}/shell/shortcutrc"
[ -f "${XDG_CONFIG_HOME:-$HOME/.config}/shell/aliasrc" ] && source "${XDG_CONFIG_HOME:-$HOME/.config}/shell/aliasrc"
[ -f "${XDG_CONFIG_HOME:-$HOME/.config}/shell/zshnameddirrc" ] && source "${XDG_CONFIG_HOME:-$HOME/.config}/shell/zshnameddirrc"

# Basic auto/tab complete:
autoload -U compinit
zstyle ':completion:*' menu select
zmodload zsh/complist
compinit
_comp_options+=(globdots)		# Include hidden files.

# vi mode
bindkey -v
export KEYTIMEOUT=1

# Use vim keys in tab complete menu:
bindkey -M menuselect 'h' vi-backward-char
bindkey -M menuselect 'k' vi-up-line-or-history
bindkey -M menuselect 'l' vi-forward-char
bindkey -M menuselect 'j' vi-down-line-or-history
bindkey -v '^?' backward-delete-char

# Change cursor shape for different vi modes.
function zle-keymap-select () {
    case $KEYMAP in
        vicmd) echo -ne '\e[1 q';;      # block
        viins|main) echo -ne '\e[5 q';; # beam
    esac
}
zle -N zle-keymap-select
zle-line-init() {
    zle -K viins # initiate `vi insert` as keymap (can be removed if `bindkey -V` has been set elsewhere)
    echo -ne "\e[5 q"
}
zle -N zle-line-init
echo -ne '\e[5 q' # Use beam shape cursor on startup.
preexec() { echo -ne '\e[5 q' ;} # Use beam shape cursor for each new prompt.

# Use lf to switch directories and bind it to ctrl-o
lfcd () {
    tmp="$(mktemp -uq)"
    trap 'rm -f $tmp >/dev/null 2>&1 && trap - HUP INT QUIT TERM PWR EXIT' HUP INT QUIT TERM PWR EXIT
    lf -last-dir-path="$tmp" "$@"
    if [ -f "$tmp" ]; then
        dir="$(cat "$tmp")"
        [ -d "$dir" ] && [ "$dir" != "$(pwd)" ] && cd "$dir"
    fi
}
bindkey -s '^o' '^ulfcd\n'

bindkey -s '^a' '^ubc -lq\n'

bindkey -s '^f' '^ucd "$(dirname "$(fzf)")"\n'

bindkey '^[[P' delete-char

# Edit line in vim with ctrl-e:
autoload edit-command-line; zle -N edit-command-line
bindkey '^e' edit-command-line
bindkey -M vicmd '^[[P' vi-delete-char
bindkey -M vicmd '^e' edit-command-line
bindkey -M visual '^[[P' vi-delete

__fzf_nova__() {
    /home/cf/Scripts/fzf-nova/fzf-nova
    }
zle -N  __fzf_nova__
bindkey -M emacs '^[m' __fzf_nova__
bindkey -M vicmd '^[m' __fzf_nova__
bindkey -M viins '^[m' __fzf_nova__

# Aliases
alias c='clear'
alias l='ls --group-directories-first -AlF'
alias q='clear && exit'
alias src='source'
alias qtb='qutebrowser'
alias qutepriv='qutebrowser --target=private-window'
alias tldr='tldr --color'
alias info='info --vi-keys'
alias passc='pass -c'
# File Sorting
alias mvV='mv *.webm *.mp4 --target-directory=Videos'
alias mvScrns='mv *.png --target-directory=Pictures/screenshots'
alias mvGif='mv *.gif --target-directory=Pictures/gif'
alias cdp='cd .. && ls -AlF'
alias note='vim ~/Notes/Notes_$(date --iso-8601)'
alias notes='bat ~/Notes/Notes_$(date --iso-8601)'
# bluetoothctl
alias sonos='bluetoothctl connect F0:F6:C1:D1:B9:74'
alias HD440='bluetoothctl connect 00:16:94:25:13:35'
alias laubtk='bluetoothctl connect 16:77:6F:3E:2C:EE'
alias k4='bluetoothctl connect DC:2C:26:0C:F0:5F'
alias francoSB='bluetoothctl connect 54:15:89:92:1B:52'
# ytfzf
alias ytf='ytfzf'
alias ytm='ytf -m'
alias ytls='ytf -l -cS'
alias yts='ytfzf -s'
alias ytst='ytfzf -lt -cS --async-thumbnails'
alias ytdlm='ytfzf -dlm'
alias ytdH='ytfzf -dH'
alias ytlt='ytfzf -lt --async-thumbnails'
alias ytl='ytfzf -l'
alias ytdl='ytfzf -dl'
alias ytstl='ytfzf -tl --async-thumbnails -cSI'
alias ytsdl='ytfzf -dl --async-thumbnails -cSI'
alias ytsubs='bat ~/.config/ytfzf/subscriptions'
# ytfzf channels
alias rdi='ytfzf -A Radio\-Canada'
alias cbc='ytfzf -A CBC'
alias tva='ytfzf -A TVA Nouvelles'
alias bloomberg='ytfzf -A Bloomberg Television'
alias ltt='ytfzf -A Linus Tech Tips'
alias gotbletu='ytfzf -A gotbletu'
alias linuxcast='ytfzf -A The Linux Cast'
alias djware='ytfzf -A DJ Ware'
alias distrotube='ytfzf -A Distro Tube'
alias linuxexp='ytfzf -A The Linux Experiment'
alias bugswriter='ytfzf -A bugswriter'
alias primagen='ytfzf -A ThePrimagen'
alias tjdevries='ytfzf -A TJ Devries'
alias lukesmith='ytfzf -A LukeSmithxyz'
alias smallbrainedamerican='ytfzf -A Small Brained American'
alias cbtnuggets='ytfzf -A CBT Nuggets'
alias sousecoute='ytfzf -A Sous Écoute'
alias ctt='ytfzf -A Chris Titus Tech'
alias technotim='ytfzf -A TechnoTim'
alias davesgarage='ytfzf -A DavesGarage'
alias liveoverflow='ytfzf -A LiveOverflow'
alias novaspirittech='ytfzf -A NovaspiritTech'
alias jeffgeerling='ytfzf -A JeffGeerling'
alias networkchuck='ytfzf -A NetworkChuck'
alias davidbombal='ytfzf -A davidbombal'
alias scarypockets='ytfzf -A ScaryPockets'
alias pomplamoose='ytfzf -A Pomplamoose'
alias level1tech='ytfzf -A Level1Tech'
alias themobreporter='ytfzf -A TheMobReporter'
alias shanselman='ytfzf -A Scott Hanselman'
#radio
alias ici-premiere='mpv https://rcavliveaudio.akamaized.net/hls/live/2006635/P-2QMTL0_MTL/adaptive_192/chunklist_ao.m3u8'
alias ici-musique='mpv https://rcavliveaudio.akamaized.net/hls/live/2006979/M-7QMTL0_MTL/adaptive_192/chunklist_ao.m3u8'
alias ici-musique-classique='mpv https://rcavliveaudio.akamaized.net/hls/live/2007000/MUSE/adaptive_192/chunklist_ao.m3u8'
alias fm97-7='mpv https://rogers-hls.leanstream.co/rogers/gra977.stream/48k/playlist.m3u8'
alias chom='mpv https://rogers-hls.leanstream.co/rogers/gra977.stream/48k/playlist.m3u8'
alias fm98-5='mpv https://20593.live.streamtheworld.com/CHMPFMAAC/HLS/30dcb050-00df-464f-876b-d9fa56983455/0/playlist.m3u8'

alias df.='sdcv -n --utf8-output --color'
alias pbcopy='xclip -selection clipboard'
alias pbpaste='xclip -selection clipboard -o'
alias pbselect='xclip -selection primary -o'
alias nmail='notmuch new'
alias define='googler -n 2 define'
#QuickEmu
alias kali='cd ~/Apps && quickemu --vm ~/Apps/kali-current.conf'
#alias freebsd='quickemu --vm freebsd-13.2-disc1.conf'
alias gentoo='cd ~/Apps && quickemu --vm ~/Apps/gentoo-latest.conf'
alias windows10='cd ~/Apps && quickemu --vm ~/Apps/windows-10.conf'
#alias fedora='quickemu --vm fedora-38-i3.conf'
#alias arcolinux='cd Apps && quickemu --vm arcolinux-v23.12.03-small.conf'
#ssh
alias raspi='ssh cf@10.0.0.24'
alias salon='ssh cf-@10.0.0.231'
alias chambre='ssh cf@10.0.0.177'
alias sync_ytsubs='rsync ~/.config/ytfzf/subscriptions cf@10.0.0.177:~/.config/ytfzf/subscriptions; rsync ~/.config/ytfzf/subscriptions cf-@10.0.0.231:~/.config/ytfzf/subscriptions; rsync ~/.config/ytfzf/subscriptions cf@10.0.0.24:~/.config/ytfzf/subscriptions'
alias sync_news='rsync ~/.config/newsboat/urls cf@10.0.0.177:~/.config/newsboat/urls; rsync ~/.config/newsboat/urls cf-@10.0.0.231:~/.config/newsboat/urls; rsync ~/.config/newsboat/urls cf@10.0.0.24:~/.config/newsboat/urls'
alias sync_zsh='rsync ~/.config/zsh/.zshrc cf@10.0.0.177:~/.config/zsh/.zshrc; rsync ~/.config/zsh/.zshrc cf@10.0.0.231:~/.config/zsh/.zshrc; rsync ~/.config/zsh/.zshrc cf@10.0.0.24:~/.config/zsh/.zshrc'
alias sync_qutebrowser='rsync --recursive ~/.config/qutebrowser/ cf-@10.0.0.231:~/.config/qutebrowser/; rsync --recursive ~/.config/qutebrowser/ cf@10.0.0.177:~/.config/qutebrowser/; rsync --recursive ~/.config/qutebrowser/ cf@10.0.0.24:~/.config/qutebrowser/'
#edit src
alias edit_dwmblocks='vim ~/.local/src/dwmblocks/config.h && cd ~/.local/src/dwmblocks && sudo make clean install && killall -q dwmblocks; setsid dwmblocks&'
alias edit_dwm='vim ~/.local/src/dwm/config.h && cd ~/.local/src/dwm && sudo make clean install'
alias edit_dmenu='vim ~/.local/src/dmenu/config.h && cd ~/.local/src/dmenu && sudo make clean install'
alias edit_ssh_config='sudo vim /etc/ssh/sshd_config'
alias edit_zshrc='vim ~/.config/zsh/.zshrc && source ~/.config/zsh/.zshrc'
alias edit_ytsubs='vim ~/.config/ytfzf/subscriptions && source ~/.config/ytfzf/subscriptions 2>/dev/null'
alias edit_news='vim ~/.config/newsboat/urls && source ~/.config/newsboat/urls 2>/dev/null'
#power stats
alias powerat='sudo powertop --auto-tune && sudo powertop'
alias batcycles='cat /sys/class/power_supply/BAT1/cycle_count'
alias aod='xset -dpms s off'
#ledger
budget23='~/Documents/Ledger/2023/Budget.2023'
budget24='~/Documents/Ledger/2024/2024.ldg'
epicerie='~/Documents/Ledger/2024/Épiceries/epiceries'
alias ldg.2023="ledger -f "$budget23""
alias vldg.2023="vim $budget23"
alias ldg="ledger -f "$budget24""
alias vldg="vim $budget24"
alias epiceries="vim $epicerie"
alias ldg.epicerie.reg="ledger -f "$epicerie" reg --weekly --period "this month" --empty --cleared"
alias ldg.epicerie.bal="ledger -f "$epicerie" bal"
alias ldg.lastweek.bal='ldg --weekly bal --period "last week" --empty --cleared'
alias ldg.lastweek.reg='ldg --weekly reg --period "last week" --empty --cleared'
alias ldg.thisweek.bal='ldg --weekly bal --period "this week" --empty --cleared'
alias ldg.thisweek.reg='ldg --weekly reg --period "this week" --empty --cleared'
alias ldg.thisyear.bal='ldg --weekly bal --period "this year" --empty --cleared'
alias ldg.thisyear.reg='ldg --weekly reg --period "this year" --empty --cleared'
alias budgetsc='sc-im ~/Documents/Ledger/budget2024.sc'
alias ldg.depenses.reg='ldg reg --weekly --period "this year" ^Dépenses'
alias ldg.depenses.bal='ldg bal --weekly --period "this year" ^Dépenses'
alias ldg.epiceries='ldg reg --weekly --period "this year" ^Dépenses:Épiceries:IGA'
alias ldg.actifs='ldg bal ^actifs --cleared'
alias ldg.passifs='ldg bal ^passifs --cleared'
export SDCV_DATA_DIR="$HOME/Documents/Dicts/"
# Functions
def() {
    sdcv -n --utf8-output --color "$@" 2>&1 | \
    fold --width=$(tput cols) | \
    less --quit-if-one-screen -RX
}

cdl() {
   cd "$1" && l
}
ytcl() {
   url="$1"
   # Remove "https://youtube.com/" from the URL
   channel_name="${url/https:\/\/www.youtube.com\//}"
   link="$(ytfzf --channel-link="$url")"
   uuid=$(echo "$link" | awk -F '/' '{print substr($NF, length($NF)-23)}')

   echo "# $channel_name\n$link" >> ~/.config/ytfzf/subscriptions
   echo "https://www.youtube.com/feeds/videos.xml?channel_id=$uuid \"~$channel_name\"" >> ~/.config/newsboat/urls

   tail -n5 ~/.config/newsboat/urls
   tail -n4 ~/.config/ytfzf/subscriptions
}
update_notes() {
    # Define the file paths
    current_file="$HOME/Notes/Notes_$(date --iso-8601)"
    previous_file="$HOME/Notes/Notes_$(date --iso-8601 -d 'yesterday')"

    if [ -e "$current_file" ]; then
        # If the current file exists, display its content with 'bat'
        bat "$current_file"
    else
        # If the current file doesn't exist, copy it from the previous day
        cp "$previous_file" "$current_file"
        # Append the current date and time to the end of the file
        date --iso-8601 >> "$current_file"
    fi
}
rmsound() {
    input="$1"
    output="no-sound-$1"
    ffmpeg -i "$input" -an -c:v copy "$output"
}
mergeaudio() { 
    inputV="$1"
    inputA="$2"
    outputV="$3"
    ffmpeg -i "$inputV" -i "$inputA" -c:v copy -c:a aac -strict experimental "$outputV"
}
gifit() {
    input="$1"
    output="$1.gif"
    ffmpeg -i "$input" -vf 'scale=-1:500' "$output"
}
export PATH="${PATH}:$HOME/Scripts"
export PATH="${PATH}:$HOME/Apps"

# Load syntax highlighting; should be last.
source /usr/share/zsh/plugins/fast-syntax-highlighting/fast-syntax-highlighting.plugin.zsh 2>/dev/null
