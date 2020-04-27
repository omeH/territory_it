describe Ratings::Calculator do
  it '#calculate' do
    post = build(:post)

    described_class.new(post: post, value: 2).calculate
    expect(post.total).to eq(2)
    expect(post.score).to eq(1)
    expect(post.average).to eq(2.0)
  end

  it '#value' do
    expect(described_class.new(post: :post, value: 0).value).to eq(described_class::MIN_RATING)
    expect(described_class.new(post: :post, value: 1).value).to eq(1)
    expect(described_class.new(post: :post, value: 3).value).to eq(3)
    expect(described_class.new(post: :post, value: 5).value).to eq(5)
    expect(described_class.new(post: :post, value: 6).value).to eq(described_class::MAX_RATING)
  end
end
