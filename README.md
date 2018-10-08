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

- **[<code>POST</code> /rooms](#POST-rooms)**
- **[<code>GET</code> /rooms/search](#POST-roomssearch)**
- **[<code>GET</code> /rooms/:room_id/questions](#GET-roomsroom_idquestions)**
- **[<code>POST</code> /rooms/:room_id/questions](#POST-roomsroom_idquestions)**
- **[<code>PATCH</code> /rooms/:room_id/questions/:id](#PATCH-roomsroom_idquestionsid)**
- **[<code>DELETE</code> /rooms/:room_id/questions/:id](#DELETE-roomsroom_idquestionsid)**

### POST /rooms


### POST /rooms/search


### GET /rooms/:room_id/questions


### POST /rooms/:room_id/questions


### PATCH /rooms/:room_id/questions/:id


### DELETE /rooms/:room_id/questions/:id
