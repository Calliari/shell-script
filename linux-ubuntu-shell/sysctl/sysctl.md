##### Change Linux kernel configuration
There is a dir where various files that can be used to modify the kernel runtime, the basic commaand are;

See the help and what the flags are;
  ```
  sysctl --help
  ```

Check the current config;
  ```
  sysctl -a
  ```

Add/change a new or the current config, for example;
  ```
  sysctl -w vm.overcommit_ratio=100
  #or
  sysctl -w vm.swappiness=45
  ```

These changes are applied immediately but will only persist until the next system reboot.
To have the changes remain permanent, the same parameter values need to be added to sysctl.conf –file;
There is a directory at; `/etc/sysctl.d` and a default file at; `sysctl.conf`
  ```
  # All files under the dir will be load and configure the kernel, i.e;
  /etc/sysctl.d/1000-custom.conf
  
  ```

 Or it can be added inot the main default file;
  ```
  vim  /etc/sysctl.conf
  ```

To reload the Linux kernel configuration withou reboot, run;
  ```
  sysctl -p
  ```

Tutoria;
1) Check the swappiness before change
    ```
    cat /proc/sys/vm/swappiness
    ```

2) Change the swappiness
   ```
   # vim  /etc/sysctl.conf
   vm.swappiness = 44
   ```
3) Reload the configuration after chaneg - (reload systemctl)
   ```
   sysctl -p
   #or
   systemctl daemon-reload
   #or
   sysctl --system

   ```

4) recheck the swappiness after change
   ```
   cat /proc/sys/vm/swappiness
   ```
