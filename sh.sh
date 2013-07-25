#!/bin/sh
#=============get the file name================
Folder_A="/Users/cjh/work/shell/music/音乐包/音乐片段"
Output_file="Index.json"
#==============================================
mkdir Package1
echo success make Package1
cd Package1 && mkdir Music
#=============print===================
print()
{
x=$1
echo $x >> $Output_file
}

#==============music info=================
ID=0
getInfo()
{
File=""
Question=""
Answer=""

str=$1
info=${str%.*}
signer=${info%-*}
songName=${info#*-}
ss="$signer-$songName.mp3"
#=====================
if [ $ss != $str ]; then
	echo $info
	return
fi

#========get==========
let "ID+=1"
File=`printf "Music/%03d.mp3" $ID`
len=8
if [ ${#songName} -gt $len ];then
	Question="歌手"
	Answer=$signer
else
	Question="歌名"
	Answer=$songName
fi

#=======print=========
print '\t\t{'
print "\t\t\t\"ID\"\t\t: \"$ID\","
print "\t\t\t\"File\"\t\t: \"$File\","
print "\t\t\t\"Question\"\t: \"$Question\","
print "\t\t\t\"Answer\"\t: \"$Answer\""
print '\t\t},\n'

#========copy=========
cp "$Folder_A/$str" ./$File
}

print '{'
#=============base info=================
print "\t\"ID\"\t\t\t: 1,"
print "\t\"Version\"\t\t: 1,"
print "\t\"Description\"\t: \"音乐包1\","
print "\t\"Image\"\t\t\t: \"Jay.png\","
print "\t\"MusicInfo\" :"
print "\t["

for file_a in ${Folder_A}/*; do
	temp_file=`basename $file_a`
	echo $temp_file
	getInfo $temp_file
done
print "\t]"
print '}'