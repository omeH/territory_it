describe Api::V1::AuthorsController, type: :controller do
  let!(:user_1) { create(:user, login: 'login_1') }
  let!(:user_2) { create(:user, login: 'login_2') }
  let(:ip_1) { '192.168.1.1' }
  let(:ip_2) { '192.168.1.2' }

  context 'Two authors create posts from same IP' do
    let!(:post_1) { create(:post, user: user_1) }
    let!(:post_2) { create(:post, user: user_2) }
    let!(:author_1) { create(:author, post: post_1, user: user_1, ip: ip_1) }
    let!(:author_2) { create(:author, post: post_1, user: user_2, ip: ip_1) }

    it 'returns only one item' do
      get :index, params: { logins: [user_1.login, user_2.login] }

      expect(response).to have_http_status(:ok)

      items = JSON.parse(response.body)
      expect(items.size).to eq(1)
      expect(items[ip_1]).to include(user_1.login)
      expect(items[ip_1]).to include(user_2.login)
    end
  end

  context 'Two authors create posts from different IP' do
    let!(:post_1) { create(:post, user: user_1) }
    let!(:post_2) { create(:post, user: user_2) }
    let!(:author_1) { create(:author, post: post_1, user: user_1, ip: ip_1) }
    let!(:author_2) { create(:author, post: post_1, user: user_2, ip: ip_2) }

    it 'returns two items' do
      get :index, params: { logins: [user_1.login, user_2.login] }

      expect(response).to have_http_status(:ok)

      items = JSON.parse(response.body)
      expect(items.size).to eq(2)
      expect(items[ip_1]).to include(user_1.login)
      expect(items[ip_2]).to include(user_2.login)
    end
  end

  context 'One author has no posts' do
    let!(:post_1) { create(:post, user: user_1) }
    let!(:author_1) { create(:author, post: post_1, user: user_1, ip: ip_1) }

    it 'returns nothing' do
      get :index, params: { logins: [user_2.login] }

      expect(response).to have_http_status(:ok)

      items = JSON.parse(response.body)
      expect(items.size).to eq(0)
    end
  end
end
