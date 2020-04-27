describe Ratings::Presenter do
  it '#gather' do
    post = build(:post)
    expect(described_class.new(post: post).gather).to eq(rating: 0.0)

    post.average = 1.11
    expect(described_class.new(post: post).gather).to eq(rating: 1.11)

    post.average = 1.111
    expect(described_class.new(post: post).gather).to eq(rating: 1.11)

    post.average = nil
    expect(described_class.new(post: post).gather).to eq(rating: nil)
  end
end
