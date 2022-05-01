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
  base_dir=$1
  chosen_dir=$2
  filename=$3

  cd ~ || exit
  echo 'Archiving and Compressing ...'
#   tar czf "$filename.tar.gz" --directory="$dir" .
  cd "$base_dir"
  tar czf "$filename.tar.gz" "$chosen_dir"

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
  cd -
}

function backup_dir () {
  base_dir=$1
  chosen_dir=$2

  dir=$base_dir/$chosen_dir

  if ! [ -d "$dir" ]; then
    echo "$dir not found. Exiting ..."
    exit 1
  fi

  echo "If the script hangs, check if authenticated (try 'gdrive list')."

#   filename_nodate="${dir##*/}"
  filename_nodate="$chosen_dir"
  filename="$(date '+%Y_%m_%d')-$filename_nodate"

  delete_old_backup "$filename_nodate.tar.gz.gpg"
  archive_compress_encrypt_upload "$base_dir" "$chosen_dir" "$filename"

  echo 'Finish!'
  gdrive list
}

base_dir=~/cloud
PS3='Select directories to back up: '
choices=($(ls $base_dir))
select chosen in "${choices[@]}"; do
  backup_dir $base_dir $chosen
  break
done
