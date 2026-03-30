#!/bin/bash

find $1 -depth -type f -exec shred -uvfzn 35 {} + -o -type d -exec rm -rf {} +
