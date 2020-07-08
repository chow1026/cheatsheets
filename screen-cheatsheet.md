# Basic Screen Command 
## Install if Screen not exists
sudo apt-get install screen

## Simple Screen Session
### Get a simple screen session started
screen 

### start some long process like download a huge file 
wget http://download.geofabrik.de/europe/estonia-latest.osm.pbf

### Detach from screen
`Crtl+A`, then type `d`

### List all the screen sessions
screen -ls

## To reattach to screen by session number 
screen -r {session_number}

## To exit when a process is done
exit

### To exit by killing session 
`Ctrl+A`, then type `K`

## Screen Session with Screen Names
### create a screen session with session name
screen -S {session_name}

### Detach from this screen session the same way
`Crtl+A`, then type `d`

### List all the screen sessions, see session listed in {session_number}.{session_name} format 
screen -ls

### reattach to a screen session with session name
screen -r {session_name}


## Screen Session with Multiple Windows
### start first screen session with name of first program
screen -S {first_program}

### start first program
{command to start first program}

### create another screen window for second program
`Ctrl+A`, then `C`

### start second program
{command to start second program}

### to hop between two windows
`Crtl+A`, then {index_of_window} (index starts from 0)

## Split Screen View on window
### Split the terminal window horizontally
`Ctrl+A`, then `Shift+S` (focus is on upper region by default)

### Split the terminal window horizontally
`Ctrl+A`, then `|`

### Switch between split regions
`Ctrl+A`, then `Tab`

### Attach an existing session to the bottom region
`Ctrl+A`, and then {index_of_window}

### Sometimes instead of attaching an existing session to the bottom region, one can also create a new screen session
`Ctrl+A`, then `C`

### Hop between regions
`Ctrl+A`

### Close all regions except the current one
`Ctrl+A`, then `Q`

### Close this region
`Ctrl+A`, then `X`

### To Detach from all session
`Ctrl+A`, then `D`

Note that window split is temporary. When we detached from screen session, it will be gone. 

## Sharing a Screen Session via SSH
### Create a named screen session (at the shared host after ssh in)
screen -d -m -S {session_name} 
-d: detached
-m: enforced creation
-S: with session name

### activate screen sharing
screen -X ssh-geek
-X: multiple screen mode

### another SSH session who also SSH into same shared host with same credential can join the shared screen session
screen -X ssh-geek

