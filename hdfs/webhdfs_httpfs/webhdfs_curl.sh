#!/bin/bash

# default HttpFS port 14000
# WehHDFS port - NN port - default: 50070
DIR=tmp
FILE=testWebHDFS.txt
USER=training

USE="WebHDFS: $0 <Active Namenode:Port> [status|put|get|mkdir|deleteFir|deleteDir] \n
     HttpFS: $0 <HTTPServer:Port> [status|put|get|mkdir|deleteFir|deleteDir] \n"

if [ $# -lt 2 ] || [ $# -gt 4 ];
    then
        echo "illegal number of parameters"
        echo $USE
        exit 0
fi

SERVER_AND_PORT=$1
CMD=$2
QUERY="http://$SERVER_AND_PORT/webhdfs/v1"

if [ $# -eq 4 ];
        then
                DIR=$3
                FILE=$4
fi

if [ $# -eq 3 ];
        then
                DIR=$3
fi

DIR="user/$USER/$DIR"

case $CMD in
        status)
                echo "Get $DIR directory status"
                curl -i "$QUERY/$DIR?op=LISTSTATUS&user.name=$USER"
        ;;
        mkdir)
                echo "Create $DIR directory"
                curl -i -X PUT "$QUERY/$DIR/?op=MKDIRS&user.name=$USER"
        ;;
        put)
                # test if directory exists
                exists=`curl -i  "$QUERY/$DIR?op=GETFILESTATUS&user.name=$USER" 2>/dev/null| grep 'FileNotFoundException'`
                if [ -z "$exists" ];
                        then
                                echo "Directory exists..."
                        else:
                                echo "Directory does not exist...creating $DIR"
                                curl -i -X PUT "$QUERY/$DIR/?op=MKDIRS&user.name=$USER"
                fi
                echo "Will now PUT $FILE into directory $DIR"
                # curl -i -X PUT "http://<HOST>:<PORT>/webhdfs/v1/<PATH>?op=CREATE
                #                [&overwrite=<true|false>][&blocksize=<LONG>][&replication=<SHORT>]
                #                [&permission=<OCTAL>][&buffersize=<INT>]"
                curl -i -L -X PUT "$QUERY/$DIR/$FILE?op=CREATE&user.name=$USER" -T ./$FILE
        ;;
        get)
                echo "GET $DIR/$FILE"
                redir=`curl -i "$QUERY/$DIR/$FILE?op=OPEN&user.name=$USER" 2>/dev/null`
                echo "First we get a redirect: $redir"
                echo "==========================="
                echo "And now get the content of $FILE: "
                echo
                location=`echo "$redir" | grep "Location: http" | awk '{split($0,a,": "); print a[2] a[2]}'`
                curl -i $location
        ;;
        deleteFile)
                echo "Delete $DIR/$FILE"
                curl -i -X DELETE "$QUERY/$DIR/$FILE?op=DELETE&user.name=$USER"
        ;;
        deleteDir)
                echo "Delete directory $DIR"
                curl -i -X DELETE "$QUERY/$DIR?op=DELETE&user.name=$USER"
                # Try &recursive=true if directory non-empty
                # curl -i -X DELETE "$PREFIX/$DIR?op=DELETE&user.name=$USER&recursive=true"
        ;;
        *)
                echo "Command not understood: $CMD"
                echo $USE
                exit 1
        ;;
esac

