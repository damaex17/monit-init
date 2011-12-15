# monit - this is a startscript for monit
#
# chkconfig: 2345 89 15
# description: Utility for monitoring services on a Unix system
#
# processname:  monit.
# config:       .monit.conf
# pidfile:      .monit.pid
# Short-Description: Monit is a system monitor

#Source function library
. /etc/init.d/functions

prog="monit"
user=""
option=""
pidfile=""
lockfile=""


RETVAL=0

start() {
        echo -n $"Starting $prog-$user: "
        daemon --user=$user $prog $option
        RETVAL=$?
        echo
        return $RETVAL
}

stop() {
        echo -n $"Shutting down $prog-$user: "
        killproc -p $pidfile #$prog
        RETVAL=$?
        echo
        return $RETVAL
}

restart() {
        stop
        start
}

case "$1" in
  start)
        start
        ;;
  stop)
        stop
        ;;
  restart)
        restart
        ;;
  status)
        status -p $pidfile $prog-$user
        RETVAL=$?
        ;;
  *)
        echo $"Usage: $0 {start|stop|restart|status}"
        RETVAL=1
esac

exit $RETVAL
