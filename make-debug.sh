#!/bin/sh

set -e

js="main.js"

elm make --output=$js src/Main.elm
