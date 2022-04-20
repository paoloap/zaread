# zaread

#### A (very) lightweight MS Office files reader

## Changelog (2022-04-20)

#### I'm so sorry guys, I just found out today that this script in the past few years has been adopted by many people and even ended up into AUR repos.  If someone wants to contribute, i.e. the ones that opened the issues and the pull requests, he's obviously welcome! Btw just merged all the pull requests:

- Now you can just clone the repo and do "sudo make install"
- Added .md files support (depends on pandoc)
- Now the cache directory is ~/.cache/zaread
- Fixed ebook conversion

Thanks to iulandita, TheOPtimal, millenito and mvrozanti for their help!

## What is zaread?

This simple bash script needs libreoffice installed and has zathura pdf reader as optional dependence

At work I often need to open doc, docx, ppt, pptx files in read only mode. I hate libreoffice interface with all those buttons (useless if I just need to view file content), and I hate presentation mode, because it forces fullscreen mode and I want the freedom to open Office files in a "normal" window, considering that I have a tiling wm.

So... I created this trivial script that can be used as default PDF/DOC/DOCX/ODF/PPT/PPTX/MD/etc reader. It just:
- converts the argument file to pdf using libreoffice embedded converter (soffice --converto-to);
- open it with zathura (a very very VERY lightweight PDF reader) or if it's not installed with user's favourite app.

Note: If you don't have zathura installed and you want to adopt another PDF reader (which I don't recommend, nothing IMO fits this script better than zathura), please the first time you use the script execute it from terminal, so that you can select your favourite one; otherwise you can just open the script with a text editor and set it as $reader.

## Getting started
- To make it work you need libreoffice, zathura (or any other PDF reader, but you must setup the proper variable), calibre (for e-book conversion) and pandoc (for markdown conversion)
- Clone the repository
- cd to repository
- sudo make install

Aaaand that's it.

## TODO
- Create an icon and a .desktop item
- Implement policies to clean the cache, which can become very big with the time (i.e. delete cache for documents older than x if cache size becomes larger than y)

Feel free to use and edit :)
