#!/usr/bin/env bash

set -u

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
APP_JAR="${SCRIPT_DIR}/target/backend-0.0.1-SNAPSHOT.jar"
RUN_DIR="${SCRIPT_DIR}/run"
LOG_DIR="${SCRIPT_DIR}/logs"
PID_FILE="${RUN_DIR}/backend.pid"
OUT_LOG="${LOG_DIR}/backend.out.log"
ERR_LOG="${LOG_DIR}/backend.err.log"
SYSTEMD_SERVICE_NAME="novacloudedu-backend.service"
SYSTEMD_SERVICE_FILE="/etc/systemd/system/${SYSTEMD_SERVICE_NAME}"
SYSTEMD_ENV_FILE="/etc/default/novacloudedu-backend"
SYSTEMD_TEMPLATE_FILE="${SCRIPT_DIR}/systemd/novacloudedu-backend.service"
MVNW_FILE="${SCRIPT_DIR}/mvnw"

# JVM options can be overridden via environment variable before running script.
DEFAULT_JVM_OPTS="-server -Xms512m -Xmx1024m -XX:MetaspaceSize=128m -XX:MaxMetaspaceSize=256m -XX:+UseG1GC -XX:+HeapDumpOnOutOfMemoryError -XX:HeapDumpPath=${LOG_DIR}/heapdump.hprof -Dfile.encoding=UTF-8 -Duser.timezone=Asia/Shanghai"
JVM_OPTS="${JVM_OPTS:-${DEFAULT_JVM_OPTS}}"
SPRING_PROFILES_ACTIVE="${SPRING_PROFILES_ACTIVE:-prod}"

ensure_dirs() {
  mkdir -p "${RUN_DIR}" "${LOG_DIR}"
}

require_root() {
  if [[ ${EUID:-$(id -u)} -ne 0 ]]; then
    echo "This command requires root. Please run with sudo."
    exit 1
  fi
}

require_systemctl() {
  if ! command -v systemctl >/dev/null 2>&1; then
    echo "systemctl is not available on this machine."
    exit 1
  fi
}

package_app() {
  local package_cmd

  if [[ -x "${MVNW_FILE}" ]]; then
    package_cmd=("${MVNW_FILE}" clean package -DskipTests)
  else
    package_cmd=(mvn clean package -DskipTests)
  fi

  echo "Packaging backend..."
  (cd "${SCRIPT_DIR}" && "${package_cmd[@]}")
}

detect_service_user() {
  if [[ -n "${SUDO_USER:-}" && "${SUDO_USER}" != "root" ]]; then
    echo "${SUDO_USER}"
    return
  fi

  echo "$(id -un)"
}

is_running() {
  if [[ -f "${PID_FILE}" ]]; then
    local pid
    pid="$(cat "${PID_FILE}")"
    if [[ -n "${pid}" ]] && kill -0 "${pid}" >/dev/null 2>&1; then
      return 0
    fi
  fi
  return 1
}

start_app() {
  ensure_dirs

  if [[ ! -f "${APP_JAR}" ]]; then
    echo "JAR not found: ${APP_JAR}"
    echo "Please build first: mvn package -DskipTests"
    exit 1
  fi

  if is_running; then
    local pid
    pid="$(cat "${PID_FILE}")"
    echo "Application is already running. PID=${pid}"
    exit 0
  fi

  echo "Starting application..."
  nohup java ${JVM_OPTS} -jar "${APP_JAR}" --spring.profiles.active="${SPRING_PROFILES_ACTIVE}" >>"${OUT_LOG}" 2>>"${ERR_LOG}" &
  local pid=$!
  echo "${pid}" > "${PID_FILE}"

  sleep 1
  if kill -0 "${pid}" >/dev/null 2>&1; then
    echo "Started successfully. PID=${pid}"
    echo "Stdout log: ${OUT_LOG}"
    echo "Stderr log: ${ERR_LOG}"
  else
    echo "Failed to start. Check logs: ${OUT_LOG}, ${ERR_LOG}"
    rm -f "${PID_FILE}"
    exit 1
  fi
}

run_app() {
  ensure_dirs

  if [[ ! -f "${APP_JAR}" ]]; then
    echo "JAR not found: ${APP_JAR}"
    echo "Please build first: mvn package -DskipTests"
    exit 1
  fi

  exec java ${JVM_OPTS} -jar "${APP_JAR}" --spring.profiles.active="${SPRING_PROFILES_ACTIVE}"
}

stop_app() {
  if ! is_running; then
    echo "Application is not running."
    rm -f "${PID_FILE}"
    exit 0
  fi

  local pid
  pid="$(cat "${PID_FILE}")"

  echo "Stopping application. PID=${pid}"
  kill "${pid}" >/dev/null 2>&1 || true

  for _ in {1..20}; do
    if kill -0 "${pid}" >/dev/null 2>&1; then
      sleep 1
    else
      rm -f "${PID_FILE}"
      echo "Stopped successfully."
      return
    fi
  done

  echo "Graceful stop timeout, forcing kill."
  kill -9 "${pid}" >/dev/null 2>&1 || true
  rm -f "${PID_FILE}"
  echo "Stopped by force."
}

