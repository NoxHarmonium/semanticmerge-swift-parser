Semantic Merge Swift Parser
===========================

[![Build Status](https://travis-ci.org/NoxHarmonium/semanticmerge-swift-parser.svg?branch=master)](https://travis-ci.org/NoxHarmonium/semanticmerge-swift-parser)

This is my attempt to write a custom parser for Semantic Merge so it can handle the Swift programming language.

It is a very rough prototype so please don't judge the quality of the code too much 😜. I'm in the process of testing it but I can't seem to get Semantic merge to open with languages other than Java, C# or VB.net with the trial version I have.

The output of the SourceKitten structure command does not seem to include some things that is required for Semantic merge such as comments, and the offsets do not seem to include some things like visibility modifier keywords. I will possibly have to create a custom request to SourceKit, or work out how to do it with SourceKitten.

Building
--------

There is no Xcode project associated with this repo. You can build using the Swift command line tools.

It was developed with the Xcode 8.2 SDK/command line tools.

1. Fetch the project dependencies using Swift project manager

    $ swift package fetch

2. Build the executable

    $ swift build

The executable should then be located at `.build/debug/semanticmerge-swift-parser`

External Parser Reference
-------------------------

https://users.semanticmerge.com/documentation/external-parsers/external-parsers-guide.shtml#Externalparsers


Licence
-------

This code is released under the [MIT licence](./LICENCE)
