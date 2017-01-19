# writer: hienpham

SHORT DESCRIPTION:
A simple BASH script to do daily backups home folder  Ideal for home linux users to easily backup thier data.
The program can backup with different compression algorithms: zip, gzip, lzma, lzma2, bz2
The default compression algorithm is gzip
The program runs automaticaly at 5pm everyday to backup home folder to a folder named /backuphome.
It is able to send to user an email if it finds something different in today's home folder.

HOW TO USE:
Install postfix and have a gmail account to be alble to send email.
Go to https://www.howtoforge.com/tutorial/configure-postfix-to-use-gmail-as-a-mail-relay/ to know how to config postfix


