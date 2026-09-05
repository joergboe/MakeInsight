#!/bin/bash

IFS=$' \t\n'

usage="Usage: useCpu [-h|-s|-e|(-i <id>)].. [--] seconds"

myhelp() {
	cat <<-EOF
	Use one CPU threat for a number of seconds.

	    Options:
	        -h: This help
	        -s: Silent
	        -i: an id to print
	        -e: Return 11 on exit

	EOF
}

declare silent=
declare myId=
declare errorex=
while getopts 'hsei:' arg; do
	case ${arg} in
		h) myhelp; exit 0;;
		s) silent=1;;
		e) errorex=1;;
		i) myId="${OPTARG}";;
		\? | *) echo "${usage}"; exit 2
	esac
done

[[ ${OPTIND} -gt 1 ]] && shift $((OPTIND-1))
if [[ $# -eq 1 ]]; then
	declare -i myDuration="$1"
else
	echo "${usage}"
	exit 2
fi

[ -n "${silent}" ] || echo "START useCpu myDuration=$1 id=$myId"
declare -i t1
t1=$(date '+%s')
declare -i t2=$((t1 + myDuration))
declare -i tx=0
while ((tx < t2)); do
	declare -i x=100000;
	while ((x--)); do
		:
	done;
	tx=$(date '+%s')
done

if [ -n "${errorex}" ]; then
	[[ -z ${silent} || -n ${myId} ]] && echo "END useCpu id=$myId Failure emulated"
	exit 11
else
	[[ -z ${silent} || -n ${myId} ]] && echo "END useCpu id=$myId Success emulated"
	exit 0
fi
