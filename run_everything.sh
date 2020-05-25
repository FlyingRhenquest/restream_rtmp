#!/bin/bash
#  Copyright 2020 Bruce Ide
#
#  Licensed under the Apache License, Version 2.0 (the "License");
#  you may not use this file except in compliance with the License.
#  You may obtain a copy of the License at
#
#      http://www.apache.org/licenses/LICENSE-2.0
#
#  Unless required by applicable law or agreed to in writing, software
#  distributed under the License is distributed on an "AS IS" BASIS,
#  WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
#  See the License for the specific language governing permissions and
#  limitations under the License.

echo "Setting up /tmp directories stream and doc"
mkdir -p /tmp/stream
mkdir -p /tmp/doc
echo "Installing dash.js in /tmp/doc"
if [ ! -f /tmp/doc/dash.js ] ; then
    curl http://cdn.dashjs.org/latest/dash.all.min.js > /tmp/doc/dash.js
fi
echo "Installing index in /tmp/doc"
echo "Access from nginx with http://127.0.0.1:8080 once ffmpeg starts, below."
cp index.html /tmp/doc
echo "Running nginx with sudo and local config file"
sudo nginx -c `pwd`/nginx.conf
echo "Running ffmpeg to generate test stream"
./start_streams.sh
