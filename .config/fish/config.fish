if status is-interactive
    # Commands to run in interactive sessions can go here
end

# add nvim to the end of the path
set -x PATH $PATH /opt/nvim/

set -Ux editor nvim
 
#safer delete by default
#TODO: test
abbr mv 'mv -i' 
abbr rm 'rm -i'
abbr cp 'cp -i'

#rmd command to view md on terminal
function rmd 
  pandoc "$argv[1]" | lynx -stdin 
end

#set fzf 
set -Ux FZF_DEFAULT_COMMAND 'rg --files --follow --no-ignore-vcs --hidden -g "!{node_modules/*,.git/*, dist/*}"'

# githm 
# store files from $HOME in a git repo without it being recognized as a parent repo
# initialization: 
# - create a directory .home.git in $HOME 
# - `git init --bare $HOME/.home.git`
# - add a $HOME/.gitignore that ignores everything. When tracking new file, disable it temporarily

# use githm like the git command
alias githm '/usr/bin/git --git-dir=$HOME/.home.git/ --work-tree=$HOME'
#end githm



# aliases for 
alias d 'bf delete'
alias g 'bf go'
alias l 'bf list'
alias p 'bf print'
alias s 'bf save'

# needed because last character is not displayed
set tide_right_prompt_suffix " "

#prompt plugins
starship init fish | source


