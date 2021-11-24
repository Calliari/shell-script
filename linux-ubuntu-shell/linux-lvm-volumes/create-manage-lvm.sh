# https://www.thegeekstuff.com/2010/08/how-to-create-lvm/

sudo pvcreate /dev/vdb  # create physical-volume

sudo vgcreate clientdata /dev/vdb # create volume-group

sudo lvcreate -l +100%FREE -n srv clientdata # create logical-volume

sudo vgchange -ay clientdata # enable and activate

# sudo lvremove /dev/centos_centos71x64/srv # remove logical-volume '/dev/centos_centos71x64/srv'

sudo mkfs /dev/mapper/clientdata-srv # format 'no force'
sudo mkfs.xfs /dev/mapper/clientdata-srv -f # make it xfs format 'force -f'

sudo mount /dev/mapper/clientdata-srv /srv # mount and maybe need restart before mount 'sudo systemctl daemon-reload'


#################### resize 
pvresize /dev/sdb
lvextend -l +100%FREE /dev/mapper/data-Archive
xfs_growfs /Archive
