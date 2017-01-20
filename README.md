# writer: hienpham

SHORT DESCRIPTION:
A simple BASH script to do daily backups home folder  Ideal for home linux users to easily backup thier data. All backups result in a tarball of files written to a directory that you choose.
The program can backup with different compression algorithms: zip, gzip, lzma, lzma2, bz2. You can choose the compression you want by options. The default compression algorithm is gzip
The program runs automatically at 5pm everyday via a cron event to backup home folder to a folder named /backuphome.
It is able to send to user an email if it finds something different in today's home folder.

HOW TO USE:
Install postfix and have a gmail account to be alble to send email.
Go to https://www.howtoforge.com/tutorial/configure-postfix-to-use-gmail-as-a-mail-relay/ to know how to config postfix

If you want the script to run automatically (as it ws designed to do) then you need to add a cron job event to start it (crontab -e). Running it everyday at 5pm.

NOTES:
Make sure that the script has the execute permission set by doing a chmod 700 (or 755) on it.

All of the configuration for this script that you need to change is located in the section marked "User Variables".  Do not edit anything below this unless you know what you are doing.

ALWAYS SET THE BACKUP_DIR VARIABLE TO A DIRECTORY ON A SEPERATE HARD DRIVE THAN THE ONE THAT YOU ARE BACKING UP!
