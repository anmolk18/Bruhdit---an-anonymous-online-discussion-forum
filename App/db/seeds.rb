# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

User.destroy_all
Post.destroy_all
Tag.destroy_all
PostTag.destroy_all
Comment.destroy_all
Like.destroy_all

User.reset_pk_sequence
Post.reset_pk_sequence
Tag.reset_pk_sequence
PostTag.reset_pk_sequence
Comment.reset_pk_sequence
Like.reset_pk_sequence

u1 = User.create(user_name: 'Joao', password: '123', password_confirmation: '123')
u2 = User.create(user_name: 'Eric', password: '123', password_confirmation: '123')
u3 = User.create(user_name: 'Anmolpreet', password: '123', password_confirmation: '123')

p1 = Post.create(title: 'Hello', body: 'Hello world', user_id: u1.id)
p2 = Post.create(title: 'Goodbye', body: 'Goodbye world', user_id: u2.id)
p3 = Post.create(title: 'Hello Again', body: 'Hello again world', user_id: u3.id)
p4 = Post.create(title: "Wow", body: "wowowuwa", user_id: u1.id)
p5 = Post.create(title: "Dog", body: "woof", user_id: u1.id)
p6 = Post.create(title: "Cat", body: "meow", user_id: u1.id)
p7 = Post.create(title: "Cow", body: "moo", user_id: u1.id)
p8 = Post.create(title: "Duck", body: "quack", user_id: u1.id)


t1 = Tag.create(name: "food")
t2 = Tag.create(name: "sports")
t3 = Tag.create(name: "school")
t4 = Tag.create(name: "news")
t5 = Tag.create(name: "world")
t6 = Tag.create(name: "health")
t7 = Tag.create(name: "corona")
t8 = Tag.create(name: "yale")
t9 = Tag.create(name: "U.S.")
t10 = Tag.create(name: "drama")
t11 = Tag.create(name: "horror")
t12 = Tag.create(name: "international")
t13 = Tag.create(name: "animal")

pt1 = PostTag.create(post_id: p1.id, tag_id: t11.id)
pt2 = PostTag.create(post_id: p2.id, tag_id: t2.id)
pt3 = PostTag.create(post_id: p1.id, tag_id: t3.id)
pt4 = PostTag.create(post_id: p2.id, tag_id: t4.id)
pt5 = PostTag.create(post_id: p4.id, tag_id: t2.id)
pt6 = PostTag.create(post_id: p2.id, tag_id: t3.id)
pt7 = PostTag.create(post_id: p3.id, tag_id: t11.id)
pt8 = PostTag.create(post_id: p3.id, tag_id: t5.id)
pt9 = PostTag.create(post_id: p3.id, tag_id: t9.id)
pt10 = PostTag.create(post_id: p6.id, tag_id: t11.id)
pt11 = PostTag.create(post_id: p5.id, tag_id: t2.id)
pt12 = PostTag.create(post_id: p4.id, tag_id: t11.id)

c1 = Comment.create(user_id: u1.id, post_id: p1.id, body:"nice")
c2 = Comment.create(user_id: u1.id, post_id: p2.id, body:"very nice")
c3 = Comment.create(user_id: u2.id, post_id: p2.id, body:"so nice")
c4 = Comment.create(user_id: u3.id, post_id: p4.id, body:"great")
c5 = Comment.create(user_id: u3.id, post_id: p5.id, body:"awful")
c6 = Comment.create(user_id: u2.id, post_id: p6.id, body:"disgusting")

cl1 = CommentLike.create(comment_id: c1.id, user_id: u2.id)
cl2 = CommentLike.create(comment_id: c1.id, user_id: u1.id)
cl3 = CommentLike.create(comment_id: c2.id, user_id: u1.id)
cl4 = CommentLike.create(comment_id: c2.id, user_id: u3.id)
cl5 = CommentLike.create(comment_id: c2.id, user_id: u2.id)
cl6 = CommentLike.create(comment_id: c4.id, user_id: u3.id)

