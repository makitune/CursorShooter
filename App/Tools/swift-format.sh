#!/usr/bin/env bash

set -eu

cd $(
    cd $(dirname $0)
    pwd
)

if [ ! -f ".build/release/swift-format" ]; then
    swift build -c release --product swift-format
fi

.build/release/swift-format lint -r --configuration .swift-format ../CursorShooter/
