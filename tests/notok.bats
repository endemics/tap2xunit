#!/usr/bin/env bats
load ${BATS_HELPERS_DIR}/bats-support/load.bash
load ${BATS_HELPERS_DIR}/bats-assert/load.bash

@test "tap file with one failed test, no diagnostics" {
    NOTOK_TAP="1..1
not ok 1 this is failed test 1 description"

    run ./tap2xunit <<< "$NOTOK_TAP"

    assert_failure 1
    assert_output '<?xml version="1.0"?>
<testsuites>
 <testsuite name="test" tests="1" failures="1" skipped="0" errors="0">
  <testcase name="this is failed test 1 description">
   <failure/>
  </testcase>
 </testsuite>
</testsuites>'
}

@test "tap file with one failed test" {
    NOTOK_TAP2="1..1
not ok 1 this is failed test 1 description
# failure reason
# another failure reason"

    run ./tap2xunit <<< "$NOTOK_TAP2"

    assert_failure 1
    assert_output '<?xml version="1.0"?>
<testsuites>
 <testsuite name="test" tests="1" failures="1" skipped="0" errors="0">
  <testcase name="this is failed test 1 description">
   <failure>
    # failure reason
    # another failure reason
   </failure>
  </testcase>
 </testsuite>
</testsuites>'
}

@test "tap file with one ok and one failed test" {
    NOTOK_TAP3="1..2
not ok 1 this is failed test 1 description
# failure reason
# another failure reason
ok 2 this is test 2 description"

    run ./tap2xunit <<< "$NOTOK_TAP3"
    assert_failure 1

    assert_output '<?xml version="1.0"?>
<testsuites>
 <testsuite name="test" tests="2" failures="1" skipped="0" errors="0">
  <testcase name="this is failed test 1 description">
   <failure>
    # failure reason
    # another failure reason
   </failure>
  </testcase>
  <testcase name="this is test 2 description"/>
 </testsuite>
</testsuites>'
}
