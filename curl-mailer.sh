#!/usr/bin/env bash

set -o nounset
set -o errexit

#===  FUNCTION  ========
#
# Process email message
#
#=======================
function process() {
	set_names
	parse_conf
}
