#!/bin/bash

if [ -n "${1}" ]
then
	HOOKS_DIR="${1}"
else
	echo "You need to pass in the hooks directory as argument." >&2
	exit 1
fi

if [ ! -d "${HOOKS_DIR}" ]
then
	echo "Hooks directory ${HOOKS_DIR} does not exists." >&2
	exit 1
fi

function hooks_handler() {
	local state extra_info state_hooks_dir hook_file
	while read state extra_info
	do
		state_hooks_dir="${HOOKS_DIR}/${state}.d/"
		if [ -d  "${state_hooks_dir}" ]
		then
			for hook_file in "${state_hooks_dir}"/*
			do
				test -r "${hook_file}" && source "${hook_file}"
			done
		else
			echo "Unhandled state ${state}."
		fi
	done
}

/usr/bin/xscreensaver-command -watch | hooks_handler
