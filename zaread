#!/bin/bash
## zaread - a simple script created by paoloap.

# default variables
zadir="$HOME"'/.zaread/'
reader="zathura"

# if ~/.zaread doesn't exist, we create it.
if [[ ! -d "$zadir" ]]; then
  mkdir "$zadir"
  mkdir "$zadir"cksum
fi

# if no arguments exit.
if [[ -z $@ ]]; then exit 1; fi

# if zathura is not installed, we force the user to choose a pdf reader
# after three wrong commands, the script exits 1
# if the user inserts a command that exists but is not a pdf reader then... then fuck him.
counter=0
while [[ -z `command -v "$reader"` ]]; do
  if [ $counter -gt 3 ]; then exit 1; fi
  let counter+=1
  echo "Seems that you don't have zathura installed. Please choose an installed PDF reader:"
  read reader
done
echo "We'll read PDF with $reader."


## create position and file variables ##

# complete file name (path excluded):
file=`echo "$@" | rev | cut -d'/' -f1 | rev`

# complete directory path:
# if it has been inserted absolute path ($@ starts with '/')
if [[ $@ =~ ^/ ]]; then
  directory=`echo "$@" | rev | cut -d'/' -f2- | rev`"/"
# else (relative path inserted)
else
  dir=`pwd`"/"`echo "$@" | sed 's|.[^/]*$||'`"/"
  directory=`echo "$dir" | sed 's|//|/|'`
fi
echo "$directory""$file"

# if file type is pdf, then just read the file
if [[ `file "$directory""$file" | cut -d':' -f2 | cut -d' ' -f2` == "PDF"  ]]; then
  echo "The file is already in PDF format."
  $reader "$directory""$file"
# else check if you already have its pdf version (if not, create it)
else
  pdffile=`echo "$file" | rev | cut -d'.' -f2- | rev`".pdf"
  check=`cksum "$directory""$file" | awk '{print $1}'`
  # if pdf version hasn't ever been created, or it changed, then
  # make conversion and store the checksum.
  if [[ ( ! -f "$zadir$pdffile" ) || ( ! "$check" == `cat "$zadir"cksum/"$file".check` ) ]]; then
    # if it's a mobi file, then convert it to epub (the command depends on calibre)
    if [[ "$file" =~ ^.*\.mobi$ ]]; then
      ebook-converter "$directory""$file" "$directory"`echo "$file" | sed 's/mobi$/epub/'`
    else
      libreoffice --convert-to pdf "$directory""$file" --headless --outdir "$zadir"
    fi
    echo "$check" > "$zadir"cksum/"$file".check
  fi
  $reader "$zadir$pdffile"
fi
