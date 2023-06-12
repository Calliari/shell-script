#### Import the key to a temporary folder, for example using
```
gpg --homedir /tmp/temp-dir/ --import my.pub
```

#### Determine the "PUBLIC" key ID and or EMAIL_ADDRESS of the key stored in the file:
```
gpg --homedir /tmp/temp-dir/ --list-public-keys
```

##### Encrypt a message to the recipient
```
gpg --homedir /tmp/temp-dir/ --encrypt --recipient ${EMIAL_ADDRESS} secret.txt
```

======================================================================================
##### Decrypt a message to the recipient
```
gpg --default-key /tmp/temp-dir/temp-private-key/PRIVATE.key --recipient ${EMIAL_ADDRESS} --decrypt secret.txt.gpg
```

#### Clean up temporary GnuPG home directory
```
rm -f /tmp/temp-dir/
```
