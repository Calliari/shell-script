### Reference
https://tmuxcheatsheet.com/

## Install tmux on ubuntu 
sudo apt-get install tmux

#### All tmux commands begin with the prefix "^b" (control b) so enter the prefix following by.a command:

##### Create/Split the panel horizontally (relatve in what panel your course is)
```
^b "
```

##### Create/Split the panel vertically (relatve in what panel your course is)
```
^b %
```

#### To move your cursor around the panes, keep the ^(control pressed) to move the panel around on the screen.
```
^b o
```

#### To show pane numbers and sync to the selected ones only if needed
```
^b q
```

#### To close your the panel, (relatve in what panel your course is)
```
^b x
```

#### To synchronize the commands from one panel, to all the other panes use:
1. First the prefix comands:
```
^b :setw
```
2. write and press enter
```
synchronize-panes on
```

#### change the panes layout
```
^b spacebar
```

#### To turn panel synchronization off, use: 
```
^b :setw synchronize-panes off
```

#### Detach from a tmux session (like "^ a d" in screen)
```
^b d
```

#### re-atach to a tmux session when you next login
```
#tmux a -t mysession_or_session_id
tmux a -t 2
```

#### List tmux session detached
```
 tmux ls
```
