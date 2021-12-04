#!/usr/bin/env bash
if ! type gdrive > /dev/null; then
  echo "gdrive not found in \$PATH. Exiting..."
  exit 1
fi

function delete_old_backup () {
  echo 'Deleting old backups ...'
  old=$(gdrive list -q "name contains '$1'" | awk 'NR > 1 {print $1}')
  for i in $old;
    do gdrive delete "$i";
  done
}

function archive_compress_encrypt_upload () {
  dir=$1
  filename=$2

  cd ~ || exit
  echo 'Archiving and Compressing ...'
  tar czf "$filename.tar.gz" --directory="$dir" .

  echo 'Encrypting ...'
  if gpg --encrypt --recipient tkiat@tutanota.com "$filename.tar.gz"
  then
    echo 'Uploading ...'
    gdrive upload "$filename.tar.gz.gpg"
    rm "$filename.tar.gz"
    rm "$filename.tar.gz.gpg"
  else
    echo gpg encryption failed. exiting ...
    exit 1
  fi
}

function backup_dir () {
  dir=$1

  if ! [ -d "$dir" ]; then
    echo "$dir not found. Exiting ..."
    exit 1
  fi

  echo "If the script hangs, check if authenticated (like typing gdrive list)."

  filename_nodate="${dir##*/}"
  filename="$(date '+%Y_%m_%d')-$filename_nodate"

  delete_old_backup "$filename_nodate.tar.gz.gpg"
  archive_compress_encrypt_upload "$dir" "$filename"

  echo 'Finish!'
  gdrive list
}

dir1=~/Sync/Personal-Cloud
dir2=~/Sync/Personal-Cloud-Big
dir3=~/Sync/Personal-Local

PS3='Select directories to back up: '
choices=("$dir1" "$dir2" "$dir3" "Everything" "Nothing")
select chosen in "${choices[@]}"; do
  echo "----------------------------------------------------------------------"
  case $chosen in
    "$dir1")
      echo "Backing up ${dir1} ..."
      backup_dir $dir1

      break
      ;;
    "$dir2")
      echo "Backing up ${dir2} ..."
      backup_dir $dir2

      break
      ;;
    "$dir3")
      echo "Backing up ${dir3} ..."
      backup_dir $dir3

      break
      ;;
    "Everything")
      echo "Backing up Everything ..."
      backup_dir $dir1
      backup_dir $dir2
      backup_dir $dir3

      break
      ;;
    "Nothing")
      echo "Backing up Nothing ..."

      exit 0
      ;;
    *) echo "Invalid option $REPLY";;
  esac
done
