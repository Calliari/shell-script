##### based64 encryption and decryption

##### STRING

1. To `encrypt` a 'string' in based64, run;
```
echo -n 'my-string' | base64
```

1a. To `decrypt` a 'string' in based64, run;
```
echo -n 'bXktc3RyaW5n' | base64 --decode
```

##### FILE

2. To `encrypt` a 'file' in based64, run;
```
bas64 /path/to/file 
# or
bas64 /path/to/file > output-encrypted.txt
```

2a. To `decrypt` a 'file' in based64, run;
```
base64 --decode /path/to/file
# or
base64 --decode /path/to/file > output-dencrypted.txt
```
