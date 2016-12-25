#!/bin/bash

INPUT='Tests/semanticmerge-swift-parserTests/SampleSwiftFiles/ComplexSample.swiftsample'
OUTPUT="$(mktemp)"
FLAG_FILE="$(mktemp)"

./.build/debug/semanticmerge-swift-parser shell ${FLAG_FILE} <<EOF
${INPUT}
${OUTPUT}
end
EOF