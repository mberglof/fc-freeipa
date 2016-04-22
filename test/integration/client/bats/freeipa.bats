#!/usr/bin/env bats

@test "id -u client returns uid from ipa server" {
  ID="$(id -u client)"
  [ "$ID" -ge 5000 ]
}
