#!/usr/bin/env bats
setup() {
    bats_load_library bats-support
    bats_load_library bats-assert
}

@test "tap file with one skipped test, TAP 12 specs" {
    SKIPPED_OK_TAP="1..1
ok 1 this is test 1 description # skip"

    run ./tap2xunit <<< "$SKIPPED_OK_TAP"

    assert_success
    assert_output '<?xml version="1.0"?>
<testsuites>
 <testsuite name="test" tests="1" failures="0" skipped="1" errors="0">
  <testcase name="this is test 1 description">
   <skipped/>
  </testcase>
 </testsuite>
</testsuites>'
}

@test "tap file with one skipped test, TAP 12 specs with trailing space" {
    SKIPPED_OK_TAP="1..1
ok 1 this is test 1 description # skip "

    run ./tap2xunit <<< "$SKIPPED_OK_TAP"

    assert_success
    assert_output '<?xml version="1.0"?>
<testsuites>
 <testsuite name="test" tests="1" failures="0" skipped="1" errors="0">
  <testcase name="this is test 1 description">
   <skipped/>
  </testcase>
 </testsuite>
</testsuites>'
}

@test "tap file with one skipped test, TAP 12 specs with reason" {
    SKIPPED_OK_TAP="1..1
ok 1 this is test 1 description # skip reason for skipping"

    run ./tap2xunit <<< "$SKIPPED_OK_TAP"

    assert_success
    assert_output '<?xml version="1.0"?>
<testsuites>
 <testsuite name="test" tests="1" failures="0" skipped="1" errors="0">
  <testcase name="this is test 1 description">
   <skipped>reason for skipping</skipped>
  </testcase>
 </testsuite>
</testsuites>'
}

@test "tap file with one skipped test, bats reporting style" {
    SKIPPED_OK_TAP="1..1
ok 1 # skip (reason for skipping) this is test 1 description"

    run ./tap2xunit <<< "$SKIPPED_OK_TAP"

    assert_success
    assert_output '<?xml version="1.0"?>
<testsuites>
 <testsuite name="test" tests="1" failures="0" skipped="1" errors="0">
  <testcase name="this is test 1 description">
   <skipped>(reason for skipping)</skipped>
  </testcase>
 </testsuite>
</testsuites>'
}

@test "tap file with one failed skipped test, TAP 12 specs" {
    NOTOK_SKIPPED_TAP="1..1
not ok 1 this is failed test 1 description # skip"

    run ./tap2xunit <<< "$NOTOK_SKIPPED_TAP"

    assert_success
    assert_output '<?xml version="1.0"?>
<testsuites>
 <testsuite name="test" tests="1" failures="0" skipped="1" errors="0">
  <testcase name="this is failed test 1 description">
   <skipped/>
  </testcase>
 </testsuite>
</testsuites>'
}

@test "tap file with one failed skipped test, bats reporting style" {
    NOTOK_SKIPPED_TAP="1..1
not ok 1 # skip (reason for skipping) this is failed test 1 description"

    run ./tap2xunit <<< "$NOTOK_SKIPPED_TAP"

    assert_success
    assert_output '<?xml version="1.0"?>
<testsuites>
 <testsuite name="test" tests="1" failures="0" skipped="1" errors="0">
  <testcase name="this is failed test 1 description">
   <skipped>(reason for skipping)</skipped>
  </testcase>
 </testsuite>
</testsuites>'
}

@test "tap file with one failed skipped test one failed test, bats reporting style" {
    NOTOK_SKIPPED_TAP2="1..2
not ok 1 # skip (reason for skipping) this is failed test 1 description
not ok 2 this is failed test 2 description
# reason"

    run ./tap2xunit <<< "$NOTOK_SKIPPED_TAP2"

    assert_failure 1
    assert_output '<?xml version="1.0"?>
<testsuites>
 <testsuite name="test" tests="2" failures="1" skipped="1" errors="0">
  <testcase name="this is failed test 1 description">
   <skipped>(reason for skipping)</skipped>
  </testcase>
  <testcase name="this is failed test 2 description">
   <failure>
    # reason
   </failure>
  </testcase>
 </testsuite>
</testsuites>'
}
