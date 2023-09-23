#!/bin/bash
# ------------------------------------------------------------------
# Script to comperss screen recordings up to 10x
# By Serge Stecenko
# 
# Dependency:
#   https://ffmpeg.org/
# ------------------------------------------------------------------

usage() { 
    echo "Usage: $0 -i <input_file> -o <output_file>" >&2
    echo "  -i <input_file>: Specify the input file path (e.g., file.mov)" >&2
    echo "  -o <output_file>: Specify the output file name without an extension" >&2
    exit 1
}

cleanup() {
    unset -v option_type
    unset -v input_file
    unset -v output_file_name
}

cleanup

while getopts ":i:o:" option_type; do
    case ${option_type} in
        i)
            input_file=${OPTARG}
            ;;
        o)
            output_file_name=${OPTARG%%.*}.mp4
            ;;
        *)
            usage
            cleanup
            ;;
    esac
done

if [[ $OPTIND -eq 1 ]]
then
    usage
    cleanup
    exit 1
elif [[ $OPTIND -ne 5 ]]
then
    usage
    cleanup
    exit 1
fi

ffmpeg -i "${input_file}" -vcodec libx264 -crf 23 -preset medium ${output_file_name}
exit 0