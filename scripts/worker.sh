#!/usr/bin/env bash

name="${1:-worker-unknown}"
exec -a "$name" bash -c 'while true; do sleep 60; done'
