#!/usr/bin/env bats

@test "oddjobd is enabled" {
  [ -e /etc/redhat-release ] && VERSION=$(egrep -o "[[:digit:]]" /etc/redhat-release) || exit 1

  MAJOR=$(echo $VERSION | awk '{print $1}')
  case $MAJOR in
    6|5)
      chkconfig --list oddjobd | grep 3:on
    ;;
    7)
      systemctl is-enabled oddjobd
    ;;
  esac

  [ "$?" -eq 0 ]
}

@test "oddjobd is running" {
  sudo service oddjobd status
  [ "$?" -eq 0 ]
}
