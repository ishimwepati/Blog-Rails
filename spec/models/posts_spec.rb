require 'rails_helper'

RSpec.describe Post, type: :model do
  subject { build(:post, title: 'My First Post', comments_counter: 4, likes_counter: 20) }

  before { subject.save }

  it 'title should not be too long' do
    subject.title = 'a' * 256
    expect(subject).to_not be_valid
  end

  it 'comments_counter should be an integer' do
    subject.comments_counter = 'b'
    expect(subject).to_not be_valid
  end

  it 'comments_counter should be greater than or equal to zero' do
    subject.comments_counter = -1
    expect(subject).to_not be_valid
  end

  it 'likes_counter should be an integer' do
    subject.likes_counter = 'c'
    expect(subject).to_not be_valid
  end

  it 'likes_counter should be greater than or equal to zero' do
    subject.likes_counter = -2
    expect(subject).to_not be_valid
  end

  describe '#most_recent_comments' do
    it 'returns the most recent comments' do
      post = create(:post)
      older_comment = create(:comment, post: post, created_at: 2.days.ago)
      recent_comments = create_list(:comment, 5, post: post, created_at: Time.current)

      expect(post.most_recent_comments).to eq(recent_comments)
    end
  end

  describe '#update_post_counter' do
    it 'increments the post counter' do
      post = create(:post)
      initial_counter = post.comments_counter

      post.update_post_counter

      expect(post.comments_counter).to eq(initial_counter + 1)
    end
  end
end
