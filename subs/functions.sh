#
# Display info level messages
#
function info() {
    COLOR='\033[00;32m' # green
    RESET='\033[00;00m' # white
    echo -e "${COLOR}[INFO] ${@}${RESET}"
}
 
#
# Display colorized warning messages
#
function warn() {
    COLOR='\033[00;31m' # red
    RESET='\033[00;00m' # white
    echo -e "${COLOR}[WARN] ${@}${RESET}"
}

# EOF
