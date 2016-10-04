# zaread
A (very) lightweight MS Office files reader

This simple bash script needs libreoffice and zathura pdf reader packages installed.

At work I often need to open doc, docx, ppt, pptx files in read only mode. I hate libreoffice interface with all those buttons (useless if I just need to view file content), and I hate presentation mode, because it forces fullscreen mode and I want the freedom to open Office files in a "normal" window, considering that I have a tiling window.

So... I created this little trivial script that can be used as default PDF/DOC/DOCX/ODF/PPT/PPTX/etc reader. It just:
- converts the argument file to pdf;
- open it with zathura (a very very VERY lightweight PDF reader)
- delete the PDF file (after its closure).

Feel free to use and edit :)
