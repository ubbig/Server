#!/bin/bash

set -a

# docker-compose-params.env
#
# All variables from docker-compose-params.env are exported as environment variables and override default values defined in this file.
# Exported values will be used for variables substitution in docker-compose.yml.
# These environment variables WON'T be propagated inside docker containers to Upsource services.
# Please define variables in upsource.env file if they should be propagated as environment variables inside docker containers.
[[ -e "./docker-compose-params.env" ]] && . docker-compose-params.env && echo "Loading environment variables from docker-compose-params.env..."

set +a

export UPSOURCE_VERSION=${UPSOURCE_VERSION:-"2020.1.1956"}
export UPSOURCE_BACKUPS_PATH_ON_HOST_SYSTEM=${UPSOURCE_BACKUPS_PATH_ON_HOST_SYSTEM:-"/opt/upsource/backups"}
export UPSOURCE_SUBNET=${UPSOURCE_SUBNET:-"10.0.9.0/24"}
export UPSOURCE_EXPOSED_PROXY_PORT=${UPSOURCE_EXPOSED_PROXY_PORT:-"8080"}
export UPSOURCE_IMAGES_PREFIX=${UPSOURCE_IMAGES_PREFIX:-""}
export UPSOURCE_MONITORING_LISTEN_PORT=${UPSOURCE_MONITORING_LISTEN_PORT:-"10080"}
export UPSOURCE_PSI_BROKER_LISTEN_PORT=${UPSOURCE_PSI_BROKER_LISTEN_PORT:-"10090"}
export UPSOURCE_ANALYZER_XMX=${UPSOURCE_ANALYZER_XMX:-"-Xmx7168m"}
export UPSOURCE_FRONTEND_XMX=${UPSOURCE_FRONTEND_XMX:-"-Xmx3072m"}
export UPSOURCE_OPSCENTER_XMX=${UPSOURCE_OPSCENTER_XMX:-"-Xmx3072m"}
export UPSOURCE_PSI_BROKER_XMX=${UPSOURCE_PSI_BROKER_XMX:-"-Xmx1024m"}
export UPSOURCE_PSI_AGENT_XMX=${UPSOURCE_PSI_AGENT_XMX:-"-Xmx7168m"}
export UPSOURCE_FILE_CLUSTERING_XMX=${UPSOURCE_FILE_CLUSTERING_XMX:-"-Xmx2048m"}
export UPSOURCE_CLUSTER_INIT_XMX=${UPSOURCE_CLUSTER_INIT_XMX:-"-Xmx1024m"}
export UPSOURCE_NET_NAME=${UPSOURCE_NET_NAME:-"upsource-net"}

# Check that upsource.env exists and defines all required properties (non-empty values)
function check_variables_are_set {
  file=$1;
  shift;
  for var in "$@"
  do
    if [[ -z ${!var} ]]; then echo "ERROR: $var is not set in $file"; exit -1; fi
  done
}

# parse command line and find '-H <host:port>', resolved value (if any) is set to variable 'dockerEngineHost'
function set_docker_host {
  dockerEngineHost="";
  for var in "$@"
  do
    if [[ ${dockerEngineHost} == "-H" ]]; then dockerEngineHost="-H ${var}" && echo "Docker engine address is ${dockerEngineHost}" && return 0; fi
    if [[ ${var} == "-H" ]]; then dockerEngineHost="-H"; fi
  done
  [[ ${dockerEngineHost} == "" ]] && echo "WARNING: Swarm master address is not specified with parameter -H, docker-compose will execute the command locally"
  return 0;
}

# print help
function print_help {
    echo >&2 "Available commands:"
    echo >&2 "1) help "
    echo >&2 "     prints this help message"
    echo >&2 ""
    echo >&2 "2) init-cluster [-H <swarm_master_host>:<swarm_master_port>]"
    echo >&2 "     initializes the cluster on first start, does nothing on subsequent starts"
    echo >&2 ""
    echo >&2 "3) upgrade-cluster [-H <swarm_master_host>:<swarm_master_port>]"
    echo >&2 "     performs a major upgrade of the cluster from backup"
    echo >&2 ""
    echo >&2 "3) docker-compose is executed with given arguments in all other cases"
    return 0;
}

