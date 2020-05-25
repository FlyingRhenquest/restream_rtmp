# Restream RTMP

Here we go again. I'm putting together another streaming example, this
one is for restreaming a RTMP stream using ffmpeg and nginx. As this
one is accepting a H264 RTMP stream and outputting DASH h264 there
probably aren't any browsers that will play it as HTML5 tags. dash.js
should work, though, the run_everything.sh script will download that
and place it in an html directory along with an index.html. You should
still be able to clip images from the canvas with Javascript as the
webm_streaming example does, but I'm not going to implement that at
the moment. I just want to investigate the streaming side of
things. You can set up HLS steaming too (for Apple products,) but I'm
not gonna.

I'll be using the testsrc plugin to output a test video stream with
ffmpeg as I did in my webm_streaing example, but you can replace that
service with anything that outputs to rtmp, as long as it's pointing
to the publish port on the nginx server.

# Environment

I'm writing this on Ubuntu 18, but any fairly recent linux
distribution should work as long as you can apt install some version
of nginx and libnginx-mod-rtmp.  Other than that you'll need ffmpeg,
which you can either build yourself or install via your distribution's
installer. This might even work on Windows with the ffmpeg binary you
can get from that one guy.

Oh, you'll want curl, too. That gets used to grab and install dash.js
in the run_everything script.

# Running

run_everything.sh runs everything. It uses sudo to run nginx, which
isn't great from a security perspective, but this isn't a production
build either. You can sudo killall nginx when it's done running.

# Playback

Try accessing http://127.0.0.1:8080 in your browser. The bundled
index.html will load dash.js and try to play the video. YMMV
extensively depending on your browser and what video codecs it
supports. I can't vouch for how good of a player dash.js is.

You can also vlc http://127.0.0.1:8080/stream/stream_1/index.mpd

Or try ffplay http://127.0.0.1:8080/stream/stream_1/index.mpd but
again, your mileage may vary extensively.

# Discussion

So why, given how badly this sucks, would you do this rather than the
previous webm solution? Well for one thing, the previous webm solution
uses ffserver, which is deprecated in later versions of ffmpeg. So if
you want to get away from ffserver, this is an option.

Second, the webm encoding never quite worked in real time. h264 is
much better optimized, if you can find a browser that supports it
reasonably well. I should mention that it's not a free codec as webm
is, either, but that seems to be the choice today.  Use a non-free
codec that can actually do real-time streaming or use a slow codec
that may not be able to keep up with real time encoding on your
system.

You could also embed a video widget in a native app, if
you're so inclined.  That might actually be a better option than
either of the above, if you only ever target one platform anyway.

You might have better luck with HLS, if you work on a platform
that supports it. It may also be possible to configure this
to output a webm stream.