{
#run.sh file
print "\n/usr/local/bin/certbot-auto certonly --standalone --expand --domains "$2" --agree-tos --email "$1" --no-eff-email --keep >> /var/log/docker_log/certbot_log">>"run.sh"
print "sleep 10">>"run.sh"
}
