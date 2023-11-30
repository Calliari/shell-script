#### From within the instance:

##### Example(1) 
###### curl with user-data metadata 
```
curl http://169.254.169.254/latest/user-data | zcat
```

##### Example(2) 
###### Get instance ID
```
INSTANCE_ID=$(curl -s http://169.254.169.254/latest/meta-data/instance-id)
```

###### Print user data 
```
sudo cat /var/lib/cloud/instances/$INSTANCE_ID/user-data.txt
# or 
sudo zcat /var/lib/cloud/instances/$INSTANCE_ID/user-data.txt
```

In case need decoding;
```
base64 --decode /var/lib/cloud/instances/$INSTANCE_ID/user-data.txt
```
