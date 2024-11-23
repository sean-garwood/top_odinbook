
class FakeComment
  def self.create
    author = User.all.sample
    post = Post.all.sample
    Comment.create(body: Faker::Lorem.paragraph, author: author, post: post)
  end
end

class FakeLike
  def self.create
    user = User.all.sample
    post = Post.all.sample
    Like.create(user: user, post: post)
  end
end

class FakePost
  def self.create
    author = User.all.sample
    Post.create(title: Faker::Lorem.sentence, body: Faker::Lorem.paragraph, author: author)
  end
end

class FakeRequest
  def self.create
    id_range = (User.first.id..User.last.id)
    sender_id = id_range.to_a.sample
    sender = User.find(sender_id)
    possible_recipients = User.where("id != ?", sender_id)
    recipient = possible_recipients.sample
    puts "Sender: #{sender.inspect}, Recipient: #{recipient.inspect}"
    FollowRequest.create(sender: sender, recipient: recipient)
  end
end

class FakeUser
  def self.create
    User.create(
      email: Faker::Internet.email,
      password: "password",
      password_confirmation: "password")
  end
end

def create_fakes(klass = KLASSES[0], count = 10)
  count.times do
    thing = klass.create
    puts "Created #{thing.inspect}"
  end
end

KLASSES = [ FakeUser.new.class,
            FakeRequest.new.class,
            FakePost.new.class,
            FakeComment.new.class,
            FakeLike.new.class     ]

KLASSES.each { |klass| create_fakes(klass) }
