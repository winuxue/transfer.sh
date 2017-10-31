################################################################################################
#
# Defines transfer alias and provides an easy command line for file(s) and folder sharing.
#
################################################################################################
transfer() { 
	# check curl
    curl --version 2>&1 > /dev/null
	if [ $? -ne 0 ]; then
	  echo "Could not find curl."
	  return 1
	fi

    # check arguments
    if [ $# -ne 1 ]; 
    then 
        echo -e "Wrong arguments specified. Usage:\ntransfer /tmp/test.md\ncat /tmp/test.md | transfer test.md"
        return 1
    fi

    # read stdin or file
    arg="$1"

    #check if path exists
    if [ ! -e "$arg" ];
    then
        echo "$arg doesn't exists."
        return 1
    fi

    # get 'slug' and 'file' name
    if tty -s; 
    then
        slug="$( basename "$arg" | sed -e 's/[^a-zA-Z0-9._-]/-/g' )"

        if [ -d "$arg" ];
        then
            # zip directory
            zipfile="$(mktemp -u -t transferXXX.zip)"
			echo "zipping..."
			zip "$zipfile" -r -q "$(basename "$arg")"

            file="$zipfile"
        else
            file="$arg"
        fi
    else
        slug="$arg"
        file="-"
    fi

    # get temporary filename, output is written to this file so show progress can be showed
    tmpfile="$( mktemp -t transferXXX )"

    # transfer file or pipe
    echo "uploading..."
    curl --progress-bar --upload-file "$file" "https://transfer.sh/$slug" >> "$tmpfile"

    # copy link to the clipboard
	if [ -x "$(command -v xclip)" ];
	then
		xclip -sel clip < "$tmpfile"
	fi

    # cat output link
    cat "$tmpfile"
    echo

    # cleanup
    rm -f "$tmpfile"
}