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

## Generate request spec

```
$ bundle exec rails g rspec:integration NAME
```

## Run specs

```
$ bundle exec rspec
```

## Teacher's API

- HOSTは`smat-api-dev.herokuapp.com`のようなAPIサーバーのホスト先URIを示す
- `params`における`*`は**空白を許さない**という意味

### GET `/v1/teachers/:teacher_id/exams`

指定した教員教員(:teacher_id)が作成した試験情報一覧を返す。
試験内の問題は含まない。

#### Params

Nothing.

#### Returns

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

#### Returns

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

_INFO: `description` accepts empty_

### GET `/v1/exams/:exam_id/questions`

指定した試験(:exam_id)の問題情報一覧を返す。

#### Params

Nothing.

#### Returns

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

指定した試験に新しく問題を作成する。

#### Params

| Name          | Type    |
| ------------- | ------- |
| smatex        | String* |
| latex         | String* |
| ans_smatex    | String* |
| ans_latex     | String* |
| question_type | String* |

#### Returns

##### request is valid

- single Question's JSON created by params
- HTTP 201

##### request is invalid

- get `Validation failed` message
- HTTP 400

#### Example

```shell
# valid request
$ curl -X POST -H 'Content-Type: application/json' https://HOST/v1/exams/1/questions -d '{"smatex": "[2]%[4]", "latex": "\\frac{2}{4}", "ans_smatex": "[1]%[2]", "ans_latex": "\\frac{1}{2}", "question_type": "Math"}' | jq

{
  "id": 60,
  "question_type": "Math",
  "ans_smatex": "[1]%[2]",
  "exam_id": 1,
  "created_at": "2018-11-22T22:21:26.675+09:00",
  "updated_at": "2018-11-22T22:21:26.675+09:00",
  "latex": "\\frac{2}{4}",
  "smatex": "[2]%[4]",
  "ans_latex": "\\frac{1}{2}"
}

# invalid request
$ curl -X POST -H 'Content-Type: application/json' https://smat-api-dev.herokuapp.com/v1/exams/1/questions -d '{"smatex": "", "latex": "", "ans_smatex": "", "ans_latex": "", "question_type": ""}' | jq

{
  "message": "Validation failed: Smatex can't be blank, Latex can't be blank, Question type can't be blank, Ans smatex can't be blank, Ans latex can't be blank"
}
```

### GET `/v1/questions/:id`

指定された問題(:question_id)の情報を返す。

#### Params

Nothing.

#### Returns

##### question exists

- single Question's JSON
- HTTP 200

##### question doesn't exists

- `Couldn't find Question` message
- HTTP 400

#### Example

```shell
# question exists
$ curl https://HOST/v1/questions/1 | jq

{
  "id": 1,
  "question_type": "Math",
  "ans_smatex": "166375",
  "exam_id": 1,
  "created_at": "2018-11-22T19:05:33.961+09:00",
  "updated_at": "2018-11-22T19:20:29.226+09:00",
  "latex": "55^3",
  "smatex": "55^3",
  "ans_latex": "166375"
}

# question doesn't exists
$ curl https://HOST/v1/questions/0 | jq

{
  "message": "Couldn't find Question with 'id'=0"
}
```

### PATCH/PUT `/v1/questions/:id`

指定された問題の情報を更新する。

#### Params

| Name          | Type    |
| ------------- | ------- |
| smatex        | String* |
| latex         | String* |
| ans_smatex    | String* |
| ans_latex     | String* |
| question_type | String* |

#### Returns

##### request is valid

- single Question's JSON updated by params
- HTTP 200

##### request is invalid

- get `Validation failed` message
- HTTP 400

#### Example

```shell
# request is valid
$ curl -X PUT -H 'Content-Type: application/json' https://HOST/v1/questions/1 -d '{"smatex": "#{2}", "latex": "\\sqrt{2}", "ans_smatex": "1.41421356", "ans_latex": "1.41421356", "question_type": "Matematics"}' | jq

{
  "id": 1,
  "smatex": "#{2}",
  "latex": "\\sqrt{2}",
  "ans_smatex": "1.41421356",
  "ans_latex": "1.41421356",
  "question_type": "Matematics",
  "exam_id": 1,
  "created_at": "2018-11-22T19:05:33.961+09:00",
  "updated_at": "2018-11-22T22:41:06.586+09:00"
}

# request is invalid
$
curl -X PUT -H 'Content-Type: application/json' https://HOST/v1/questions/1 -d '{"smatex": "", "latex": "", "ans_smatex": "", "ans_latex": "", "question_type": ""}' | jq

{
  "message": "Validation failed: Smatex can't be blank, Latex can't be blank, Question type can't be blank, Ans smatex can't be blank, Ans latex can't be blank"
}
```

