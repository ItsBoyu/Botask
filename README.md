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

## Deploy

1. 申請 [Heroku](https://www.heroku.com/) 帳號

2. 安裝 Heroku CLI  
`$ brew tap heroku/brew && brew install heroku`

3. 在終端機登入 Heroku，該步驟會自動開啟瀏覽器登入  
`$ heroku login`

4. 建立與專案同名之app機器  
`$ heroku create`

5. 將專案推上 Heroku  
`$ git push heroku master`

6. 在 Heroku 機器執行 db:migrate  
`$ heroku run rails db:migrate`

7. 為利用 Seed.rb 建立管理者帳號，已先將 信箱 及 密碼 利用 Figaro 設定環境變數進行保護。  
須先至 Heroku 網頁 Dashboard 的 Setting 頁籤中，找到 Config Vars 進行設定，再執行 db:seed  
`$ heroku run rails db:seed`

8. 此時網站樣式尚未套用，須將 app/view/layouts/application.html.erb 檔中的 `<%= stylesheet_link_tag %>`  
修改為 `<%= stylesheet_pack_tag %>`，commit 並重複步驟5，即可完成套用。