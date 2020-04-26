describe Posts::Presenter do
  let!(:user) { create(:user, login: 'login') }
  let!(:post) { create(:post, user: user) }
  let!(:author) { create(:author, post: post, user: user) }

  it '#gather' do
    data = described_class.new(post: post).gather

    expect(data[:id]).to eq(post.id)
    expect(data[:title]).to eq(post.title)
    expect(data[:content]).to eq(post.content)
    expect(data[:ip]).to eq(author.ip.to_s)
  end
end