### PATCH/PUT `/v1/exams/:id`

指定された試験の情報を更新する。

#### Params

| Name        | Type    |
| ----------- | ------- |
| title       | String* |
| description | String  |

#### Return

##### params is valid

- single Exam's JSON updated by params
- HTTP 200

##### params is invalid

- `Validation failed` message
- HTTP 400

#### Example

```shell
# valid request
$ curl -X PUT -H 'Content-Type: application/json' https://HOST/v1/exams/1 -d '{"title": "Updated Exam", "description": "Description New"}' | jq

{
  "room_id": -1,
  "status": 0,
  "id": 1,
  "title": "Updated Exam",
  "description": "Description New",
  "teacher_id": 1,
  "created_at": "2018-11-22T19:05:33.871+09:00",
  "updated_at": "2018-11-22T22:46:27.038+09:00"
}

# invalid request
$ curl -X PUT -H 'Content-Type: application/json' https://HOST/v1/exams/1 -d '{"title": "", "description": ""}' | jq'

{
  "message":"Validation failed: Title can't be blank"
}
```

_INFO: `description` accepts empty_

### POST `/v1/exams/:id/open`

指定した試験を**公開**(生徒が入室できる)する。

#### Params

Nothing.

#### Returns

##### exam exists

- single Exam's JSON which is specified room_id
- HTTP 200

##### exam already opened

- `Couldn't find` message
- HTTP 400

##### exam doesn't exist

- `Couldn't find` message
- HTTP 400

#### Example

```shell
# exam exists
$ curl -X POST https://HOST/v1/exams/1/open | jq

{
  "room_id": 435,
  "status": 1,
  "id": 1,
  "title": "Updated Exam",
  "teacher_id": 1,
  "created_at": "2018-11-22T19:05:33.871+09:00",
  "updated_at": "2018-11-22T23:03:56.534+09:00",
  "description": "Description New"
}

# exam already opened
$ curl -X POST https://HOST/v1/exams/1/open | jq

{
  "message": "Couldn't find Exam with 'id'=1 [WHERE \"exams\".\"status\" = $1]"
}

# exam doesn't exist
$ curl -X POST https://HOST/v1/exams/0/open | jq
{
  "message": "Couldn't find Exam with 'id'=0 [WHERE \"exams\".\"status\" = $1]"
}
```

### POST `/v1/exams/:id/close`

指定した試験を**非公開**(生徒の入室を不可に)にする。

#### Params

Nothing.

#### Returns

##### exam exists

- single Exam's JSON which set room_id = -1
- HTTP 200

##### exam doesn't exist

- `Couldn't find` message
- HTTP 400

#### Example

```shell
# exam exists
$ curl -X POST https://HOST/v1/exams/1/close | jq

{
  "room_id": -1,
  "status": 0,
  "id": 1,
  "title": "Updated Exam",
  "teacher_id": 1,
  "created_at": "2018-11-22T19:05:33.871+09:00",
  "updated_at": "2018-11-22T23:13:50.087+09:00",
  "description": "Description New"
}

# exam doesn't exist
$ curl -X POST https://HOST/v1/exams/0/close | jq
{
  "message": "Couldn't find Exam with 'id'=0 [WHERE \"exams\".\"status\" = $1]"
}
```

### GET `/v1/exmas/:exam_id/results` _under development_

指定した試験における結果一覧を返す。

#### Params

Nothing.

#### Returns

##### exam exists

- Array of Result's JSON through its question in specified Exam
- HTTP 200

##### exam doesn't exist

- `Couldn't find` message
- HTTP 400

#### Example

Add in the future...

### GET `/v1/questions/:question_id/results` _under development_

指定した問題における結果一覧を返す。

#### Params

Nothing.

#### Returns

##### question exists

- Array of Result's JSON
- HTTP 200

##### question doesn't exist

- `Couldn't find` message
- HTTP 400

#### Example

