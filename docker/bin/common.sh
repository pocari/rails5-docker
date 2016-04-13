SCRIPT_DIR=$(cd $(dirname $0) && pwd)
export APP_ROOT_DIR=$(dirname $(dirname $SCRIPT_DIR))/app/rails
export DB_DOCKERFILE_DIR=${SCRIPT_DIR}/../containers/db
export WEBAPP_DOCKERFILE_DIR=${SCRIPT_DIR}/../containers/webapp
export DOCKER_COMMAND=docker

echo APP_ROOT_DIR = ${APP_ROOT_DIR}
echo DB_DOCKERFILE_DIR = ${DB_DOCKERFILE_DIR}
echo WEBAPP_DOCKERFILE_DIR = ${WEBAPP_DOCKERFILE_DIR}
