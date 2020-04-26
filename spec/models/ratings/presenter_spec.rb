describe Ratings::Presenter do
  it '#gather' do
    rating = build(:rating)
    expect(described_class.new(rating: rating).gather).to eq(rating: 0.0)

    rating.average = 1.11
    expect(described_class.new(rating: rating).gather).to eq(rating: 1.11)

    rating.average = 1.111
    expect(described_class.new(rating: rating).gather).to eq(rating: 1.11)

    rating.average = nil
    expect(described_class.new(rating: rating).gather).to eq(rating: nil)
  end
end
