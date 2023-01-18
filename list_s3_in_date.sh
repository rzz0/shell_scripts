#!/bin/bash

#auth:rzz0
# SCRIPT: return all files that were last modified today
# Requires the AWS CLI
# Instruction:
# make the script executable: chmod +x list_s3_in_date.sh
# run the script in linux terminal and add the parameters:
# -n: bucket-name
# -d: YYYY-MM-DD".
# Example: ./list_s3_in_date.sh -n my-bucket-name -d 2022-12-31
# The script will return the list in terminal and a csv file with the output.

while getopts ":n:d:" opt; do
  case $opt in
    n)
      bucket="$OPTARG"
      ;;
    d)
      date="$OPTARG"
      ;;
    \?)
      echo "Invalid option: -$OPTARG" >&2
      exit 1
      ;;
    :)
      echo "Option -$OPTARG requires an argument." >&2
      exit 1
      ;;
  esac
done

if [ -z "$bucket" ]; then
    echo "You must provide the -n option followed by the bucket name."
    exit 1
fi

if [ -z "$date" ]; then
    date=$(date +"%Y-%m-%d")
fi

aws s3 ls s3://$bucket --recursive --human-readable | grep $date | awk '{print $4 "," $5}' | tee result_$date.csv
