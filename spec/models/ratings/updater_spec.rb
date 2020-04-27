describe Ratings::Updater do
  let!(:user) { create(:user, login: 'login') }
  let!(:post) { create(:post, user: user) }

  it 'updates nothing' do
    expect { described_class.new(post_id: post.id.next, value: 1).update }
      .to change { post.reload.average }.by(0.0)
  end

  it 'updates rating' do
    expect { described_class.new(post_id: post.id, value: 1).update }
      .to change { post.reload.average }.by(1.0)
      .and change { post.reload.total }.by(1)
      .and change { post.reload.score }.by(1)
  end
end
