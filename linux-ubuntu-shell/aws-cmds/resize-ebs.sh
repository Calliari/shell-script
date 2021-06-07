# https://docs.aws.amazon.com/AWSEC2/latest/UserGuide/recognize-expanded-volume-linux.html

1. Go to AWS console and increase the volume size

2. After a while teh volume will be "State = 100%"

3. Check the file system of a device block storage: (8GB to 10GB)
#list block devices
sudo lsblk

example output:
ubuntu@-172-32-32-200:~$ lsblk
NAME        MAJ:MIN RM  SIZE RO TYPE MOUNTPOINT
nvme0n1     259:0    0   8G  0 disk
└─nvme0n1p1 259:1    0   8G  0 part /


# check the percentage of the EBSs
df -h
df -T

Increase block storage using growpart as our filesystem is ext4.
#After allocating the EBS size from aws EBS, run resize CMS
`sudo growpart /dev/xvda` 1  or `sudo growpart /dev/nvme0n1 1`

#list block devices
sudo lsblk

example output:
ubuntu@-172-32-32-200:~$ lsblk
NAME        MAJ:MIN RM  SIZE RO TYPE MOUNTPOINT
nvme0n1     259:0    0   10G  0 disk
└─nvme0n1p1 259:1    0   10G  0 part /


#After increased block storage, but we also need to increase filesystem:
`sudo resize2fs /dev/xvda1` or `sudo resize2fs /dev/nvme0n1p1`


#  ======= Useful CMDS related =======
#'sudo xfs_growfs -d /volume-path'
#'sudo xfs_growfs -d /data'
#'sudo file -s /dev/nvme?n*'


