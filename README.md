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
- **[<code>GET</code> /rooms/search](#get-roomssearch)**
- **[<code>GET</code> /rooms/:room_id/questions](#get-roomsroom_idquestions)**
- **[<code>POST</code> /rooms/:room_id/questions](#post-roomsroom_idquestions)**
- **[<code>PATCH</code> /rooms/:room_id/questions/:id](#patch-roomsroom_idquestionsid)**
- **[<code>DELETE</code> /rooms/:room_id/questions/:id](#delete-roomsroom_idquestionsid)**

### POST /rooms

If there is space, create a room.

#### Parameters

| Name          | Description             |
| ------------- | ----------------------- |
| title         | A title of the room     |

#### Exception

`503 Service Unavailable`: if there is no space for create a room.

#### Example

```
$ curl -X POST localhost:3000/rooms -d "title=Math" | jq
{
  "name": "111",
  "id": 1,
  "title": "Math",
  "status": 1,
  "created_at": "2018-10-08T16:20:13.666Z",
  "updated_at": "2018-10-08T16:20:26.529Z"
}
```

### GET /rooms/:room_id/questions

Display a list of questions in a specific room.

#### Example

```
$ curl -X GET localhost:3000/rooms/1/quiestions | jq
[
  {
    "id": 1,
    "text": "1+1=",
    "answer": "2",
    "room_id": 1,
    "created_at": "2018-10-08T16:20:13.666Z",
    "updated_at": "2018-10-08T16:20:26.529Z"
  },
  {
    "id": 2,
    "text": "2+2=",
    "answer": "4",
    "room_id": 1,
    "created_at": "2018-10-08T16:20:13.666Z",
    "updated_at": "2018-10-08T16:20:26.529Z"
  },
  {
    "id": 3,
    "text": "3+3=",
    "answer": "6",
    "room_id": 1,
    "created_at": "2018-10-08T16:20:13.666Z",
    "updated_at": "2018-10-08T16:20:26.529Z"
  }
]
```


### POST /rooms/:room_id/questions

Submit a question in a specific room.

#### Parameters

| Name          | Description                       |
| ------------- | --------------------------------- |
| text          | A sentence of the question        |
| answer        | The answer of the quiestion       |
| question_type | Type of question e.g. '文章問題', '計算問題' |

#### Example

```
$ curl -X POST localhost:3000/rooms/1/questions -d "text=4+4=&answer=8&question_type=計算問題" | jq
{
  "id": 4,
  "text": "4+4=",
  "answer": "8",
  "room_id": 1,
  "created_at": "2018-10-08T16:20:13.666Z",
  "updated_at": "2018-10-08T16:20:26.529Z"
}
```


### PATCH /rooms/:room_id/questions/:id

Update a specific question in a specific room.

#### Parameters

| Name          | Description                       |
| ------------- | --------------------------------- |
| text          | A sentence of the question        |
| answer        | The answer of the quiestion       |

#### Example

```
$ curl -X POST localhost:3000/rooms/1/questions/1 -d "text=5+5=&answer=10" | jq
{
  "id": 1,
  "text": "5+5=",
  "answer": "10",
  "room_id": 1,
  "created_at": "2018-10-08T16:20:13.666Z",
  "updated_at": "2018-10-08T16:20:26.529Z"
}
```


### DELETE /rooms/:room_id/questions/:id

Remove a specific question in a specific room.

#### Example

```
$ curl -X POST localhost:3000/rooms/1/questions/1 | jq
{
  "id": 1,
  "text": "5+5=",
  "answer": "10",
  "room_id": 1,
  "created_at": "2018-10-08T16:20:13.666Z",
  "updated_at": "2018-10-08T16:20:26.529Z"
}
```
