# README

An API server of smaT for [shinshu-futureapp contest](https://shinshu-futureapp.net/). This API server is running on Ruby on Rails.

## Requirements
- ruby 2.5
- gem 2.7
- bundler 1.16

## Install
```
$ bundle install
$ rails db:migrate
$ rails db:seed
```

## Endpoints

- **[<code>POST</code> /rooms](#post-rooms)**
- **[<code>GET</code> /rooms/search](#post-roomssearch)**
- **[<code>GET</code> /rooms/:room_id/questions](#get-roomsroom_idquestions)**
- **[<code>POST</code> /rooms/:room_id/questions](#post-roomsroom_idquestions)**
- **[<code>PATCH</code> /rooms/:room_id/questions/:id](#patch-roomsroom_idquestionsid)**
- **[<code>DELETE</code> /rooms/:room_id/questions/:id](#delete-roomsroom_idquestionsid)**

### POST /rooms


### POST /rooms/search


### GET /rooms/:room_id/questions


### POST /rooms/:room_id/questions


### PATCH /rooms/:room_id/questions/:id


### DELETE /rooms/:room_id/questions/:id
