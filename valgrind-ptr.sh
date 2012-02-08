#!/bin/sh

valgrind --tool=exp-ptrcheck --error-exitcode=1 "$@"
