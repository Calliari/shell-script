#!bin/bash

# Deployment script to update a Drupa/Wordpress site through Jenkins.
#
#
# @revisions
#   1.0: Initial script

##########################################

# https://unix.stackexchange.com/questions/62950/getopt-getopts-or-manual-parsing-what-to-use-when-i-want-to-support-both-shor

# Pantheon Drupal Auto Update from DrupalCon (photo taken)
# https://github.com/populist/drupal-auto-update

################# How to use #########################

# . update-drupal.sh --site-root=/var/www/bbd-d7.bbdtest.co.uk --branch-name=dev --cms=d7

##########################################

## Simple timer
start=$(date +'%s')

##
 # Initial variables.
 #
 # @return string
 #   Description of the available options
 ##

# How to use this script
 usage() {
  echo "
Usage: $0\
 [--site-root <string>]\
 [--branch-name <string>]\
 [--cms <string>]

 ----------- sample ------------------------

 $ . update-drupal.sh --site-root=/var/www/www.example.com --branch-name=dev --cms=d7 \

 "
  exit 1
}

##
 # functions.
 ##
 wp-updade(){
   echo "update for WP"

 }

 d7-updade(){
   echo "update for D7"


 }

 d8-updade(){
   echo "update for D8"


 }


# END functions ####################

# Define variables from options.
OPTS=`getopt -o v --long verbose,site-root:,branch-name:,cms: -- "$@"`
if [ $? != 0 ]; then
  usage
fi

eval set -- "$OPTS"
# set initial values
# Set defaults.
VERBOSE=false
SITE_ROOT=
BRANCH_NAME=
CMS=


while true; do
  case "$1" in
    -v | --verbose )
      VERBOSE=true;
      shift;;
    --site-root )
      SITE_ROOT="$2";
      shift 2;;
    --branch-name )
      BRANCH_NAME="$2"
      shift 2;;
    --cms )
      CMS="$2"
      shift 2;;
    *)
      break;;
  esac
done

# All of these parameters are required
if [ "${SITE_ROOT}" = "" ] || [ "${BRANCH_NAME}" = "" ] || [ "${CMS}" = "" ] ; then
  usage
fi

# echo "value of verbose = $VERBOSE"
echo "value of site root = $SITE_ROOT"
echo "value of branch name = $BRANCH_NAME"
echo "value of cms = $CMS"

# ###############################
# Start the process of updating the website

if [ "${CMS}" = wp ] ; then
  wp-updade

elif [ "${CMS}" = d7 ] ; then
  d7-updade

elif [ "${CMS}" = d8 ] ; then
  d8-updade

else
  echo "dont know! Choose a Wordpress CMS or Drupal CMS version (7 or 8) to update!"
  usage
fi




####################
# Final notifiation:

# Script complete. Give stats:
end=$(date +'%s')
diff=$(($end-$start))
echo ""
echo "Update completed in $diff seconds."
echo "=================================================================="
echo ""

exit 0;

