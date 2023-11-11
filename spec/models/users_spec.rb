require 'rails_helper'

RSpec.describe User, type: :model do
  subject { User.new(name: 'John', post_counter: 30, photo: 'https://unsplash.com/photos/F_-0BxGuVvo', bio: 'Teacher from Poland.') }

  before { subject.save }

  it 'name should be present' do
    subject.name = nil
    expect(subject).to_not be_valid
  end

  it 'post_counter should be present' do
    subject.post_counter = nil
    expect(subject).to_not be_valid
  end

  it 'post_counter should be an integer' do
    subject.post_counter = 'a'
    expect(subject).to_not be_valid
  end

  it 'post_counter should be greater than or equal to zero' do
    subject.post_counter = -1
    expect(subject).to_not be_valid
  end

  it 'should return the most recent posts' do
    user = create(:user)  
    older_post = create(:post, user: user, created_at: 2.days.ago)
    recent_posts = create_list(:post, 5, user: user, created_at: Time.current)

    expect(user.most_recent_posts).to eq(recent_posts)
  end
end

