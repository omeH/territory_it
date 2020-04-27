describe TopRatings::Presenter do
  it '#gather' do
    user = create(:user, login: 'login')
    post = create(:post, user: user, average: 1.0)

    posts = described_class.new.gather
    expect(posts.size).to eq(1)
    expect(posts.first).to eq([post.title, post.content])
  end

  it '#value' do
    expect(described_class.new.limit).to eq(described_class::MIN_LIMIT)
    expect(described_class.new(limit: 4).limit).to eq(described_class::MIN_LIMIT)
    expect(described_class.new(limit: 5).limit).to eq(5)
    expect(described_class.new(limit: 100).limit).to eq(100)
    expect(described_class.new(limit: 500).limit).to eq(500)
    expect(described_class.new(limit: 501).limit).to eq(described_class::MAX_LIMIT)
  end
end
