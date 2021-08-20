# Instruction scan be found here
# http://www.kinnetica.com/2011/05/29/using-screen-on-mac-os-x/

# file that configures the screen commands ==> ~/.screenrc

# If you want to remove the startup message, add the following line to your .screenrc
Put "startup_message off" on ==> ~/.screenrc

#If you always want to see the terminal you are on and all open terminals by default, add the following line to your ~/.screenrc file:
caption always "%{= Wk}%-w%{= Bw}%n %t%{-}%+w %-="

# Useful commands
screen                      ==> create a new screen without name it
screen -t "terminal 1"      ==> create a new screen with name "terminal 1"
screen -ls                  ==> list of screen terminals created
screen -S your_session_name ==> create a new screen with name "your_session_name"
screen -t "Terminal 9" 9    ==> will create a new terminal window called Terminal 9 with a terminal number of 9
screen -list		          ==> It should list that you have one screen session open
screen -r 246906	          ==> to reattach to this session [screen -r process_id (PID)]
exit 			                ==> will exit the terminal, this is the command to terminate the seesion on the open terminal

# keyboard shortcuts
Ctrl-a ?     			==> To see a list of screens created
Ctrl-a       			==> see a list of open terminals, navigate among the screens
Ctrl-L 				==> clear to reset the screen
Ctrl-a “			==> Choose which screen want to run cmds
Ctrl-a i     			==> view which terminal you are currently using
Ctrl-a A     			==> rename this terminal
Ctrl-A c     			==> create new terminal
Ctrl-a n     			==> next window terminal
Ctrl-a p    			==> previous window terminal
Ctrl-a 9 			==> navigate to Terminal 9
Ctrl-a S 			==> have more than one terminal window open at the same time
   |
   |===> Ctrl-a [Tab] 		==>  Once you have split panes, you can easily switch between them
   |===> Ctrl-a Q  		==> exit out of split-pane view


Ctrl-a d 			==> detach from your screen session

# ============================
# quick cmds "create a screen"
screen -t "terminal 1"

# detach from screen
Ctrl-a d

# reatach
screen -r
