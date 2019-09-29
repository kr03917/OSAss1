
#!/bin/bash
if [ $# -ne 2 ]
then
        echo "The number of arguments is not equal to 2"                                                                   else                                                                                                                               _file = "$1"
        directory = "$2"
        if [ ! -f "$_file" ]                                                                                                       then
                echo "File not found"                                                                                              elif [ ! -s "$_file"  ]                                                                                                    then
                echo "File is empty"
        elif [ ! -d "$directory"]                                                                                                  then
                echo "Directory/path not found"                                                                                    else                                                                                                               
fi
