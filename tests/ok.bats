#!/usr/bin/env bats
load ${BATS_HELPERS_DIR}/bats-support/load.bash
load ${BATS_HELPERS_DIR}/bats-assert/load.bash

@test "tap file with one passed test" {
    OK_TAP="1..1
ok 1 this is test 1 description
"
    run ./tap2xunit <<< "$OK_TAP"

    assert_success
    assert_output '<?xml version="1.0"?>
<testsuites>
 <testsuite name="test" tests="1" failures="0" skipped="0" errors="0">
  <testcase name="this is test 1 description"/>
 </testsuite>
</testsuites>'
}

@test "tap file with 3 passed tests but only one output" {
    OK_TAP="1..3
ok 1 this is test 1 description
"
    run ./tap2xunit <<< "$OK_TAP"

    assert_success
    assert_output '<?xml version="1.0"?>
<testsuites>
 <testsuite name="test" tests="3" failures="0" skipped="0" errors="0">
  <testcase name="this is test 1 description"/>
 </testsuite>
</testsuites>'
}
