#!/bin/bash
set -eo pipefail

# Iterate every file from the given directory, extract EXIF date information,
# and rename the file with the following format YYYY-MM-DD HHMMSS
for file in "$1"*; do
  exifDate=$(exiftool -CreateDate -s3 -d '%Y-%m-%d %H%M%S' "${file}")
  exifDate="${exifDate:-$(exiftool -FileCreateDate -s3 -d '%Y-%m-%d %H%M%S' "${file}")}"

  # createDate=$(date -r $(stat -f %B "${file}") +'%Y-%m-%d %H%M%S')

  ext="${file##*.}"

  if test -n "$exifDate"; then
    mv "$file" "$1${exifDate}.${ext}"
  fi
done
