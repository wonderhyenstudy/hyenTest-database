
-- MONGODB 사용법
-- 1. open mongoDB sell 열기
-- 2. 사용할 컬렉션 지정 : use blog
--     답 : switched to db blog
-- 3. 생성, 추가, 삭제 등 명령어를 넣어주면 됩니다.
-- 4. 각 컬렉션에 들어가서 refresh 버튼을 눌러 새로고침한다.


db.createCollection("posts")
    { ok: 1 }
db.posts.insertOne({title:"First1"})
    {
    acknowledged: true,
    insertedId: ObjectId('69609be9627936be783930e5')
    }
db.posts.insertOne({
  title:"Post Title 1",
  body:"Body of post.",
  category:"news",
  likes["news","events"],
  date:Date()
})
    SyntaxError: Unexpected token, expected "," (5:7)

    3 |   body:"Body of post.",
    4 |   category:"news",
    > 5 |   likes["news","events"],
        |        ^
    6 |   date:Date()
    7 | })
    8 |
db.posts.insertOne({
  title:"Post Title 1",
  body:"Body of post.",
  category:"news",
  likes:["news","events"],
  date:Date()
})
    {
    acknowledged: true,
    insertedId: ObjectId('69609d11627936be783930e6')
    }
db.posts.insertOne({
  title: "Post Title 2",
  body: "Body of post.",
  category: "News",
  likes: 1,
  tags: ["news", "events"],
  date: Date()
})
    {
    acknowledged: true,
    insertedId: ObjectId('69609e2c627936be783930e7')
    }
db.posts.insertMany([
  {
    title: "Post Title 2",
    body: "Body of post.",
    category: "Event",
    likes: 2,
    tags: ["news", "events"],
    date: Date()
  },
  {
    title: "Post Title 3",
    body: "Body of post.",
    category: "Technology",
    likes: 3,
    tags: ["news", "events"],
    date: Date()
  },
  {
    title: "Post Title 4",
    body: "Body of post.",
    category: "Event",
    likes: 4,
    tags: ["news", "events"],
    date: Date()
  }
])
    {
    acknowledged: true,
    insertedIds: {
        '0': ObjectId('69609ef7627936be783930e8'),
        '1': ObjectId('69609ef7627936be783930e9'),
        '2': ObjectId('69609ef7627936be783930ea')
    }
    }
db.posts.findOne()
    {
    _id: ObjectId('69609be9627936be783930e5'),
    title: 'First1'
    }
db.posts.find({cateegory:"News"})
db.posts.find({category:"News"})
    {
    _id: ObjectId('69609e2c627936be783930e7'),
    title: 'Post Title 2',
    body: 'Body of post.',
    category: 'News',
    likes: 1,
    tags: [
        'news',
        'events'
    ],
    date: 'Fri Jan 09 2026 15:20:28 GMT+0900 (한국 표준시)'
    }
db.posts.find({category:"News"},{title:1,date:1})
    {
    _id: ObjectId('69609e2c627936be783930e7'),
    title: 'Post Title 2',
    date: 'Fri Jan 09 2026 15:20:28 GMT+0900 (한국 표준시)'
    }
db.posts.find({category:"News"},{title:1,date:true})
    {
    _id: ObjectId('69609e2c627936be783930e7'),
    title: 'Post Title 2',
    date: 'Fri Jan 09 2026 15:20:28 GMT+0900 (한국 표준시)'
    }
db.posts.find({category:"News"},{title:1,date:true,_id:false})
    {
    title: 'Post Title 2',
    date: 'Fri Jan 09 2026 15:20:28 GMT+0900 (한국 표준시)'
    }
db.posts.find({category:"News"},{date:0,_id:0})
    {
    title: 'Post Title 2',
    body: 'Body of post.',
    category: 'News',
    likes: 1,
    tags: [
        'news',
        'events'
    ]
    }
db.posts.find({title:"Post Title 1"})
    {
        _id: ObjectId('69609d11627936be783930e6'),
        title: 'Post Title 1',
        body: 'Body of post.',
        category: 'news',
        likes: [
            'news',
            'events'
        ],
        date: 'Fri Jan 09 2026 15:15:45 GMT+0900 (한국 표준시)'
    }
db.posts.updateOne({title:"Post Title 1"},{$set:{likes:2}})
    {
        acknowledged: true,
        insertedId: null,
        matchedCount: 1,
        modifiedCount: 1,
        upsertedCount: 0
    }
db.posts.updateOne(
  {title:"Post Title 5"},
                   {
                     $set:
                       {
        title: "Post Title 5",
        body: "Body of post.",
        category: "Event",
        likes: 5,
        tags: ["news", "events"],
        date: Date()
      }
                   },
                   {upsert:true}
)
    {
        acknowledged: true,
        insertedId: ObjectId('6960a680c82ddd8a2e5718a6'),
        matchedCount: 0,
        modifiedCount: 0,
        upsertedCount: 1
    }
db.posts.deleteOne({title:"Post Title 5"})
    {
        acknowledged: true,
        deletedCount: 1
    }