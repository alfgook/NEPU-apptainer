##################################################
#       CREATE USERDIR FOR PIPELINE 
##################################################

# create user and their home directory
useradd "$username" 
echo "$username:$password" | chpasswd
mkdir "/home/$username"

# enable new ssh connection without authenticity warning
mkdir "/home/$username/.ssh"
chmod 700 "/home/$username/.ssh"
echo "StrictHostKeyChecking=accept-new" >> "/home/$username/.ssh/config"
chmod 400 "/home/$username/.ssh/config"

# enable password-less ssh within the container
ssh-keygen -t rsa -N "" -f "/home/$username/.ssh/id_rsa"
cat "/home/$username/.ssh/id_rsa.pub" >> "/home/$username/.ssh/authorized_keys" 
chmod 600 "/home/$username/.ssh/id_rsa.pub"
chmod 600 "/home/$username/.ssh/authorized_keys"
