#!/bin/sh
## zaread - a simple script created by paoloap.

# zaread cache path
ZA_CACHE_DIR="${XDG_CACHE_HOME:-"$HOME/.cache/"}""/zaread/"
# zaread config path
ZA_CONFIG="${XDG_CONFIG_HOME:-"$HOME/.config"}"'/zaread/zareadrc'

# READER with which we'll open pdf, epub and converted files
READER="zathura"

# here we have the execs we use to convert. if you want to use a custom exec,
# then set it here, and go down in the script to find (and edit) the proper command
MOBI_CMD="ebook-convert"
OFFICE_CMD="soffice"
MD_CMD="md2pdf"

# sources the variables from config file if exists
if [ -f "$ZA_CONFIG" ]; then
        . "$ZA_CONFIG"
fi

# if $ZA_CACHE_DIR doesn't exist, we create it.
if [[ ! -d "$ZA_CACHE_DIR" ]]; then
  mkdir -p "$ZA_CACHE_DIR"
fi

# if no arguments exit.
if [ -z "$*" ]; then exit 1; fi

# if zathura is not installed, we force the user to choose a pdf READER
# after three wrong commands, the script exits 1
# if the user inserts a command that exists but is not a pdf READER then... then fuck him.
counter=0
while [[ -z `command -v "$READER"` ]]; do
  if [ $counter -gt 3 ]; then exit 1; fi
  let counter+=1
  echo "Seems that you don't have zathura installed. Please choose an installed PDF READER:"
  echo "Cannot find zathura in the path. Please provide the path to zathura or the application you want to use as the pdf READER (e.g firefox)"
  read -r READER
  mkdir -p "$(echo "$ZA_CONFIG" | sed 's/zareadrc//g')"
  echo "READER=$READER" >> "$ZA_CONFIG"
  echo "Zaread config file created at $ZA_CONFIG"
  echo "Opening file..."
done


## create position and file variables ##

# complete file name (path excluded):
file="$(echo "$@" | rev | cut -d'/' -f1 | rev)"

# complete directory path:
# if it has been inserted absolute path ($@ starts with '/')
if expr "$*" : "^/" 1> /dev/null ; then
    directory=$(echo "$@" | rev | cut -d'/' -f2- | rev)"/"
# else (relative path inserted)
else
  dir="$(pwd)""/""$(echo "$@" | sed 's|.[^/]*$||')""/"
  directory="$(echo "$dir" | sed 's|//|/|')"
fi
echo "$directory""$file"

# get file type

# if the file is itself a pdf or an epub, or we already have a pdf converted version,
# then we don't need a converter. But if it's an already converted document, then
# file position is different: we must distinguish between original and converted files
file_converter=""
file_mt="$(file --mime-type "$directory$file" | sed 's/^.*: //')"
echo "$file_mt"
cd "$directory" || return

# $pdffile is a string composed this way: __$file.[pdf,epub]
# if the converted file exists, then it's named like $pdffile
pdffile="$(cksum "$file" | sed -r 's/^([0-9]+) ([0-9]+) (.*)$/\1_\2_\3.pdf/')"

# if the file is a pdf or an epub
if [ "$file_mt" = "application/pdf" ] || [ "$file_mt" = "application/epub+zip" ]; then
  file_converter="none_original"
# if the converted file exists
elif [[ ( -f "$ZA_CACHE_DIR$pdffile" ) ]]; then
  file_converter="none_converted"
# if the file is an office file (ooxml or the old format or an opendocument)
elif [ "$file_mt" = "application/vnd.openxmlformats-officedocument.wordprocessingml.document" ] || \
     [ "$file_mt" = "application/vnd.openxmlformats-officedocument.spreadsheetml.sheet" ] || \
     [ "$file_mt" = "application/vnd.openxmlformats-officedocument.presentationml.presentation" ] || \
     [ "$file_mt" = "application/msword" ] || \
     [ "$file_mt" = "application/vnd.ms-excel" ] || \
     [ "$file_mt" = "application/vnd.ms-powerpoint" ] || \
     [ "$file_mt" = "application/vnd.oasis.opendocument.text" ] || \
     [ "$file_mt" = "application/vnd.oasis.opendocument.spreadsheet" ] || \
     [ "$file_mt" = "application/vnd.oasis.opendocument.presentation" ] || \
     [ "$file_mt" = "text/csv" ]
then
  file_converter="$OFFICE_CMD"
# if the file is a mubi ebook
elif [ "$file_mt" = "application/octet-stream" ] && expr "$file" : "^.*\.mobi$" 1>/dev/null  ; then
  file_converter="$MOBI_CMD"
# if the file is a markdown
elif [ "$file_mt" = "text/plain" ] && expr "$file" : "^.*\.md$" ; then
  file_converter="$MD_CMD"
fi

# if we don't have a capable converter, we exit
if [ -z "$file_converter" ]; then
  echo "The file format is unsupported."
  exit 2
# if the file a pdf or an epub, we just open it
elif [ "$file_converter" = "none_original" ]; then
  echo "The file is already in PDF format. We just open it."
  $READER "$directory$file"
# if we have a converted file, we just open it (the only difference with the case above
# is that the converted file is into cache directory and has a different name)
elif [ "$file_converter" = "none_converted" ]; then
  echo "We already converted this file. We just open it."
  $READER "$ZA_CACHE_DIR$pdffile"
# else, then the file is not a pdf or an epub, and it doesn't exist a converted version,
# but its format is convertible
else
  # first, we check if we have the proper converter installed
  we_can_convert=$(whereis $file_converter | cut -d":" -f2)
  # if we don't have it, we can't do anything, so we exit
  if [ -z "$we_can_convert" ]; then
     echo "The command we need to convert, $file_converter, doesn't exist on this machine."
     exit 4
  # else we process the file, and we put the converted version under $zadir$pdffile
  else
    echo "We are starting to convert the file $file using $file_converter"
    if [[ $file_converter == "$OFFICE_CMD" ]]; then
      libreoffice --convert-to pdf "$directory$file" --headless --outdir "$ZA_CACHE_DIR"
      tmpfile=`echo "$file" | sed -r 's/.[^\.]*$//'`".pdf"
      mv "$ZA_CACHE_DIR$tmpfile" "$ZA_CACHE_DIR$pdffile"
    elif [[ $file_converter == "$MOBI_CMD" ]]; then
      ebook-convert "$directory""$file" "$ZA_CACHE_DIR$pdffile"
    elif [[ $file_converter == "$MD_CMD" ]]; then
      md2pdf "$directory""$file" -o "$ZA_CACHE_DIR""$pdffile"
    fi
  fi
  echo "Now we can open the file $ZA_CACHE_DIR$pdffile"
  # ...and after the conversion we open the file
  $READER "$ZA_CACHE_DIR$pdffile"
fi
