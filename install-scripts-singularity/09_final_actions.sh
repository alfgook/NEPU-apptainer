##################################################
#       FINAL ACTIONS
##################################################

# map the user in the container to some external user
sed -i "s/^$username:x:[0-9]\+:[0-9]\+/$username:x:$extUID:$extGID/" /etc/passwd
