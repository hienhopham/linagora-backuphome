#!/bin/bash
#Purpose = Backup of Important Data
#User Variables
# This Command will add date in Backup File Name.
TIME=`date +%b-%d-%y%s`

# Value related to file backup
USER=$(whoami)          
FILENAME=backup-$TIME     # Here i define Backup file name format.
SRCDIR=/home/hienpham                   # Location of Important Data Directory (Source of backup).
DESDIR=/backuphome                  # Destination of backup file.        

# Email for notifying
EMAIL_TO=hienhopham@gmail.com

# Argument
COMPRESS=$1
declare -A array_compress
array_compress=([-gz]='gz' [-bz2]='bz2' [-7z]='7z' [-zip]='zip' [-lzma]='lzma' [-xz]='xz')

#START
# Function
# test content of a file
test_content(){
	if [ -f $1 ]
	then
		if [ -s $1 ]
		then
			echo 1
		else
			echo 0
		fi
	else
		echo "File doesnt exist"
		exit 1
	fi
}


if [ -z $COMPRESS ]; then
	COMPRESS=-gz	# Default compress is gzip
elif [ -z ${array_compress[$COMPRESS]} ]; then
cat << !
	[Require option]
	-gz	for gzip compression
	-bz2	for bzip2 compression
	-zip	for zip compression
	-lzma	for lzma compression
	-xz	for lzma2 compression
!
exit 1
#elif [ -x "$(command -v ${array_compress[$COMPRESS]})" ]; then
#	echo ${array_compress[$COMPRESS]} is not installed yet
#	echo 'install the essential pakage'
#	echo 'and then try again'
#	exit 1
fi

sudo mkdir -p $DESDIR	# Create destination folder incase it doesnt exist

case $COMPRESS in
	-gz)	tar -cvzf $DESDIR/$FILENAME.tar.gz $SRCDIR;;
	-bz2)	tar -cvjf $DESDIR/$FILENAME.tar.bz2 $SRCDIR;;
	-zip)	tar -cvzf $DESDIR/$FILENAME.tar.zip $SRCDIR;;
	-lzma)	tar -cvf $DESDIR/$FILENAME.tar.lzma --lzma $SRCDIR;;
	-xz)	tar -cvJf $DESDIR/$FILENAME.tar.xz $SRCDIR;;
esac
sudo touch $DESDIR/today.txt
sudo touch $DESDIR/yesterday.txt
sudo touch $DESDIR/compare.txt
cat $DESDIR/today.txt > $DESDIR/yesterday.txt
echo $(ls -Rrsl $SRCDIR) > $DESDIR/today.txt
if [ `test_content $DESDIR/yesterday.txt` = "1" ]; then
	if [[ -z $(diff $DESDIR/today.txt $DESDIR/yesterday.txt) ]]; then
		echo 'No change' > $DESDIR/compare.txt
	else
		echo 'Something has been changed in your home' > $DESDIR/compare.txt
		echo $(diff -y $DESDIR/today.txt $DESDIR/yesterday.txt) >> $DESDIR/compare.txt
		mail -s 'Notification' $EMAIL_TO < $DESDIR/compare.txt
	fi
fi

#END
