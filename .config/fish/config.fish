if status is-interactive
    # Commands to run in interactive sessions can go here
end

# disable fish greeting (set it to empty)
set fish_greeting 

# add nvim to the end of the path
set -x PATH $PATH /opt/nvim/ $HOME/.local/bin

set -x editor nvim
set -x visual nvim 
set -x SUDO_EDITOR nvim  

# in cli, i see unicode so I manually change those
set -x LANG en_US.UTF-8
set -x LC_ALL en_US.UTF-8

# for using pipewire, we set this env var
if test -z "$XDG_RUNTIME_DIR"
    set -gx XDG_RUNTIME_DIR (mktemp -d /tmp/(id -u)-runtime-dir.XXX)
end
#safer delete by default
#TODO: test
abbr mv 'mv -i' 
abbr rm 'rm -i'
abbr cp 'cp -i'

#unzip defaults to unzip into a folder
abbr unzip 'unzip -d ./'

#rmd command to view md on terminal
function rmd 
  pandoc "$argv[1]" | lynx -stdin 
end

#set fzf 
set -x FZF_DEFAULT_COMMAND 'rg --files --follow --no-ignore-vcs --hidden -g "!{node_modules/*,.git/*, dist/*}"'
fzf --fish | source
set -x TERMINAL 'alacritty'

# githm 
# store files from $HOME in a git repo without it being recognized as a parent repo
# initialization: 
# - create a directory .home.git in $HOME 
# - `git init --bare $HOME/.home.git`
# - add a $HOME/.gitignore that ignores everything. When tracking new file, disable it temporarily

# use githm like the git command
alias githm '/usr/bin/git --git-dir=$HOME/.home.git/ --work-tree=$HOME'
#end githm

#yt-dlp abbr
abbr yt 'mov-cli -s youtube'
abbr ytdl 'yt-dlp -P "/home/antony/Videos/yt-dlp" -o "%(upload_date)s.%(id)s.%(title)s" -t mp4'
abbr '?' 'BROWSER=lynx ddgr'

#gentoo abbr
abbr "editp" "sudoedit /etc/portage/"

#qemu abbr
abbr "qemu-imgc" "qemu-img create -f qcow2 file.img 32G"
abbr "qemu-run" "qemu-system-x86_64 \
    -enable-kvm \
    -cpu host \
    -smp 4 \
    -m 4096 \
    -boot menu=on \
    -netdev user,id=net0 -device virtio-net-pci,netdev=net0 \
    -device virtio-scsi-pci -device scsi-hd,drive=hd0 \
    -device usb-ehci,id=usb,bus=pci.0 \
    -device usb-tablet \
    -vga virtio -display sdl,gl=on \
    -cdrom .iso -drive file=.img,if=none,id=hd0,cache=writeback"

# aliases for 
alias d 'bf delete'
alias g 'bf go'
alias l 'bf list'
alias p 'bf print'
alias s 'bf save'

#prompt plugins
starship init fish | source

if test (tty) = "/dev/tty1"
  startx
end

