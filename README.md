# README

[後端：18 銅人步驟文件](https://github.com/5xRuby/5xtraining/blob/7b805aee936020209059c1c970562970068bed3e/backend.md)

## 預期 ERD
![](https://i.imgur.com/WTivGjh.png)


## Table Schema

* Users

| Column Name | Type     |
| ----------- | -------- |
| email       | string   |
| password    | string   |
| name        | string   |
| created_at  | datetime |
| updated_at  | datetime |
| admin       | boolean  |

* Tasks

| Column Name | Type     |
| ----------- | -------- |
| title       | string   |
| content     | text     |
| start_at    | datetime |
| end_at      | datetime |
| priority    | integer  |
| status      | integer  |
| created_at  | datetime |
| updated_at  | datetime |
| deleted_at  | datetime |
| owner_id    | integer  |

* Tags

| Column Name | Type     |
| ----------- | -------- |
| name        | string   |
| created_at  | datetime |
| updated_at  | datetime |
| deleted_at  | datetime |

* Task - Tags

| Column Name | Type     |
| ----------- | -------- |
| task_id     | integer  |
| tag_id      | integer  |

* Groups

| Column Name | Type     |
| ----------- | -------- |
| title       | string   |
| description | text     |
| created_at  | datetime |
| updated_at  | datetime |
| deleted_at  | datetime |

* Group - Users

| Column Name | Type     |
| ----------- | -------- |
| user_id     | integer  |
| group_id    | integer  |
| created_at  | datetime |
| updated_at  | datetime |
| deleted_at  | datetime |