function create_upsource_net {
  local _upsource_network=`docker $1 network inspect --format={{.Name}} ${UPSOURCE_NET_NAME} 2>/dev/null`
  if [[ "${_upsource_network}" != "${UPSOURCE_NET_NAME}" ]]; then
    if [[ "$1" == "" ]]; then
      echo "Creating network ${UPSOURCE_NET_NAME}..."
      docker network create --subnet=${UPSOURCE_SUBNET} ${UPSOURCE_NET_NAME};
    else
      echo "Creating overlay network ${UPSOURCE_NET_NAME}..."
      docker $1 network create --driver overlay --subnet=${UPSOURCE_SUBNET} ${UPSOURCE_NET_NAME}
    fi
  fi
  return 0;
}

set_docker_host $@

# Check that required docker-compose configuration parameters are defined
[[ "${dockerEngineHost}" != "" ]] && check_variables_are_set "docker-compose-params.env" UPSOURCE_CASSANDRA_NODE UPSOURCE_OPSCENTER_NODE UPSOURCE_PROXY_NODE

# Import upsource.env properties and validate them
[[ ! -e "./upsource.env" ]] && echo "Required file upsource.env is missing..." && exit -1
. upsource.env
check_variables_are_set "upsource.env" UPSOURCE_URL UPSOURCE_SERVICE_ID UPSOURCE_SERVICE_SECRET \
CASSANDRA_HOSTS CASSANDRA_NATIVE_TRANSPORT_PORT HUB_URL UPSOURCE_SERVICE_MESSAGING_PORT

case "$1" in
    help)
        print_help
        ;;
    init-cluster)
        [[ "$2" != "" && "$2" != "-H" ]] && echo "ERROR: Incorrect install-cluster command format!" && print_help && exit 1
        check_variables_are_set "docker-compose-params.env" UPSOURCE_CLUSTER_INIT_NODE
        create_upsource_net "${dockerEngineHost}"
        exec docker-compose ${dockerEngineHost} -f docker-compose.yml -f docker-compose-cluster-init.yml up cassandra &
        docker-compose ${dockerEngineHost} -f docker-compose.yml -f docker-compose-cluster-init.yml up cluster-init
        docker-compose ${dockerEngineHost} -f docker-compose.yml -f docker-compose-cluster-init.yml stop cluster-init
        docker-compose ${dockerEngineHost} -f docker-compose.yml -f docker-compose-cluster-init.yml stop cassandra
        ;;
    upgrade-cluster)
        [[ "$2" != "" && "$2" != "-H" ]] && echo "ERROR: Incorrect upgrade-cluster command format!" && print_help && exit 1
        check_variables_are_set "docker-compose-params.env" UPSOURCE_CLUSTER_INIT_NODE UPSOURCE_UPGRADE_SOURCE_BACKUP_DIRECTORY
        # upgrade cluster from backup
        docker-compose ${dockerEngineHost} -f docker-compose.yml -f docker-compose-cluster-init.yml -f docker-compose-cluster-upgrade.yml down
        create_upsource_net "${dockerEngineHost}"
        exec docker-compose ${dockerEngineHost} -f docker-compose.yml -f docker-compose-cluster-init.yml -f docker-compose-cluster-upgrade.yml up cassandra &
        docker-compose ${dockerEngineHost} -f docker-compose.yml -f docker-compose-cluster-init.yml -f docker-compose-cluster-upgrade.yml up cluster-init
        docker-compose ${dockerEngineHost} -f docker-compose.yml -f docker-compose-cluster-init.yml -f docker-compose-cluster-upgrade.yml stop cluster-init
        docker-compose ${dockerEngineHost} -f docker-compose.yml -f docker-compose-cluster-init.yml -f docker-compose-cluster-upgrade.yml stop cassandra
        ;;
    *)
        create_upsource_net "${dockerEngineHost}"
        exec docker-compose $@
        ;;
esac