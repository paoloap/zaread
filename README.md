# zaread

A (very) lightweight MS Office files reader

## 2022-04-20 2nd UPDATE
Just merged 3 of the 4 pull requests made in the past few years.
- Now you can just clone the repo and do "sudo make install"
- Now the cache directory is ~/.cache/zaread
- Fix to ebook conversion
Thanks to iulandita, TheOPtimal and mvrozanti for their help!

## 2022-04-20 UPDATE
I'm so sorry guys, I just found out today that this script in the past few years has been adopted by many people and even ended up into AUR repos. Not sure that I can manage all requests now, especially because I'm not very skilled on GIT (I know, my bad, I work in a software farm that uses SVN). If someone wants to contribute, i.e. the ones that opened the issues and the pull requests, he's obviously welcome!

## What is zaread?

This simple bash script needs libreoffice installed and has zathura pdf reader as optional dependence

At work I often need to open doc, docx, ppt, pptx files in read only mode. I hate libreoffice interface with all those buttons (useless if I just need to view file content), and I hate presentation mode, because it forces fullscreen mode and I want the freedom to open Office files in a "normal" window, considering that I have a tiling wm.

So... I created this trivial script that can be used as default PDF/DOC/DOCX/ODF/PPT/PPTX/etc reader. It just:
- converts the argument file to pdf using libreoffice embedded converter (soffice --converto-to);
- open it with zathura (a very very VERY lightweight PDF reader) or if it's not installed with user's favourite app.

Note: If you don't have zathura installed and you want to adopt another PDF reader (which I don't recommend, nothing IMO fits this script better than zathura), please the first time you use the script execute it from terminal, so that you can select your favourite one; otherwise you can just open the script with a text editor and set it as $reader.

Feel free to use and edit :)
