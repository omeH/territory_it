describe Api::V1::TopRatingsController, type: :controller do
  before(:each) do
    user = create(:user, login: 'login')
    create_list(:post, 15, user: user, average: rand(1.0..5.0))
  end

  it 'returns 5 posts if there is no limit' do
    get :index, params: {}

    expect(response).to have_http_status(:ok)
    expect(JSON.parse(response.body).size).to eq(5)
  end

  it 'returns limited posts' do
    get :index, params: { limit: 10 }

    expect(response).to have_http_status(:ok)
    expect(JSON.parse(response.body).size).to eq(10)
  end
end
