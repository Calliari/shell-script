### Useful jenkins cli commands
References: 
http://localhost:8080/cli/

Download te cli fro jenkins source download link:
```
curl -O http://localhost:8080/jnlpJars/jenkins-cli.jar
```
Check the if the user is Authenticated and if Authorited to run cmds: 
```
java -jar jenkins-cli.jar -s "http://localhost:8080" -auth USERNAME:PWD who-am-i
```

Check the version:
```
java -jar jenkins-cli.jar -s "http://localhost:8080" -auth USERNAME:PWD version
```
