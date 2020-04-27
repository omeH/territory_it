describe Api::V1::RatingsController, type: :controller do
  let!(:user) { create(:user, login: 'login') }
  let!(:post) { create(:post, user: user) }

  it 'returns error where there is no post' do
    put :update, params: { id: post.id.next, value: 1 }

    expect(response).to have_http_status(:not_found)
  end

  it 'updates rating when value is minimal' do
    expect { put :update, params: { id: post.id, value: 1 } }
      .to change { post.reload.average }.by(1.0)

    expect(response).to have_http_status(:ok)
    expect(response.body).to include('"rating":1.0')
  end

  it 'updates rating when value is in range between minimal and maximum' do
    expect { put :update, params: { id: post.id, value: 3 } }
      .to change { post.reload.average }.by(3.0)

    expect(response).to have_http_status(:ok)
    expect(response.body).to include('"rating":3.0')
  end

  it 'updates rating when value is maximum' do
    expect { put :update, params: { id: post.id, value: 5 } }
      .to change { post.reload.average }.by(5.0)

    expect(response).to have_http_status(:ok)
    expect(response.body).to include('"rating":5.0')
  end

  it 'updates rating when value is less than minimal' do
    expect { put :update, params: { id: post.id, value: 0 } }
      .to change { post.reload.average }.by(1.0)

    expect(response).to have_http_status(:ok)
    expect(response.body).to include('"rating":1.0')
  end

  it 'updates rating when value is blank' do
    expect { put :update, params: { id: post.id } }
      .to change { post.reload.average }.by(1.0)

    expect(response).to have_http_status(:ok)
    expect(response.body).to include('"rating":1.0')
  end

  it 'updates rating when value is more than maximum' do
    expect { put :update, params: { id: post.id, value: 6 } }
      .to change { post.reload.average }.by(5.0)

    expect(response).to have_http_status(:ok)
    expect(response.body).to include('"rating":5.0')
  end
end
