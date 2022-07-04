# README

This README would normally document whatever steps are necessary to get the
application up and running.

Things you may want to cover:

- Ruby Create project

```
rails new project2 --api --database=sqlite3 --skip-bundle
```

สร้าง Gemset

```
echo 'ror-project2' > .ruby-gemset
```

ออกจาก folder project2 และกลับเข้าไปใหม่อีกที

```
cd..
cd project2
```

ไป Config cors ที่ config > env > development

Install

```
bundle install
cd ..
cd project2
```

- CLI

Create model

```
rails generate model User first_name:text last_name:text
```

Run migrate

```
rails db:migrate
```

Rollback migrate

```
rails db:rollback
```

ถ้าจะ rollback 5 ครั้วให้ทำ
STEP=5 ต่อท้าย

```
rails db:rollback STEP=5
```

Rollback เวอชันเดียว

```
rails db:migrate:down VERSION=YYYYMMDDHHmmss
```

Create migration file example
หากเราขึ้นต้นด้วย Add ต่อด้วย To ลงท้ายด้วยชื่อ Model ที่ถูกต้อง Rails จะเดาว่าเราต้องการแก้ไข Model ไหน โดยที่เราไม่ต้องไปพิมพ์ 3 บรรทัดเอง หากจะลบ Column ให้ขึ้นต้นด้วย Remove ต่อด้วยคำว่า From ลงท้ายด้วย Model

```
rails generate migration AddDobToUser date_of_birth:date
rails g migration RemoveTitleFromUser title:text
```

Open rails console at root

```
rails console
rails c
```

Create user from rails console
เป็นการสร้าง Object จาก User Class
หลังจากสร้าง จะได้ Object กลับมาและมี Column ตาม Table ที่สร้างไว้

```
u = User.new
```

Commit object for save to database

```
u.save
```

Query user ออกมาดู 1 คน

```
User.find(:id)
User.find(1)
u = User.find(1)
```

Add data example

```
u.first_name = 'Supachai'
```

Delete data example

```
u.destroy
```

หลังจาก Destroy จะยังใช้ u ได้อยู่เพราะ u ยังอยู่ใน memmory

ความแตกต่าง .save and .create
User.create() จะ return User Object ที่ถูกสร้างกลับมา โดยที่เราใส่ไว้ใน u1, u2 ได้ซึ่งเทียบ
เท่ากับการรัน User.new() และนำไป save

เราใช้ u3 ทำ User.new() ไว้ มันจะ return User Object ออกมา
แต่ถ้าเรา u3.save มันจะเป็น boolean บอกแค่ว่า save สำเร็จหรือไม่

๊User.find_by เป็น method สำหรับทุก Column ใน table ชื่อ user
เช่น first_name. last_name ตัวนี้จะ limit 1
ตัวแปรที่ใช้ find_by สามารถ Destroy ได้

Get all example แบบนี้เราจะได้เป็น Object ออกมา เราต้องเอาไป .map ออกมา

```
User.all
```

???

```
User.reload
```

Method ที่น่าสนใจ

ถามว่า User object นี้เคยบันทึกลง Database หรือยัง

```
user.new_record?
```

ถาม User ว่า User object นี้เคยถูกเปลี่ยนแปลงค่าหรือไม่ หลังจากที่ save หรือ load จาก database
หากลอง save แล้วทดสอบด้วย method นี้อีกครั้งจะได้เป็น false

```
user.changed?
```

Query หาข้อมูลที่ต้องการจาก Database โดยที่ข้อมูลที่ได้มาจะเป็น Array สิ่งที่หาจะเป็น Case sensitive เท่านั้น
ต่อให้ดึงค่าออกมาแล้วไม่เจอก็จะยังได้อยู่ดีแต่ว่าเป็น .count เท่ากับ 0 ฉะนั้นถ้าอยากเอาค่าข้างในออกมาใช้งานจะต้องใช้ users[index] ออกมาใช้งาน

```
User.where()
```

ทุกๆ Active Record Object นั้นเป็น Serializable Object ทำให้เราสามารถแปลงค่าเป็น json ได้
ทันทีด้วย .as_json ซึ่งจะออกมาเป็น Ruby Hash แต่ถ้าอยากได้ JSON String ให้ใช้ .to_json

```
users.as_json
```

- Gen controller

สำหรับการสร้าง Controller เราจะใช้ชื่อ Controllers ว่า Users

```
rails g controller Users index create show update destroy
```

และไปปรับ Route

```
get 'users', to: "users#index"
post 'users', to: "users#create"
get 'users/:id', to: "users#show"
put 'users/:id', to: "users#update"
patch 'users/:id', to: "users#update"
delete 'users/:id', to: "users#destroy"
```

การ Update ในกรณีที่เราต้องการอัพแค่อันเดียวและไม่ให้ไปกระทบตัวอื่นเราต้องใส่ if present
Function .present? เป็นสิ่งที่ rails ให้มาใช้เพื่อตรวจสอบว่ามีการส่งค่าเข้ามาหรือไม่ ใช้ได้กับ Object หลายประเภท
```
def update
    user = User.find(params[:id])
    user.first_name = params[:first_name] if params[:first_name].present?
    user.last_name = params[:last_name] if params[:last_name].present?
    user.save
    render json: user.as_json
end

nil.present?
"       ".present?
{}.present?
[].present?
```