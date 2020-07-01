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
User.reset_pk_sequence
Post.reset_pk_sequence
Tag.reset_pk_sequence
PostTag.reset_pk_sequence

u1 = User.create(user_name: 'Joao', password: '123', password_confirmation: '123')
u2 = User.create(user_name: 'Eric', password: '123', password_confirmation: '123')
u3 = User.create(user_name: 'Anmolpreet', password: '123', password_confirmation: '123')

p1 = Post.create(title: 'Hello', body: 'Hello world', user_id: u1.id)
p2 = Post.create(title: 'Goodbye', body: 'Goodbye world', user_id: u2.id)
p3 = Post.create(title: 'Hello Again', body: 'Hello again world', user_id: u3.id)

t1 = Tag.create(name: "food")
t2 = Tag.create(name: "sports")
t3 = Tag.create(name: "school")

pt1 = PostTag.create(post_id: p1.id, tag_id: t1.id)
pt2 = PostTag.create(post_id: p1.id, tag_id: t2.id)
pt3 = PostTag.create(post_id: p2.id, tag_id: t3.id)