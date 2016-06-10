MYSQL_DOCKER_NAME=${1:-mysql}
MYSQL_ROOT_USER=${2:-root}
MYSQL_ROOT_PASSWORD=${2:-password}
MYSQL_DATABASE=${3:-openxpki}
MYSQL_USERNAME=${4:-openxpki}
MYSQL_PASSWORD=${5:-openxpki_pwd}

docker run "-i" "--link" "$( docker ps|grep ${MYSQL_DOCKER_NAME}|awk '{ print $1 }' ):mysql" "--rm" "mariadb:10" sh -c "exec echo \"CREATE DATABASE IF NOT EXISTS ${MYSQL_DATABASE}; GRANT ALL PRIVILEGES ON ${MYSQL_DATABASE}.* TO ${MYSQL_USERNAME}@'%' IDENTIFIED BY '${MYSQL_PASSWORD}';\" |mysql --protocol=tcp -hmysql -P3306 -u${MYSQL_ROOT_USER} -p${MYSQL_ROOT_PASSWORD}"
