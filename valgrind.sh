#!/bin/sh

valgrind --leak-check=full --show-reachable=yes --error-exitcode=1 \
         --track-fds=yes "$@"
