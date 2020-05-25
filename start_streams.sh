#!/bin/bash
#
# Copyright 2020 Bruce Ide
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
#
# h264 ultrafast crf 0 for lossless h264

ffmpeg -f lavfi -i "testsrc=duration=6000:size=1920x1080:rate=30" \
       -f lavfi -i sine \
       -c:v h264 -preset ultrafast -crf 0 \
       -c:a aac -b:a 384k \
       -f flv rtmp://127.0.0.1:1935/stream/stream_1
