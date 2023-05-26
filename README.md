# Webserv

## Table of contents
* [Goal](#Goal)  
* [Requirements](#Requirements)
* [Ressources](#Ressources)

## Goal
> Code a `HTTP server in C++ 98`

![SERVER_HTTP](https://github.com/Abensett/23.-Webserv/assets/85625233/2c98a3d3-0086-44a6-abd0-2f793bf86a14)

## Requirements
### Server
 - [x] Configuration file as argument
 - [x] Server must `never block` and the client can be bounced properly if necessary
 - [x] Epoll
 - [x] `NGINX` is HTTP 1.1
 - [x] Accurate HTTP response `status codes`
 - [x] `Common Gateway Interface` : php
 - [x] File `uploads`
 - [x] `GET POST DELETE `
 - [x] Serve a fully static Website 
 - [x] `Resilience` : must stay available at all cost

### Configuration file
 - [x] Port and host of each ’server’
 - [x] Setup the server_names or not.
 - [x] Default error pages
 - [x] `Limit client body size`
 - [x] HTTP `redirection`
 - [x] Set up routes with one or multiple of the rules (cf Subject)
 

## Bonus
 - [x] Multiple CGI : Python
 - [x] `Cookies & Session Management`



## 42 Project 125/100


This project was done with [Charles M.](https://github.com/cmariot/) and [Francesco L.](https://github.com/KLM687)  

[![Compilation test](https://github.com/cmariot/webserv/actions/workflows/c-cpp.yml/badge.svg)](https://github.com/cmariot/webserv/actions/workflows/c-cpp.yml)

## Resources

### RFC
* [RFC 9112 actuellement la RFC standard](https://www.rfc-editor.org/rfc/rfc9110.html#name-get)
* [RFC 7230](http://www.rfc-editor.org/info/rfc7230)
* [RFC 7231](http://www.rfc-editor.org/info/rfc7231)
* [Guide Http server](https://medium.com/from-the-scratch/http-server-what-do-you-need-to-know-to-build-a-simple-http-server-from-scratch-d1ef8945e4fa)


### Sockets
- [Basic socket programming](https://www.geeksforgeeks.org/socket-programming-cc/)
- [Multiple clients](https://www.geeksforgeeks.org/socket-programming-in-cc-handling-multiple-clients-on-server-without-multi-threading/)

### Status codes & Methods
* [Choosing HTTP status code](https://www.codetinkerer.com/2015/12/04/choosing-an-http-status-code.html)
* [GET and POST](https://www.w3schools.com/tags/ref_httpmethods.asp)
* [DELETE](https://stackoverflow.com/questions/17884469/what-is-the-http-response-code-for-failed-http-delete-operation)
* [Response status code for POST](https://stackoverflow.com/questions/73486941/what-is-the-difference-between-201-status-code-and-204-status-code)
* [POST AND GET but better](https://www.guru99.com/difference-get-post-http.html)

### Modèle OSI & TCP/IP
- [Cookie Connecté Video claire](https://www.youtube.com/watch?v=26jazyc7VNk)
- [OSI Model Wikipedia](https://en.wikipedia.org/wiki/OSI_model)

### nc & curl to test the Server
* [Use of curl](https://reqbin.com/req/c-dot4w5a2/curl-post-file)
* [send a request avec nc ](https://www.varonis.com/fr/blog/netcat-commands)
* [send a request avec curl](https://devqa.io/curl-sending-api-requests/)

### Chunked transfer encoding
* [Chunk request tester / resilience tester](https://gist.github.com/hannesg/541935ab2e4acc55ed8b85d65defe003)
