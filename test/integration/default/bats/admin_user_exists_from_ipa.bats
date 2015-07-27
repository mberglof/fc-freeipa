#!/usr/bin/env bats

@test "admin user exist with uid 1137600000 from ipa server" {
  ID="$(id -u admin)"
  [ "$ID" -eq 1137600000 ]
}
