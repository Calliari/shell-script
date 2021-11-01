#!/usr/bin/env python

BUCKET = 'bucket-us-east-2-files'

import boto3

s3 = boto3.resource('s3')
bucket = s3.Bucket(BUCKET)
bucket.object_versions.delete()

# if you want to delete the now-empty bucket as well, uncomment this line:
#bucket.delete()

#### --------------------------------------
## create a file and paste the code with the variable for the BUCKET assigned
# touch delete-aws-bkt-objs.py 

### and run it 
# python3 delete-aws-bkt-objs.py
