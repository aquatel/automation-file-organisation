#Allow the recusive creation of directories according to the date of the shot.
#originally made for Landsat products, but easily adaptable for any kind of file containing
#a substring from wich you want to creat directories. All files containing the same substring
#at the same position will be move in the previously created directory.
for file in *.TIF
do
  if test -f $file 
  #-f : True if FILE exists and is a regular file.
  then
    cycle=`echo $file | awk -F_ '{print $4}' | awk '{print substr($0,(length($2)-1))}'`
    #part after the 1st pipeline: select the 4th substring delimited by _
    #after the 2nd pipeline : select the 6 caracters of this substring
dir="./"$cycle
if [ -d $dir ]
# [ xxx ] same as test (spaces important).
#-d : True if FILE exists and is a directory.
then
    mv $file $cycle
    #if the directorie already exist, put the file in it
else
    mkdir $dir
    mv $file $dir
    #if the directorie does not exist, creat one and put the file in it
fi
  else
        echo "File error for " $file
  fi
done