### Useful jenkins cli commands
References: 
https://www.jeffgeerling.com/blog/2018/fixing-jenkins-cli-error-anonymous-missing-overallread-permission
https://mohitgoyal.co/2017/02/15/upgrade-jenkins-server-to-a-new-version/
https://mohitgoyal.co/2017/02/07/configuring-backup-for-jenkins/
http://localhost:8080/cli/

Download the cli from jenkins source download link:
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

Backup jenkins 
```
cd /var/lib/
tar -zcvf jenkins_bkp_date.tar.gz jenkins
```

Download the jenkins verison 
```
curl -O https://updates.jenkins.io/download/war/2.289.2/jenkins.war
``` 

UPGRADEING jenkins
```
sudo systemctl status jenkins 
sudo systemctl stop jenkins

cp /usr/lib/jenkins/jenkins.war /tmp/jenknis-war-file-bkp/
rm /usr/lib/jenkins/jenkins.war
cp /var/lib/jenkins/jenkins-version/jenkins-war-version-2.289.2/jenkins.war /usr/lib/jenkins/

sudo systemctl restart jenkins

```

Download and install the plugins, along with any of its dependencies.
```
java -jar jenkins-cli.jar -s http://127.0.0.1:8080/ install-plugin <name>
```

