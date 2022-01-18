# Update the "sDEFINER" to be "root@localhost"
sed -i 's/\sDEFINER=`[^`]*`@`[^`]*`/ DEFINER=`root`@`localhost`/' test_db__bkp_13_01_2022.sql

# Remove "sDEFINER" completely
sed -i 's/\sDEFINER=`[^`]*`@`[^`]*`//g' test_db__bkp_13_01_2022.sql

# Rename the database
sed -i "s/\`test_live\`/\`test_uat\`/g" test_db_bkp_13_01_2022.sql
sed -i 's/test_live\./test_uat\./g' test_db_bkp_13_01_2022.sql
