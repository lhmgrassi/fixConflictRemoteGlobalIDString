#!/bin/bash
file=$1

pattern='>>>>>>> develop'
sed -i '' "/$pattern/d" $file

pattern='======'
sed -i '' "/$pattern/d" $file

keep_checking=true

function delete_head_conflict {
	pattern='<<<<<<< HEAD'
	lineCount=0
	keep_checking=false

	while read -r line;
	do
		let "lineCount+=1"

		if [ "$pattern" = "$line" ]; then
			sed -i '' "${lineCount}d" $file # <<<<<<< HEAD
			sed -i '' "${lineCount}d" $file 	# remoteGlobalIDString = A7D9BAA70027439BBA92D18C;
			keep_checking=true
			echo "Fixed conflict"
			break
		fi
		
	done < $file
}

while [ $keep_checking = true ]; do
	delete_head_conflict
done

echo "Done"