# zaread
A (very) lightweight MS Office files reader

This simple bash script needs libreoffice and zathura pdf reader packages installed.

At work I often need to open doc, docx, ppt, pptx files in read only mode. I hate libreoffice interface with all those buttons (useless if I just need to view file content), and I hate presentation mode, because it forces fullscreen mode and I want the freedom to open Office files in a "normal" window, considering that I have a tiling window.

So... I created this little trivial script that can be used as default PDF/DOC/DOCX/ODF/PPT/PPTX/etc reader. It just:
- converts the argument file to pdf using libreoffice embedded converter (soffice --converto-to);
- open it with zathura (a very very VERY lightweight PDF reader)

Note: the script initially assumes that you have a $HOME/.path/tmp directory in which it puts PDF files. If you don't have it, create it, or just change $tmpdir variable to what you want. Also $tmpdir doesn't delete PDF files. That's because conversion process might be slow, and it can be annoying to have to wait every time for conversion of a file that maybe you often read.
Note 2: if for some reason (which I discourage) you don't want to adopt zathura to open files, but your favourite pdf reader, just change $reader variable.

Feel free to use and edit :)
