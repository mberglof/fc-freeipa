#!/usr/bin/env bats

@test "oddjobd is enabled" {
  chkconfig --list oddjobd | grep 3:on
  [ "$?" -eq 0 ]
}

@test "oddjobd is running" {
  sudo service oddjobd status
  [ "$?" -eq 0 ]
}
