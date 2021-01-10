## Create a service in linux Ubuntu


In order to create a service manually like when you need to restart nginx or apache, etc./
e.g ``` $ sudo service apache start```

1 - Create a file with the app's name with ".conf" extension such as;

make sure it is on the right directory as show bellow

```
$ touch /etc/init/sample.conf
```
2 - Hard code with the file created, the sample can be check on this repo with the name sample.conf

3 - create another file in another directory now, with ".service" extension this time;

```
$ touch /etc/systemd/system/sample.service
```

4 - Hard code with the file created, the sample can be check on this repo with the name `sample.service`


##### Now if the path and the command are correct just start your service with;

The service's naem to be started would be the file created without the `.service` extention, E.X; 

``` 
$ sudo service sample start
```

##### After that your app will start just like "apache" or "nginx", it can also have the restart and stop commands, just add them to the files, and you are good to go and have the service just like that;
