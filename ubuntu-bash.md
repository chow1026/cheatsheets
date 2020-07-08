# Ubuntu Cheatsheet

## SSH as root/power user
SSH via private cert
`ssh -i "ssh_tunnel.pem" ubuntu@{host}`

`ssh -i "ssh_tunnel.pem" root@{host}`

## User Management
### Add User
#### add user
Type `sudo adduser {username}`. 
Follow prompt to set password, name etc. 

#### assign sudo power
If user needs sudo power, type `sudo usermod -aG sudo {username}`. 

#### test sudo power
Morph into the new user, `su - {username}`. 
Try `sudo apt update`, to see if `sudo` works for this user. 

### Setup SSH
`su - {username}`
#### set up authorized_keys for future SSH without going through ubuntu
create `.ssh` directory by `mkdir -p /home/{username}/.ssh`
create/edit `authorized_keys` by `nano /home/{username}/.ssh/authorized_keys` and paste in user's public key.  

#### make sure permissions are set correctly
sudo chmod 700 /home/{username}/.ssh
sudo chmod 644 /home/{username}/.ssh/authorized_keys
sudo chown -R {username}:{username} /home/{username}/

#### Test SSH set up
Logout and SSH using user's private key
`ssh -i "~/{username}/.ssh/private_key" {username}@{host}`
