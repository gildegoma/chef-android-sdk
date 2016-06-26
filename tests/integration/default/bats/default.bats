#!/usr/bin/env bats

@test "Check that the android is available" {
    command -v android
}

@test "Check that the adb is available" {
    command -v adb
}
