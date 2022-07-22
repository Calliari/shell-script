
##### The command with 'gpg' allow to generate the key wit the following options
```
--quick-generate-key  # requires the USER-ID field on the command line and optionally an algorithm, usage, and expire date. It implements defaults for all other options.
--generate-key        # prompts for the real name and email fields before asking for a confirmation to proceed. In addition to creating the key, it also stores a revocation certificate.
--full-generate-key   # prompts a dialog for all options
```

##### For GPG help commands and flags
```
gpg -h
```


##### List out the public-key
```
gpg --list-keys
```

##### List the private-key 
```
gpg --list-secret-keys
```
or
```
gpg --list-secret-keys --keyid-format=long
/Users/hubot/.gnupg/secring.gpg
------------------------------------
sec   4096R/3AA5C34371567BD2 2016-03-10 [expires: 2017-03-10]
uid                          Hubot 
ssb   4096R/42B317FD4BA89E7A 2016-03-10
```

##### Prints the GPG public key ID, in ASCII armor format (public key) - the GPG key ID is 3AA5C34371567BD2 or by it's 'uid'
```
gpg --armor --export 3AA5C34371567BD2
or 
gpg  --armor --export Hubot

-----BEGIN PGP PUBLIC KEY BLOCK-----
KCRARQK9W/qhXFQM8D/9KzmqxYQpX3Lzma
KCRARQK9W/qhXFQM8D/9KzmqxYQpX3Lzma
...
KCRARQK9W/qhXFQM8D/9KzmqxYQpX3Lzma
-----END PGP PUBLIC KEY BLOCK-----
```

##### Edit the GPG key with "GPG key ID" and add the user ID details.
```
gpg --edit-key 3AA5C34371567BD2
gpg> adduid
# add the details need -> [ (N)ame, (C)omment, (E)mail or (O)kay/(Q)uit? ]
gpg> save
```


##### No longer need the GPG key can be deleted using the 'uid' or 'GPG key ID'
1. The private-key needs to be deleted first and then the public-key </br>
Deleting the private-key
```
# gpg --delete-secret-key [uid]
gpg --delete-secret-key Hubot

# gpg --delete-secret-key [Key_ID]
gpg --delete-secret-key 3AA5C34371567BD2
```

2. The public-key can now be deleted
Deleting the private-key
```
#gpg --delete-key [uid]
gpg --delete-key Hubot

# gpg --delete-key [Key_ID]
gpg --delete-key 3AA5C34371567BD2
```
