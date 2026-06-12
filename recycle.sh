recycle(){
  local HOME_DIR=/home/asince
  local TRASH_DIR="$HOME_DIR/.local/share/Trash"
  mkdir -p "$TRASH_DIR"

  local FILES=("$@")
  
  for file in "${FILES[@]}"; do
    # Move file to trash with timestamp
    # e.g. file.txt -> file.txt_1625097600
    # prevent overwriting existing files in trash
    mv "$file" "$TRASH_DIR/$(basename "$file")_$(date +%s)"
    
  done
}

# alias for recycling files to trash
# usage: trash file1 file2 dir1 ...
alias trash='recycle'
