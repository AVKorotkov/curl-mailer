#!/usr/bin/env bash

set -o nounset
set -o errexit

#===  MAIN  ===

source curl-mailer.sh $*
# process email message
process
