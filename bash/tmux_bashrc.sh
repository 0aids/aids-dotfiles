alias fzf_floating="fzf --height 40% --layout reverse --border"

# Yazi but allows changing cwd
# F for file manager
function F() {
  local tmp="$(mktemp -t "yazi-cwd.XXXXXX")" cwd
  yazi "$@" --cwd-file="$tmp"
  if cwd="$(command cat -- "$tmp")" && [ -n "$cwd" ] && [ "$cwd" != "$PWD" ]; then
    builtin cd -- "$cwd"
  fi
  rm -f -- "$tmp"
}

# To open a fzf to pick a tmux session whenever a term is opened
# function tmux_open() {
#   # Check if tmux is installed
#   if ! command -v tmux &>/dev/null; then
#     echo "tmux not found. Please install it."
#     exit 1
#   fi
#
#   # Check if fzf is installed
#   if ! command -v fzf &>/dev/null; then
#     echo "fzf not found. Please install it."
#     exit 1
#   fi
#   if command -v tmux &>/dev/null && [ -n "$PS1" ] && [[ ! "$TERM" =~ screen ]] && [[ ! "$TERM" =~ tmux ]] && [ -z "$TMUX" ]; then
#     if [[ "$(tty)" == *"tty"* ]]; then
#       return
#     fi
#
#     # Fetch existing sessions
#     sessions=$(tmux list-sessions -F "#{session_name}" 2>/dev/null)
#
#     # Append "new session" option
#     sessions=$(echo -e "[Exit]\n$sessions")
#     sessions=$(echo -e "[New Session]\n$sessions")
#     sessions=$(echo -e "[Default]\n$sessions")
#
#     # Let user choose
#     selected=$(echo "$sessions" | fzf_floating --prompt="Select tmux session: ")
#
#     # If no selection made, exit
#     [ -z "$selected" ] && exit 0
#
#     if [[ "$selected" == "[New Session]" ]]; then
#       # Prompt for new session name
#       read -p "Enter new session name: " new_name
#       [ -z "$new_name" ] && echo "No session name provided. Aborting." && exit 1
#       tmux new -s "$new_name"
#     elif [[ "$selected" == "[Exit]" ]]; then
#       exit 0
#     elif [[ "$selected" == "0_Default" ]]; then
#       tmux new-session -A -s Default
#     else
#       tmux attach-session -t "$selected" 2>/dev/null || tmux new-session -s "$selected"
#     fi
#   fi
# }
# tmux start-server
