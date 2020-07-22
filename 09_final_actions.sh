##################################################
#       FINAL ACTIONS
##################################################

# make the user owner of their home directory
echo Setting ownership of files in user home directory...
chown -R "$username:$username" "/home/$username"
# make the user owner of the installation files
echo Setting ownership of installation files...
chown -R "$username:$username" "$instpath"

# set bash as default shell for the user
chsh --shell /bin/bash "$username"

# map the user in the container to some external user
sed -i "s/^$username:x:[0-9]\+:[0-9]\+/$username:x:$extUID:$extGID/" /etc/passwd
