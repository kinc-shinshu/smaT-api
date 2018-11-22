# README

An API server of smaT for [shinshu-futureapp contest](https://shinshu-futureapp.net/). This API server is running on Ruby on Rails.

## Requirements
- ruby 2.5
- gem 2.7
- bundler 1.16


## Install
```
$ bundle install --path=vendor/bundle
$ bundle exec rails db:migrate
$ bundle exec rails db:seed
```

## Teacher's API

- HOSTは`smat-api-dev.herokuapp.com`のようなAPIサーバーのホスト先URIを示す
- `params`における`*`は**空白を許さない**という意味

### GET `/v1/teachers/:teacher_id/exams`

指定した教員教員(:teacher_id)が作成した試験情報一覧を返す。
試験内の問題は含まない。

#### Params

Nothing.

#### Return

- Array of Exam's JSON
- HTTP 200

#### Example

```shell
$ curl https://HOST/v1/teachers/1/exams | jq

[
  {
    "id": 1,
    "title": "Exam0",
    "status": 0,
    "room_id": -1,
    "teacher_id": 1,
    "created_at": "2018-11-22T19:05:33.871+09:00",
    "updated_at": "2018-11-22T19:05:33.871+09:00",
    "description": null
  },
  {
    "id": 2,
    "title": "Exam1",
    "status": 0,
    "room_id": -1,
    "teacher_id": 1,
    "created_at": "2018-11-22T19:05:33.877+09:00",
    "updated_at": "2018-11-22T19:05:33.877+09:00",
    "description": null
  },
  ...
```

### POST `/v1/teachers/:teacher_id/exams`

指定した教員に新しく試験を作成する。

#### Params

| Name        | Type    |
| ----------- | ------- |
| title       | String* |
| description | String  |

#### Return

##### params is valid

- single Exam's JSON created by params
- HTTP 201

##### params is invalid

- `Validation failed` message
- HTTP 400

#### Example

```shell
# valid request
$ curl -X POST -H 'Content-Type: application/json' https://HOST/v1/teachers/1/exams -d '{"title": "Temp Exam", "description": "For write document"}' | jq

{
  "id": 13,
  "title": "Temp Exam",
  "status": 0,
  "room_id": -1,
  "teacher_id": 1,
  "created_at": "2018-11-22T20:49:56.802+09:00",
  "updated_at": "2018-11-22T20:49:56.802+09:00",
  "description": "For write document"
}

# invalid request
$ curl -X POST -H 'Content-Type: application/json' https://HOST/v1/teachers/1/exams -d '{"title": "", "description": ""}'

{
  "message":"Validation failed: Title can't be blank"
}
```

### GET `/v1/exams/:exam_id/questions`

指定した試験(:exam_id)の問題情報一覧を返す。

#### Params

Nothing.

#### Return

##### Exam exists

- Array of Question's JSON
- HTTP 200

##### Exam doesn't exists

- `Couldn't find Exam` message
- HTTP 400

#### Example

```shell
# Exam exists
$ curl https://HOST/v1/exams/1/questions | jq

[
  {
    "id": 2,
    "question_type": "Math",
    "ans_smatex": "+-2",
    "exam_id": 1,
    "created_at": "2018-11-22T19:05:33.967+09:00",
    "updated_at": "2018-11-22T19:05:33.967+09:00",
    "latex": "\\sqrt{4}",
    "smatex": "#{4}",
    "ans_latex": "+-2"
  },
  {
    "id": 3,
    "question_type": "Math",
    "ans_smatex": "3025",
    "exam_id": 1,
    "created_at": "2018-11-22T19:05:33.972+09:00",
    "updated_at": "2018-11-22T19:05:33.972+09:00",
    "latex": "55^2",
    "smatex": "55^2",
    "ans_latex": "3025"
  },
  ...

# Exam doesn't exists
$ curl https://HOST/v1/exams/0/questions | jq

{
  "message": "Couldn't find Exam with 'id'=0"
}
```

### POST `/v1/exams/:exam_id/questions`

### GET `/v1/questions/:id`

### PATCH/PUT `/v1/questions/:id`

### PATCH/PUT `/v1/exams/:id`

### POST `/v1/exams/:id/open`

### POST `/v1/exams/:id/close`

### GET `/v1/exmas/:exam_id/results`

### GET `/v1/questions/:question_id/results`

### GET `/v1/teachers/:id`

### POST `/v1/teachers/`

### POST `/v1/auth/teacher/login`


## Student's API

### GET `/v1/rooms/:room_id/questions`

### GET `/v1/rooms/:room_id/questions/:id`

### GET `/v1/states/:student_id`

### POST `/v1/states/:student_id`

### POST `/v1/states/:student_id/finish` _under development_

### POST `/v1/results` _under development_

## Generate request spec

```
$ bundle exec rails g rspec:integration NAME
```

## Run specs

```
$ bundle exec rspec
```
