#if [ -d /etc/X11/xinit/xinitrc.d ]; then
#    for f in /etc/X11/xinit/xinitrc.d/*; do
#        [ -x "$f" ] && . "$f"
#    done
#    unset f
#fi

numlockx on
setxkbmap -option numpad:mac
setxkbmap -layout "fr"
xmodmap ~/.Xmodmap 
pulseaudio
exec i3
