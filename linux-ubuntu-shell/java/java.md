Update the centos repos on the server
```
sudo yum update
```

Install java 8
```
sudo yum install java-8-openjdk
```

Install java 11
```
sudo yum install java-11-openjdk
```


Command to set default Java version when more than one version is installed
```
sudo alternatives --config java
```

In case need to set JAVA_HOME Environment Variable and get the exact java path
```
sudo update-alternatives --config java
```
