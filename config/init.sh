#!/usr/bin/env bash
# Script to be injected in the default redis container.
#
# The standard Redis container reports the following warning in the logs:
# WARNING overcommit_memory is set to 0! Background save may fail under low memory condition.
#
# To fix this we need to add 'vm.overcommit_memory = 1' to /etc/sysctl.conf and then reboot
# or run the command 'sysctl vm.overcommit_memory=1' for this to take effect.
#
# The overcommit_memory has 3 options.
# 0, the system kernel check if there is enough memory to be allocated to the process or not,
# if not enough, it will return errors to the process.
# 1, the system kernel is allowed to allocate the whole memory to the process
# no matter what the status of memory is.
# 2, the system kernel is allowed to allocate a memory whose size could be bigger than
# the sum of the size of physical memory and the size of exchange workspace to the process.
#
# Recommendation is to use 1, and we'll do it live with sysctl before launching redis
sysctl vm.overcommit_memory=1

# Start redis server
redis-stack-server --save 20 1 --loglevel warning --protected-mode no