Add in the future...

### GET `/v1/teachers/:id`

指定した教員(:id)の情報を返す。
`Authorization: Token|Bearer hogehoge`ヘッダによる認証が必要。

#### Params

Nothing.

#### Returns

##### token is valid

- shingle Teacher's JSON specified by id
- HTTP 200

##### token is valid but id is invalid

- get `Couldn't find` message
- HTTP 400

##### token is invalid

- get `Authentication required` message
- HTTP 401

#### Example

```shell
# token is valid
$ curl -H 'Authorization: Token hogehoge' https://HOST/v1/teachers/1 | jq

{
  "id": 1,
  "fullname": "Smart Teacher",
  "username": "smat",
  "password_digest": "50ecc45020be014e68d714cd076007e84a9621d9a5e589a916e45273014830b399d143a57f525554bfe9e751d97fe0fa884dbdea7b07721723b4eff39e9d28ad",
  "token": "DQDjUXRfpFquNRQPbjuaemS4",
  "created_at": "2018-11-22T19:05:33.818+09:00",
  "updated_at": "2018-11-22T19:05:33.818+09:00"
}

# token is valid but id is invalid
$ curl -H 'Authorization: Token hogehoge' https://HOST/v1/teachers/0 | jq

{
  "message": "Couldn't find Teacher with 'id'=0"
}

# token is invalid(not specified)
$ curl https://HOST/v1/teachers/1 | jq

{
  "message": "Authorization required"
}
```

### POST `/v1/teachers/`

指定された内容で教員を新しく作成する。

#### Params

| Name            | Type    |
| --------------- | ------- |
| fullname        | String* |
| username        | String* |
| password_digest | String* |

#### Returns

##### request is valid

- single Teacher's JSON created by params
- HTTP 200

##### request is invalid

- get `Validation failed` message
- HTTP 400

#### Example

```shell
# request is valid
$ curl -X POST -H 'Content-Type: application/json' https://HOST/v1/teachers -d '{"fullname": "John Henecy", "username": "john_h", "password_digest": "5e884898da28047151d0e56f8dc6292773603d0d6aabbdd62a11ef721d1542d8"}' | jq

{
  "id": 2,
  "fullname": "John Henecy",
  "username": "john_h",
  "password_digest": "5e884898da28047151d0e56f8dc6292773603d0d6aabbdd62a11ef721d1542d8",
  "token": "AdE4qxCC1iNEQ9hyvV9zjZnW",
  "created_at": "2018-11-22T23:47:39.800+09:00",
  "updated_at": "2018-11-22T23:47:39.800+09:00"
}

# request is invalid
$ curl -X POST -H 'Content-Type: application/json' https://smat-api-dev.herokuapp.com/v1/teachers -d '{"fullname": "", "username": "", "password_digest": ""}' | jq

{
  "message": "Validation failed: Fullname can't be blank, Username can't be blank, Password digest can't be blank"
}
```

### POST `/v1/auth/teacher/login`

ユーザーネームとパスワードを用いて認証に必要なTokenを返す。

#### Params

| Name            | Type    |
| --------------- | ------- |
| username        | String* |
| password_digest | String* |

#### Returns

##### request is valid

- returns Token specified by username
- HTTP 200

##### request is invalid

- get `Couldn't find` message
- HTTP 400

#### Example

```shell
# request is valid
$ curl -X POST -H 'Content-Type: application/json' https://HOST/v1/auth/teacher/login -d '{"username": "john_h", "password_digest": "5e884898da28047151d0e56f8dc6292773603d0d6aabbdd62a11ef721d1542d8"}' | jq

{
  "token": "hogehoge"
}

# request is invalid
$ curl -X POST -H 'Content-Type: application/json' https://smat-api-dev.herokuapp.com/v1/auth/teacher/login -d '{"username": "", "password_digest": ""}'  

{
  "message": "Couldn't find Teacher"
}
```

## Student's API

### GET `/v1/rooms/:room_id/questions`

指定された試験(:room_id ExamのDB上ではない別のID)における問題情報一覧を返す。
挙動については`GET /v1/exams/:exam_id/questions`と同様。

### GET `/v1/rooms/:room_id/questions/:id`

指定された試験における問題情報(:id)を1つ返す。

#### INFO

