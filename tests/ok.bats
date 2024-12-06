#!/usr/bin/env bats
setup() {
    bats_load_library bats-support
    bats_load_library bats-assert
}

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
