{
#run.sh file
print "\ncertbot certonly --standalone --domains "$2" --agree-tos --email "$1" --no-eff-email --keep >> /var/log/docker_log/certbot_log">>"run.sh"

#wait_script.sh
print "sleep 10">>"wait_script.sh"
}
