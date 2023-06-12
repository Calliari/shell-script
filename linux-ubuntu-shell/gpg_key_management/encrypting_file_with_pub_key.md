#### Import the key to a temporary folder, for example using
```
gpg --homedir /tmp/gnupg --import my.pub
```

#### Determine the key ID of the key stored in the file:
```
KEYID=`gpg --list-public-keys --batch --with-colons --homedir /tmp/gnupg | head -n1 | cut -d: -f5`
```

#### Encrypt a message to the recipient
```
gpg --homedir /tmp/gnupg --recipient ${KEYID} --encrypt
```

#### Decrypt a message to the recipient
```
gpg --homedir /tmp/gnupg --recipient ${KEYID} --decrypt file.txt.gpg
```

#### Clean up temporary GnuPG home directory
```
rm -f /tmp/gnupg
```
