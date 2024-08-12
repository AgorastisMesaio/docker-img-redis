#!/usr/bin/env bash

# Test Redis
export ERR_MSG="Testing Redis with redis-cli"
redis-cli --raw incr ping > /dev/null 2>&1 || { ret=${?}; echo " - ${ERR_MSG}, return code: ${ret}"; exit ${ret}; }
echo " Ok."

# All passed
exit 0
