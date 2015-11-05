java -jar /opt/gitbucket/gitbucket.war --gitbucket.home=/opt/gitbucket >> /var/log/gitbucket.log 2>&1 &
/usr/sbin/nginx -g "daemon off;"
