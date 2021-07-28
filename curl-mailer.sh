#!/usr/bin/env bash

set -o nounset
set -o errexit

#===  FUNCTION  ==================
#
# Print description of the script
#
#=================================
# TODO
function description() {
	# script name
	local script_name=$(basename "$0")
	cat<<-EODESC
		~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
		Check a directory for some types of files, send them by email
		and move to another directory after that.
		Usage: $script_name [options]
		  options:
		    -h, --help            print this help text and exit
		    -v, --verbose         verbose output
		~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

	EODESC
}

#===  FUNCTION  ===
#
# Set names
#
#==================
function set_names() {
	# absolute path to this script
	script=$(readlink -f "$0")
	# directory of the current script
	script_dir=$(dirname "$script")
	# script name
	script_name=$(basename "$0" | cut -d "." -f 1)
}

#===  FUNCTION  ===============
#
# Print error message and exit
#
#==============================
function err_exit() {
	# message to print
	local msg="${1}"
	# set exit code
	local code="${2}"
	# print error message
	echo "$msg"
	# exit with the given code
	exit "$code"
}

#===  FUNCTION  =======
#
# Parse options
#
#======================
function parse_opts() {
	## check for number of options
	case ${opts_count} in
		0)
			;;
		1)
			# if '-v' or '--verbose' is present then set verbose
			if [ "${opts}" = "-v" ] || [ "${opts}" = "--verbose" ]; then
				verbose=true
			# if '-h' or '--help' is present then show help end exit
			elif [ "${opts}" = "-h" ] || [ "${opts}" = "--help" ]; then
				description
				exit 0
			# if unknown option then show help end exit
			else
				description
				err_exit "Unknown option (${opts}). Aborted" 1
			fi
			;;
    *)
			# show help end exit if number of options > 1
			description
			err_exit "Too many options (${opts_count}). Aborted" 1
			;;
  esac
}

#===  FUNCTION  ======================
#
# Test file existence and readability
#
#=====================================
function test_file() {
	# check if the given file exists and readable
	if [ ! -f "${1}" ] || [ ! -r "${1}" ]; then
		err_exit "File '${1}' does not exist or it is not readable. Aborted." 1
	fi
}

#===  FUNCTION  ========
#
# Parse config file
#
#=======================
function parse_conf() {
	# config directory
	local config_dir="$script_dir"
	# config name
	config_name="${script_name}.conf"
	# config file path
	local config="${config_dir}/${config_name}"

	# check if the config file exists and readable
	test_file "$config"

	# read config file
	local conf
	conf=$(<"$config")
	# clean config: skip blank lines, comments,
	# trim leading and trailing whitespaces, compact assignments
	conf=$(echo "$conf" | sed 's/#.*//' | sed 's/^[ \t]*//;s/[ \t]*$//' | grep -P -v "^[ \t]*$|^#" | sed 's/[ \t]*=[ \t]*/=/')

	# number of all entries in config file
	local all
	all=$(echo "$conf" | wc -l)
	# number of correct entries in config file
	local correct
	correct=$(echo "$conf" | grep -c '[^^]=')
	# exit if number of correct entries in config file less than number of all entries
	[ "$correct" != "$all" ] && err_exit "Syntax of ${config_name} is incorrect. Aborted." 2

	## set values for options
	while read -r line
	do
		# get the left side from the current line (variable)
		option=${line%%=*}
		# get the right side from the current line (value)
		value=${line#*=}
		# strip quotes from value
		[[ "${value}" == \"*\" || "${value}" == \'*\' ]] && value="${value:1:-1}"
		# assign the current value to the current variable
		printf -v "$option" '%s' "$value"
	done <<< "$conf"
}

#===  FUNCTION  ========
#
# Send email message
#
#=======================
function send_mail() {
	echo Send email message
}

#===  FUNCTION  ========
#
# Process email message
#
#=======================
function process() {
	# set verbose to false by default
	verbose=false
	# parse options
	parse_opts
	# set some names
	set_names
	# print "start"
	# start
	# parse configuration
	parse_conf
	# check config file values
	# check_conf
	# start to create log line
	# logging
	# print configuration
	# show_info
	# proceed to continue
	# proceed
	# set cURL options
	# set_curl
	# get cURL error codes
	# get_curl_codes
	#
	send_mail
	# print stop running
	# stop
}

opts_count=$#
opts="$*"
