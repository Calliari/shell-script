#list all ports for tcp
sudo lsof -itcp

#find all things listening on ports
lsof -Pnl +M -i4 | grep LISTEN

#all ports for tcp, dont resolve port name from numbers
sudo lsof -itcp -P

#open files and ports of process #$PID
sudo lsof -p $PID

#only ports of tcp for process #$PID, dont resolve port name, dont resolve ip name
sudo lsof -a -p $PID -P -n -itcp

#only ports of tcp for process #$PID, dont resolve port name, dont resolve ip name, refresh every 5 seconds
sudo lsof -a -p $PID -P -n -itcp -r 5

#search by file (can be slow)
sudo lsof /complete/path/to/file

#plenty more options and usage patterns
