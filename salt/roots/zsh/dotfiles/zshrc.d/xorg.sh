#!/bin/bash

# $ xxclip FILE -- Copy FILE content to clipboard
alias xxclip='f(){ cat "$1" | xclip -in -sel clip ;};f'
