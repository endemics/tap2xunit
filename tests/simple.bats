#!/usr/bin/env bats
setup() {
    bats_load_library bats-support
    bats_load_library bats-assert
}

function teardown {
    rm -f tests/file.xml
}

@test "calling with invalid argument returns usage" {
    run ./tap2xunit -x
    assert_failure 1
    assert_output --partial 'Invalid option: -x'
}

@test "non tap file returns an empty result" {
    GARBAGE="foo
bar
baz"
    run ./tap2xunit <<< "$GARBAGE"
    assert_success
    assert_output ''
}

@test "garbage resembling tap header returns and empty result" {
    run ./tap2xunit <<< "1..0 and garbage"

    assert_success
    assert_output ''
}

@test "empty tap file returns an empty result xunit output" {
    run ./tap2xunit <<< "1..0"

    assert_success
    assert_output '<?xml version="1.0"?>
<testsuites>
 <testsuite name="test" tests="0" failures="0" skipped="0" errors="0">
 </testsuite>
</testsuites>'
}

@test "-n changes test name" {
    run ./tap2xunit -n mytestname <<< "1..0"
    assert_success
    assert_line --index 2 ' <testsuite name="mytestname" tests="0" failures="0" skipped="0" errors="0">'
}

@test "-n with missing argument returns an error and usage" {
    run ./tap2xunit -n <<< "1..0"

    assert_failure 1
    assert_line --index 0 'Option -n requires an argument.'
    assert_line --index 1 --partial 'Usage: '
}

@test "-o file.xml creates a file" {
    run ./tap2xunit -o tests/file.xml <<< "1..0"

    assert_success
    assert [ -f tests/file.xml ]
    assert diff tests/file.xml tests/fixtures/empty.xml
    assert_output ''
}

@test "-t -o file.xml creates a file and outputs to stdout" {
    run ./tap2xunit -t -o tests/file.xml <<< "1..0"

    assert_success
    assert [ -f tests/file.xml ]
    assert diff tests/file.xml tests/fixtures/empty.xml
    assert_output '1..0'
}

@test "-o with missing argument returns an error and usage" {
    run ./tap2xunit -o <<< "1..0"

    assert_failure 1
    assert_line --index 0 'Option -o requires an argument.'
    assert_line --index 1 --partial 'Usage: '
}

@test "-t without -o returns an error and usage" {
    run ./tap2xunit -t <<< "1..0"

    assert_failure 1
    assert_line --index 0 'You need to set an output in order to use the -t switch.'
    assert_line --index 1 --partial 'Usage: '
}