status_app() {
  if is_running; then
    local pid
    pid="$(cat "${PID_FILE}")"
    echo "Application is running. PID=${pid}"
    ps -fp "${pid}" || true
  else
    echo "Application is not running."
    [[ -f "${PID_FILE}" ]] && rm -f "${PID_FILE}"
    exit 1
  fi
}

logs_app() {
  ensure_dirs
  echo "Tailing logs..."
  tail -n 200 -f "${OUT_LOG}" "${ERR_LOG}"
}

service_status() {
  require_systemctl
  systemctl status "${SYSTEMD_SERVICE_NAME}" --no-pager
}

service_logs() {
  require_systemctl
  journalctl -u "${SYSTEMD_SERVICE_NAME}" -f --no-pager
}

service_rebuild_start() {
  package_app

  if [[ ! -f "${SYSTEMD_SERVICE_FILE}" ]]; then
    install_service
  fi

  require_root
  require_systemctl
  systemctl restart "${SYSTEMD_SERVICE_NAME}"
  systemctl status "${SYSTEMD_SERVICE_NAME}" --no-pager
}

service_control() {
  local action="$1"

  require_root
  require_systemctl
  systemctl "${action}" "${SYSTEMD_SERVICE_NAME}"
}

install_service() {
  require_root
  require_systemctl

  if [[ ! -f "${SYSTEMD_TEMPLATE_FILE}" ]]; then
    echo "Service template not found: ${SYSTEMD_TEMPLATE_FILE}"
    exit 1
  fi

  local service_user
  local service_group
  service_user="$(detect_service_user)"
  service_group="$(id -gn "${service_user}")"

  sed \
    -e "s|__WORKING_DIR__|${SCRIPT_DIR}|g" \
    -e "s|__SERVICE_USER__|${service_user}|g" \
    -e "s|__SERVICE_GROUP__|${service_group}|g" \
    "${SYSTEMD_TEMPLATE_FILE}" > "${SYSTEMD_SERVICE_FILE}"

  chmod 644 "${SYSTEMD_SERVICE_FILE}"
  systemctl daemon-reload
  systemctl enable "${SYSTEMD_SERVICE_NAME}"

  echo "Service installed: ${SYSTEMD_SERVICE_FILE}"
  echo "If needed, place runtime overrides in ${SYSTEMD_ENV_FILE}"
  echo "Start it with: systemctl start ${SYSTEMD_SERVICE_NAME}"
}

uninstall_service() {
  require_root
  require_systemctl

  systemctl disable --now "${SYSTEMD_SERVICE_NAME}" >/dev/null 2>&1 || true
  rm -f "${SYSTEMD_SERVICE_FILE}"
  systemctl daemon-reload

  echo "Service removed: ${SYSTEMD_SERVICE_NAME}"
  echo "Optional environment file left intact: ${SYSTEMD_ENV_FILE}"
}

print_usage() {
  cat <<'EOF'
Usage: ./manage-backend.sh {start|stop|restart|status|logs|run|service-install|service-uninstall|service-start|service-stop|service-restart|service-status|service-logs|service-rebuild-start}

Commands:
  start    Start Spring Boot app in background
  stop     Stop app by PID file
  restart  Restart app
  status   Show process status
  logs     Tail stdout and stderr logs
  run      Run Spring Boot app in foreground for systemd

Systemd commands:
  service-install    Install and enable the systemd unit
  service-uninstall  Disable and remove the systemd unit
  service-start      Start the systemd service
  service-stop       Stop the systemd service
  service-restart    Restart the systemd service
  service-status     Show the systemd service status
  service-logs       Follow the systemd journal for the service
  service-rebuild-start  Rebuild the backend JAR and restart the systemd service

Optional environment variables:
  JVM_OPTS                Override default JVM options
  SPRING_PROFILES_ACTIVE  Default: prod
EOF
}

main() {
  local cmd="${1:-}"
  case "${cmd}" in
    start)
      start_app
      ;;
    run)
      run_app
      ;;
    stop)
      stop_app
      ;;
    restart)
      stop_app
      start_app
      ;;
    status)
      status_app
      ;;
    logs)
      logs_app
      ;;
    service-install)
      install_service
      ;;
    service-uninstall)
      uninstall_service
      ;;
    service-start)
      service_control start
      ;;
    service-stop)
      service_control stop
      ;;
    service-restart)
      service_control restart
      ;;
    service-status)
      service_status
      ;;
    service-logs)
      service_logs
      ;;
    service-rebuild-start)
      service_rebuild_start
      ;;
    *)
      print_usage
      exit 1
      ;;
  esac
}

main "$@"
