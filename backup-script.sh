#!/bin/bash

# This is a script to run on a jenkins job to back up data and then update the code from the master branch

# ======================= UAT =======================
echo "Backing up the sql database UAT..."
echo "==================================================================";
# create a varial with the name backups_date + year + month + day + hour + min + sec.sql
DB_DUMP="backups_$(date +%y%m%d-%H%M%S).sql"
# Assing a path into variable "BACKUP" with the DB_DUMP file created in the step above.
BACKUP=/home/mypath/backups/"$DB_DUMP"

# get inot database and assing the backups redirect to "BACKUP" variable
mysqldump -u root -p "password" -h 127.0.0.1 database-name > "$BACKUP"
echo "Backup ... => $DB_DUMP" && echo ""
echo "================================================================== ";

#
if [ !-f "$BACKUP" ]; then
  # If there are any errors from backups. Throw error.
  echo "Error Thrown. "
  echo "Database backup not successfu..."
  echo "Olds backups available in  "$BACKUP" - please manually check this directory.\n=====================================\n"

  exit 1;
fi
echo ""


echo "Changing directory..."
cd /home/mypath/mywebsite-directory


echo "=================================================================="
echo "fetch the last version of code from..."
git config --get remote.origin.url

git fetch --tags --progress `git config --get remote.origin.url` +refs/heads/*:refs/remotes/origin/*
git checkout -f `git rev-parse origin/master^{commit}`
# wp cache flush

echo "=================================================================="

echo "Cleanup old db backups."
# In the backups folder the code will leave the last four backups and deletes the olds ones
cd /home/mypath/backups/
for OLD_BUILD_BACKUP in $(ls | grep sql$ | sort -rV | head -n-1 | tail -n+4); do
  echo -n "Removing $OLD_BUILD_BACKUP ...";
  rm "$OLD_BUILD_BACKUP"
  echo " done.";
done

# if the backups folder has more or less than 4 backups' files Thrown an error message
if [ $(ls -1A | wc -l) != 4 ]; then
  echo "Olds backups are not being removed! "
  echo "Error Thrown!!!"
fi

# ==================== END UAT script =========================


# This will create a sql backup from the mysql software intalled in the server and deletes old backup when it reached more the four backups
