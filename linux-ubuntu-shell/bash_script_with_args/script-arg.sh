#!/bin/bash
#
# @author Osvaldo Caliari
#
# @revisions
#   1.0: Initial script


# ============================================
# This is a template script that can be used as a initial template
# ============================================


# Simple timer
start=$(date +'%s')

# ####################
# Define a couple of simple functions.
# ####################

##
 # Initial variables.
 #
 # @return string
 #   Description of the available options
 ##
usage() {
  echo "Usage: $0\
 [--first-arg <string>]\
 [--second-arg <string>]\
 [--third-arg <string>]\
 [--fourth-arg <string>]\
 [--user-arg (optional)]\
 [--skip-this-arg|-s (optional)]\
 [--verbose|-v (optional)]" 1>&2
  exit 1
}

##
 # Function for logging, only displaying message if VERBOSE is true.
 #
 # @param string
 #   The message to log.
 #
 # @return string|NULL
 #   The message (if VERSBOSE is true), or nothing.
 ##
log() {
  if [ "$VERBOSE" = "true" ]; then
    echo "$1"
  fi
}

# Command template on how to use it
# ./script-arg.sh --first-arg="my first argument" --second-arg="my second argument" --third-arg="my third argument" --fourth-arg="my fourth argument" --user-arg="$USER" -v




# Define variables from options.
TEMP=`getopt -o v --long verbose,first-arg:,second-arg:,third-arg:,fourth-arg:,user-arg:,--skip-this-arg -- "$@"`
if [ $? != 0 ]; then
  usage
fi

eval set -- "$TEMP"
# Set defaults args in case need
VERBOSE=false
FIRST_ARG=
SECOND_ARG=
THIRD_ARG=
FOURTH_ARG=
SKIP_THIS_ARG="yes"
USER_ARG=


while true; do
  case "$1" in
    -v | --verbose )
      VERBOSE=true;
      shift;;
    --first-arg )
      FIRST_ARG="$2";
      shift 2;;
    --second-arg )
      SECOND_ARG="$2";
      shift 2;;
    --third-arg )
      THIRD_ARG="$2"
      shift 2;;
    --fourth-arg )
      FOURTH_ARG="$2"
      shift 2;;
    --user-arg )
      USER_ARG="$2"
      shift 2;;
    --skip-this-arg )
      SKIP_THIS_ARG="$2"
      shift 2;;
    *)
      break;;
  esac
done

# All of these are required
if [ "${FIRST_ARG}" = "" ] || [ "${SECOND_ARG}" = "" ] || [ "${THIRD_ARG}" = "" ] || [ "${FOURTH_ARG}" = "" ]; then
  usage
fi


# ####################
# We are good to start...
# ####################

# If VERBOSE, output the settings for this run.
log ""
log "=================================================================="
log "Settings:"
log "- first-arg set to:      $FIRST_ARG"
log "- second-arg set to:     $SECOND_ARG"
log "- third-arg set to:      $THIRD_ARG"
log "- fourth-arg set to:     $FOURTH_ARG"
log "- skip-this-arg set to:  $SKIP_THIS_ARG"
log "- user-arg set to:       $USER_ARG"
if [ "$VERBOSE" = "true" ]; then
  log "- Verbose mode is:     ON"
else
  log "- Verbose mode is:     OFF"
fi
log "=================================================================="
log ""


