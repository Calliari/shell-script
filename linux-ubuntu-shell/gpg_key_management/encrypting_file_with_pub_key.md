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
gpg --homedir /tmp/temp-dir/ --encrypt --recipient ${EMIAL_ADDRESS_1} --recipient ${EMIAL_ADDRESS_2} secret.txt
```

======================================================================================
##### Decrypt a message to the recipient
```
# using a particular email associated with public-key imported
gpg --recipient ${EMIAL_ADDRESS} --decrypt secret.txt.gpg

# using a particular privete-key path
gpg --default-key /tmp/temp-dir/temp-private-key/PRIVATE.key --recipient ${EMIAL_ADDRESS} --decrypt secret.txt.gpg

# Not specifying a "key" or "email associated with a key" will be using the default public-key 
gpg --decrypt secret.txt.gpg
```

#### Clean up temporary GnuPG home directory
```
rm -f /tmp/temp-dir/
```
