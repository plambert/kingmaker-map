kingmaker-map
=============

An interactive map for kingmaker, using ruby, sinatra, html, and javascript

Translated and modified from the original here: https://github.com/sirbotta/kingmaker-map

To build the Docker image:

`docker build . -t kingmaker`

To run in Docker:

`docker run -it -p 4567:4567 kingmaker:latest`

To run headless in Docker:

`docker run -p 4567:4567  kingmaker:latest`

I've removed the web-based editing, and removed the default sinatra caching, so it will refresh quickly.

To update the map, edit the `app.rb` and redeploy

