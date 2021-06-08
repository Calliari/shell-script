USER='test_user'; PASS='12345678'; DATABASE='www_example_com'; HOST='my-database.us-east-1.rds.amazonaws.com';


for PID in $(/usr/bin/mysql -u$USER -p$PASS $DATABASE -h$HOST -BNe"SELECT ID FROM information_schema.PROCESSLIST WHERE Command = 'Sleep' AND DB = '$DATABASE' AND Time >= 300;") ;
do
    #  Show the PID processes on  sleep for '>=' 300s or more 
    echo  "PID : $PID"
    #  Kill the processes by PID
    # $(/usr/bin/mysql -u$USER -p$PASS $DATABASE -h$HOST -e"KILL $PID");
done
