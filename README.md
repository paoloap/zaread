# zaread
A (very) lightweight MS Office files reader

This trivial bash script needs libreoffice installed and has zathura pdf reader as optional dependence

At work I often need to open doc, docx, ppt, pptx files in read only mode. I hate libreoffice interface with all those buttons (useless if I just need to view file content), and I hate presentation mode, because it forces fullscreen mode and I want the freedom to open Office files in a "normal" window, considering that I have a tiling window.

So... I created this little trivial script that can be used as default PDF/DOC/DOCX/ODF/PPT/PPTX/etc reader. It just:
- converts the argument file to pdf using libreoffice embedded converter (soffice --converto-to);
- open it with zathura (a very very VERY lightweight PDF reader) or if it's not installed with user's favourite app.

Note: If you don't have zathura installed and you want to adopt another PDF reader, please the first time you use the script execute it from terminal, so that you can select your favourite one; otherwise you can just open the script with a text editor and set it as $reader.

Feel free to use and edit :)
