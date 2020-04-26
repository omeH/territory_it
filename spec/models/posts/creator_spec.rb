describe Posts::Creator do
  let(:login) { 'login' }
  let(:title) { 'title' }
  let(:content) { 'content' }
  let(:ip) { '192.168.1.1' }

  it 'creates nothing' do
    expect { described_class.new.create }.to change { Post.count }.by(0)
  end

  it 'creates user, author, rating and post records' do
    attributes = { login: login, title: title, content: content, ip: ip }
    expect { described_class.new(attributes: attributes).create }
      .to change { User.where(login: login).count }.by(1)
      .and change { Author.where(ip: ip).count }.by(1)
      .and change { Rating.count }.by(1)
      .and change { Post.where(title: title, content: content).count }.by(1)
  end

  it 'creates user, author, rating and post records' do
    create(:user, login: login)
    attributes = { login: login, title: title, content: content, ip: ip }

    expect { described_class.new(attributes: attributes).create }
      .to change { User.where(login: login).count }.by(0)
      .and change { Author.where(ip: ip).count }.by(1)
      .and change { Rating.count }.by(1)
      .and change { Post.where(title: title, content: content).count }.by(1)
  end
end
