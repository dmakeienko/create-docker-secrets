#!/bin/bash

###
###    This script will help to create Docker Secrets on server without exposing commands to history file
###

set -e
# Do not store command in history file so secret values won't be exposed
unset HISTFILE


usage="$(basename "$0") [-h] [-n name] [-v value] [-f /path/to/file]-- script to create docker secrets\nwhere:\n
    -h  show this help text\n
    -f /path/to/file\n
    -n  secret name (required)\n
    -v  secret value (required)"


create_secret(){
   secret_name="$1"
   secret_value="$2"
   printf "$secret_value" | docker secret create $secret_name -
}


# Fail if no arguments were passed to script
if [[ -z $1 ]]; then
    echo -e "No arguments were passed!\n"
    echo -e $usage
    exit 1
fi

while getopts ':hn:v:f:' option; do
  case "$option" in
    h) echo -e "$usage"
       exit
       ;;
    n) secret_name=$OPTARG
       ;;
    v) secret_value=$OPTARG
       ;;
    f) file=$OPTARG
         while $IFS read -r line
         do   
            secret_name=$(awk -F'=' '{print $1}' <(echo "$line"))
            secret_value=$(awk -F'=' '{print $2}' <(echo "$line"))
            create_secret $secret_name $secret_value
         done < $file
      ;;
    :) printf "missing argument for -%s\n" "$OPTARG" >&2
       echo -e "$usage" >&2
       exit 1
       ;;
   \?) printf "illegal option: -%s\n" "$OPTARG" >&2
       echo -e "$usage" >&2
       exit 1
       ;;
  esac
done
shift $((OPTIND - 1))

if [ -z $file ]; then
   create_secret $secret_name $secret_value
fi