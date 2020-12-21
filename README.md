# tap2xunit

![Build Status](https://github.com/endemics/tap2xunit/workflows/lint%20and%20test/badge.svg)

tap2xunit is a shell script to convert [tap](https://testanything.org/tap-specification.html) outputs to Xunit format.

This is for instance useful if you are running [bats](https://github.com/bats-core/bats-core) tests and want the output to be converted to a format automatically supported by [Bitbucket Pipelines](https://confluence.atlassian.com/bitbucket/test-reporting-in-pipelines-939708543.html), which was the reason why I needed this in the first place.

Yes I am well aware that other projects already exists such as [tap-xunit](https://github.com/aghassemi/tap-xunit), but I wanted something that would be easy to ship in my CI agent, and well.. I already had bash and no node.

## Usage

To convert TAP to Xunit, redirect the TAP output to tap2xunit. By default the XML Xunit output will be rendered on stdout by you can either redirect it to a file using shell redirection (e.g, `>`) or via the `-o` option (see below).


`tap2xunit [-n <test-names> ] [-o <outputfile>] [-t]`

- `-n`: allows you to change the name of the test suite from `test` (the default) to the value you specify after the `-n` switch,
- `-o`: a path to an output file. NOTE: any directories in the path provided must have be created beforehand.
- `-t`, in conjunction with `-o`, this allows to 'tee' the TAP output to stdout and the XML xunit output as a file

## Installation

Besides bash (>= v3), tap2xunit requires sed and grep which have a good chance to already be installed on your system...

Copy the tap2xunit in your PATH and you should be set!

## Contributing

### Reporting bugs

Please use GitHub issue tracker for any bugs or feature suggestions:

https://github.com/endemics/tap2xunit/issues

### Contributing

Contributions such as patches to the code, tests or documentation are welcome and can be submitted via GitHub pull requests.

Please follow instructions in the [Github Flow](https://guides.github.com/introduction/flow/) page if you are new to this!

## Copyright

tap2xunit is licensed under the MIT License. A copy of this license is included in the file LICENSE.

Copyright 2020, Gildas Le Nadan.
