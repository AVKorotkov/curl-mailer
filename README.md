# cURL Mailer

cURL Mailer is a Bash function to send email messages using cURL. It sends
a message according to your configuration file and using your account on an SMTP
server.

## Requirements

cURL and any recent versions of GNU Bash, GNU sed, GNU Grep.

Of course, you need an account on any SMTP server, on Google Mail, for example.

## Features

* use configuration file
* create logs if required
* be verbose or quiet
* be interactive or non-stop

## Installation

Not required. Clone this repository and use `curl-mailer.sh` as
described below.

## Usage

cURL Mailer utilizes configuration files that might look like [this
sample](sample.conf) (please look at my other Bash project, [Bash configuration
files parser](https://github.com/AVKorotkov/bash-config-parser/tree/master)).
You need to create a script and a configuration file with the same name, but
with the `conf` extension, for example, `sample.sh` and `sample.conf`, and put
both files in the same directory. Source `curl-mailer.sh` in your
[script](sample.sh) and call `process` function that sends your message.

Feel free to expand cURL Mailer to whatever you want if you find any limitations
of your needs in this function.
