#!/bin/sh

# Add all private ssh keys to the ssh-agent
grep -slR "PRIVATE" ~/.ssh | xargs ssh-add -q &> /dev/null
