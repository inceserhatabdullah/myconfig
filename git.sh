
show_help() {
  echo "Usage: ./git-setup.sh -u <user-name> -e <user-email>"
  exit 0
}


user_name=""
user_email=""

while getopts "u:e:h" opt; do
  case "$opt" in
    u) user_name=$OPTARG ;;
    e) user_email=$OPTARG ;;
    h) show_help ;;
    *) show_help ;;
  esac
done

if [[ -z $user_name || -z $user_email ]]; then
  echo "User name and user email is required!"
  show_help
fi


git config --global user.name $user_name
git config --global user.email $user_email
git config --global init.defaultBranch main

if [ ! -f ~/.ssh/id_ed25519 ]; then
    echo "generating ssh key.."
    ssh-keygen -t ed25519 -C $user_email -f ~/.ssh/id_ed25519 -N ""
    eval "$(ssh-agent -s)" > /dev/null
    ssh-add ~/.ssh/id_ed25519
fi

echo "Add the following public key below to github."
cat ~/.ssh/id_ed25519.pub