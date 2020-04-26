describe Api::V1::PostsController, type: :controller do
  let(:login) { 'login' }
  let(:title) { 'title' }
  let(:content) { 'content' }
  let(:ip) { '192.168.1.1' }

  context 'Validation of attributes' do
    it 'returns params is missing if there are no attributes' do
      post :create, params: {}

      expect(response).to have_http_status(:unprocessable_entity)
      expect(response.body).to include('param is missing or the value is empty: attributes')
    end

    it 'returns params is missing if attributes are empty' do
      post :create, params: { attributes: {} }

      expect(response).to have_http_status(:unprocessable_entity)
      expect(response.body).to include('param is missing or the value is empty: attributes')
    end

    it 'returns validation error for login' do
      post :create, params: { attributes: { title: title, content: content, ip: ip } }

      expect(response).to have_http_status(:unprocessable_entity)
      expect(response.body).to include("Login can't be blank")
    end

    it 'returns validation error for title' do
      post :create, params: { attributes: { login: login, content: content, ip: ip } }

      expect(response).to have_http_status(:unprocessable_entity)
      expect(response.body).to include("Title can't be blank")
    end

    it 'returns validation error for content' do
      post :create, params: { attributes: { login: login, title: title, ip: ip } }

      expect(response).to have_http_status(:unprocessable_entity)
      expect(response.body).to include("Content can't be blank")
    end

    it 'returns validation error for ip' do
      post :create, params: { attributes: { login: login, title: title, content: content } }

      expect(response).to have_http_status(:unprocessable_entity)
      expect(response.body).to include('IP is invalid')
    end
  end

  context 'Creation of post' do
    let(:attributes) { { login: login, title: title, content: content, ip: ip } }

    it 'creates post and user' do
      expect { post(:create, params: { attributes: attributes }) }
        .to change { User.where(login: login).count }.by(1)
        .and change { Post.count }.by(1)

      expect(response).to have_http_status(:ok)
      check_post(response: response)
    end

    it 'creates post only' do
      create(:user, login: login)

      expect { post(:create, params: { attributes: attributes }) }
        .to change { User.where(login: login).count }.by(0)
        .and change { Post.count }.by(1)

      expect(response).to have_http_status(:ok)
      check_post(response: response)
    end

    private

    def check_post(response:)
      post = Post.first
      body = JSON.parse(response.body)

      expect(post.id).to eq(body['id'])
      expect(post.title).to eq(body['title']).and eq(title)
      expect(post.content).to eq(body['content']).and eq(content)
    end

  end
end
