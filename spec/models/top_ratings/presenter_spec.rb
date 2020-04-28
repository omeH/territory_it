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
    expect(described_class.new(limit: -1).limit).to eq(described_class::MIN_LIMIT)
    expect(described_class.new(limit: 0).limit).to eq(described_class::MIN_LIMIT)
    expect(described_class.new(limit: 1).limit).to eq(described_class::MIN_LIMIT)
    expect(described_class.new(limit: 5).limit).to eq(5)
  end
end
