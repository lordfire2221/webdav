FROM rockylinux:9.3
RUN yum -y update 
RUN yum install -y nginx httpd-tools 
RUN yum clean all
# Créer le répertoire pour WebDAV et ajuster les permissions
RUN mkdir -p /var/www/webdav 
RUN chown -R nginx:nginx /var/www/webdav && \
RUN chmod -R 755 /var/www/webdav

COPY ./conf/nginx.conf /etc/nginx/nginx.conf
COPY ./conf/entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh

WORKDIR /var/www/webdav

ENTRYPOINT ["/entrypoint.sh"]
CMD ["nginx", "-g", "daemon off;"]
