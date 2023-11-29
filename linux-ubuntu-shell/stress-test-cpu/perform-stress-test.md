The stress is a tool that enables to generate a workload on the system via command line. 
This allows to configure amount of load on CPU, memory, and I/O

##### Update and Intall the stress tool
```
sudo apt update && sudo apt install -y stress
```

Once installation is completed, we can check stress version:
```
stress --version
```

We can use uptime command to determine the average system load before and after running a stress command.
```
uptime
sudo stress --cpu 2 --timeout 10
uptime
```


##### Uninstall stress
```
sudo apt purge --autoremove -y stress
```
