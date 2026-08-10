#!/usr/bin/bash
ls -l --color | gawk '{ print$9 }'
