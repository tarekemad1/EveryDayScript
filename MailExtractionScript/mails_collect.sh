#!/bin/bash
rm -f developers.txt
Path=$(pwd);
while read line 
do  
    git clone $line ; 
    repo_name=$(basename -s .git "$line" )
    Proj_path="${Path}/${repo_name}"
    cd "$Proj_path"
    git log >> "${Path}/${repo_name}_log.txt"
    cd "$Path"
done < "$Path/Links.txt"


while read -r line 
do 
    if [[ "$line" == Author:* ]];
    then
        if ! grep -q "$line" "$Path/developers.txt" ;
            then
            echo "$line" >> "$Path/developers.txt"
        fi
    fi
    
done < "$Path/${repo_name}_log.txt"
rm -f "$Path/${repo_name}_log.txt"