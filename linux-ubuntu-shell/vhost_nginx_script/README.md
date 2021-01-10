## This is a script to install and create two very basic website for testing a vhos using nginx



#### Instruction

* This script was deployed on AWS environment using  basic terraform for a "security group" and a IAM Ubuntu OS
* Nginx for hosting and redirect traffic for those basics websites
* Configurations for vhots


1 - Intall nginx
2 - create two websites
3 - add the websites on "/etc/hosts" to be available on the ec2 browser (not on the localhost)

There is a script for that already made: *vhost_nginx_website.sh*
just copy this script to the ec2 and run `sudo chmod +x vhost_nginx_website.sh && ./vhost_nginx_website.sh`

4 - The websites can be seem on localhost machine with additional configuration (additional configuration to redirect traffic to localhost from ec2 websites)

#### Details:

* The steps 1,2, & 3 in done in the AWS EC2, the the websites will be available only from the browser of the ec2 configured, the step four is optional.

To check the if the vhost configurations on the ec2 is working open a browser in the ec2 or use "curl" to display the html fo the each website.

``` curl example.com ```
 or

``` curl test.com ```


</hr>

However on the optional step four, both website can be check on the browser like; Google or Firefox.

- open the localhost terminal and add the following.

In MAC machines

`sudo nano /private/etc/hosts`

add the following with the ec2 ip address

```
## testing with my ec2 on AWS
35.177.123.123 example.com
35.177.123.123 test.com
#

```


Now the locahost will be checkiing if the ec2 ip address added above has the websites, *example.com* *test.com* and if the setting are correct, the websites will be available in the browser of the localhost pointing to the ec2 websites setup with nginx hosts.
