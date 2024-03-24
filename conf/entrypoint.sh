#!/bin/sh -e

# Vérifiez et créez le fichier htpasswd si les variables sont définies
if [ -n "${WEBDAV_USERNAME:-}" ] && [ -n "${WEBDAV_PASSWORD:-}" ]; then
    htpasswd -cb /etc/nginx/webdavpasswd "${WEBDAV_USERNAME}" "${WEBDAV_PASSWORD}"
else
    echo "No WebDAV authentication configured."
fi

# Assurez-vous que Nginx peut écrire dans le fichier de log et le répertoire temporaire
mkdir -p /var/www/webdav/.tmp
chown -R nginx:nginx /var/www/webdav /var/log/nginx

# Exécutez le processus principal de Nginx en arrière-plan
exec nginx -g 'daemon off;'
