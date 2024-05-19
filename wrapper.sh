#!/bin/bash

Xvfb "${XVFB_DISPLAY:?}" ${XVFB_OPTIONS} & 

gunicorn app:app --bind 0.0.0.0:8000