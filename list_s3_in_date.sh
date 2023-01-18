#!/bin/bash

#auth:rzz0
# SCRIPT: return all files that were last modified today

usage() {
    echo "Instruction:"
    echo "make the script executable: chmod +x list_s3_in_date.sh"
    echo "run the script in linux terminal and add the parameters:"
    echo "-n: bucket-name"
    echo "-d: YYYY-MM-DD"
    echo "Example: ./list_s3_in_date.sh -n my-bucket-name -d 2022-12-31"
    echo "The script will return the list in terminal and a csv file with the output."
}

while getopts ":n:d:h" opt; do
  case $opt in
    n)
      bucket="$OPTARG"
      ;;
    d)
      date="$OPTARG"
      ;;
    h)
      usage
      exit 0
      ;;
    \?)
      echo "Invalid option: -$OPTARG" >&2
      usage
      exit 1
      ;;
    :)
      echo "Option -$OPTARG requires an argument." >&2
      usage
      exit 1
      ;;
  esac
done

if [ -z "$bucket" ]; then
    echo "You must provide the -n option followed by the bucket name."
    usage
    exit 1
fi

if [ -z "$date" ]; then
    date=$(date +"%Y-%m-%d")
fi

aws s3 ls s3://$bucket --recursive --human-readable | grep $date | awk '{print $4 "," $5}' | tee result_$date.csv