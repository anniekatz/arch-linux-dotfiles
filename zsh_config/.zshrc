# Set up the prompt (with git branch name)
setopt PROMPT_SUBST
PROMPT='%n in ${PWD/#$HOME/~}
%# '
PROMPT=$(echo $PROMPT | sed 's/(base) //')
RPROMPT=\$vcs_info_msg_0_
export PATH="/opt/homebrew/opt/openjdk/bin:$PATH"
export CPPFLAGS="-I/opt/homebrew/opt/openjdk/include"


# Load version control information
autoload -Uz vcs_info
precmd() { vcs_info }

# Format the vcs_info_msg_0_ variable
zstyle ':vcs_info:git:*' formats 'on %b'

# Set up the prompt (with git branch name)
setopt PROMPT_SUBST
PROMPT='%n in ${PWD/#$HOME/~}
%# '
PROMPT=$(echo $PROMPT | sed 's/(base) //')
RPROMPT=\$vcs_info_msg_0_
