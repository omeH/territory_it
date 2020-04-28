describe Api::V1::TopRatingsController, type: :controller do
  before(:each) do
    user = create(:user, login: 'login')
    create_list(:post, 15, user: user, average: rand(1.0..5.0))
  end

  it 'returns 1 posts if there is no limit' do
    get :index, params: {}

    expect(response).to have_http_status(:ok)
    expect(JSON.parse(response.body).size).to eq(1)
  end

  it 'returns limited posts' do
    limit = 10
    get :index, params: { limit: limit }

    expect(response).to have_http_status(:ok)
    expect(JSON.parse(response.body).size).to eq(limit)
  end

  it 'returns posts according to per page' do
    per_page = 5
    get :index, params: { limit: 10, per_page: per_page }

    expect(response).to have_http_status(:ok)
    expect(JSON.parse(response.body).size).to eq(per_page)
  end
end
