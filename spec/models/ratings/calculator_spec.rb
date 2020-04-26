describe Ratings::Calculator do
  it '#calculate' do
    rating = build(:rating)

    described_class.new(rating: rating, value: 2).calculate
    expect(rating.total).to eq(2)
    expect(rating.score).to eq(1)
    expect(rating.average).to eq(2.0)
  end

  it '#value' do
    expect(described_class.new(rating: :rating, value: 0).value).to eq(described_class::MIN_RATING)
    expect(described_class.new(rating: :rating, value: 1).value).to eq(1)
    expect(described_class.new(rating: :rating, value: 3).value).to eq(3)
    expect(described_class.new(rating: :rating, value: 5).value).to eq(5)
    expect(described_class.new(rating: :rating, value: 6).value).to eq(described_class::MAX_RATING)
  end
end