ここでの`:id`はDB上のIDではなく、1以上の整数である。
例えば
```
$ curl https://HOST/v1/rooms/637/questions/1
```
とすると、`room_id=637`である試験における問題一覧の**1番目に登録されている問題情報**を返す。

```
$ curl https://HOST/v1/rooms/637/questions/2
```
のようにすれば該当試験において**2番目に登録されている問題情報**が、
```
$ curl https://HOST/v1/rooms/637/questions/3
```
とすれば**3番目の問題情報**が...というように、
`GET /v1/questions/:id`では必要だったDBにおけるIDを知らずとも問題情報の参照が可能となっている。　

### POST `/v1/results` _under development_

生徒の回答結果を送信、保存する。

#### INFO:BUG

`{"q_id": "", "j": "", "c": ""}` returns `Results submitted.`.
Improve it to return `Invalid request format.` message.

#### Params

| Name        | Type    |
| ----------- | ------- |
| q_id        | String* |
| j           | String* |
| c           | String* |

#### Returns

##### request is valid

- get `Results submitted.` message
- HTTP 201

##### request is empty

- get `Invalid request format.` message
- HTTP 400

##### request's format is invalid

- get `Invalid request format.` message
- HTTP 400

#### Example

```shell
# request is valid
$ curl -X POST -H 'Content-Type: application/json' https://HOST/v1/results -d '{"q_id": "1,2,3,4", "j": "0,0,1,0", "c": "3,3,5,3"}' | jq

{
  "message": "Results submitted."
}

# request is empty
$ curl -X POST -H 'Content-Type: application/json' https://HOST/v1/results -d '{}' | jq

{
  "message": "Invalid request format."
}

# request's format is invalid
$ curl -X POST -H 'Content-Type: application/json' https://HOST/v1/results -d '{"q_id": "1,2,34", "j": "0", "c": "3,15"}' | jq

{
  "message": "Invalid request format."
}
```

### GET `/v1/states/:student_id`

ステート(生徒の回答記録を一時的に保持したもの)情報を返す。

#### Params

Nothing.

#### Returns

##### state exists

- single State's JSON specified by student_id
- HTTP 200

##### state doesn't exist

- get `Couldn't find` message
- HTTP 400

#### Example

```shell
# state exists
$ curl https://HOST/v1/states/1 | jq

{
  "id": 1,
  "student_id": 1,
  "q_id": "1,2,3,4",
  "judge": "0,0,1,0",
  "challenge": "2,5,6,1",
  "created_at": "2018-11-23T00:32:04.722+09:00",
  "updated_at": "2018-11-23T00:32:04.722+09:00"
}

# state doesn't exist
$ curl https://HOST/v1/states/0 | jq

{
  "message": "Couldn't find State"
}
```

### POST `/v1/states/:student_id`

ステート情報の追加/更新を行う。

#### Params

| Name        | Type    |
| ----------- | ------- |
| q_id        | String* |
| judge       | String* |
| challenge   | String* |

#### Returns

##### state found (by student_id)

- get 'Update success.' message
- HTTP 200

##### state not found (by student_id)

- get `State created.` message
- HTTP 201

#### Example

```shell
# state found
$ curl -X POST -H 'Content-Type: application/json' https://HOST/v1/states/1 -d '{"q_id": "1,2,3,4,5,6", "judge": "0,0,1,0,1,1", "challenge": "2,5,6,1,1,1"}' | jq

{
  "message": "Update success."
}

# state not found
$ curl -X POST -H 'Content-Type: application/json' https://HOST/v1/states/1 -d '{"q_id": "1,2,3,4", "judge": "0,0,1,0", "challenge": "2,5,6,1"}' | jq

{
  "message": "State created."
}
```

### POST `/v1/states/:student_id/finish` _under development_

該当ステートに保持されている生徒の回答結果を送信、保存する。

#### INFO

現時点で回答結果の保存は**しない**。
該当するレコードの削除のみ。

#### Params

Nothing.

#### Returns

##### state exists

- get `Finish.` message
- HTTP 200

##### state doesn't exist

- get `Couldn't find` message
- HTTP 400

#### Example

```shell
# state exists
$ curl -X POST https://HOST/v1/states/1/finish | jq

{
  "message": "Finish."
}

# state doesn't exist
$ curl -X POST https://HOST/v1/states/0/finish | jq

{
  "message": "Couldn't find State"
}
```
