#!/bin/bash

for f in $(ls)
do
 source "$HOME/.bashrc";
 echo "Processing $f ***********************************";
 tar_bz2_dir;
 echo "Done with $f **********************************";
 
 # do something on $f
done

function tar_bz2_dir()
{
    if [ "$1" != "" ]; then
        FOLDER_IN=`echo $1 |sed -e 's/\/$//'`;
        FILE_OUT="/media/shooty/balhi/$FOLDER_IN.tar.bz2";
        FOLDER_IN="$FOLDER_IN/";
        echo "Compressing $FOLDER_IN into $FILE_OUT…";
        echo "tar cjf $FILE_OUT $FOLDER_IN";
        tar cjf "$FILE_OUT" "$FOLDER_IN";
        echo "Done.";
    fi
}
