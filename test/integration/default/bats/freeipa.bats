#!/usr/bin/env bats

@test "id -u admin returns uid from ipa server" {
  ID="$(id -u admin)"
  [ "$ID" -ge 5000 ]
}

@test "admin can use kinit" {
  echo ipa_admin_password | kinit admin@EXAMPLE.COM
  klist
  [ "$?" -eq 0 ]
}

@test "ipa admin can add user tbats" {
  ipa user-add tbats --first=Test --last=Bats --shell=/bin/bash --cn="Test Bats" --random
  [ "$?" -eq 0 ]
}

@test "ipa admin can find user tbats" {
  ipa user-find tbats
  [ "$?" -eq 0 ]
}

@test "ipa admin can remove user tbats" {
  ipa user-del tbats
  [ "$?" -eq 0 ]
}
