require 'test_helper'

class PostTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end

  test "should create post" do
  	post = Post.create(tittle: "my title", contenido: "content")
  	assert post.save
  end

  test "should update a post" do
  	post = posts(:first_article)
  	assert post.update(tittle: "new tittle", contenido: "new content")
  end

  test "should find a post by id" do
  	post_id = posts(:first_article).id
  	post = Post.find(post_id)
  	assert_equal post, posts(:first_article), "record not found"
  end

  test "should destroy a post" do
  	post = posts(:first_article)
  	post.destroy
  	assert_raise(ActiveRecord::RecordNotFound) {Post.find(post.id)}
  end

  test "should not create a post without tittle" do
  	post = Post.new
  	assert post.invalid?, "the post should be invalid"
  end

  test "each tittle must be unique" do
  	post = Post.new
  	post.tittle = posts(:first_article).tittle
  	assert post.invalid?, "Each title must be unique"
  end
end
