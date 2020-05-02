describe Posts::AttributesValidator do
  it 'populates errors when attributes are empty' do
    validator = described_class.new(attributes: {}).validate

    expect(validator.errors).to include("Login can't be blank")
    expect(validator.errors).to include("Title can't be blank")
    expect(validator.errors).to include("Content can't be blank")
    expect(validator.errors).to include('IP is invalid')
  end

  it 'populates errors when attributes are blank' do
    attributes = { login: '', title: '', content: '', ip: '' }
    validator = described_class.new(attributes: attributes).validate

    expect(validator.errors).to include("Login can't be blank")
    expect(validator.errors).to include("Title can't be blank")
    expect(validator.errors).to include("Content can't be blank")
    expect(validator.errors).to include('IP is invalid')
  end

  it 'populates login error when attribute is invalid' do
    validator = described_class.new(attributes: { login: 'login test' }).validate
    expect(validator.errors).to include('Login is invalid')

    validator = described_class.new(attributes: { login: 'login!@#$' }).validate
    expect(validator.errors).to include('IP is invalid')

    validator = described_class.new(attributes: { login: "login\ntest" }).validate
    expect(validator.errors).to include('IP is invalid')
  end

  it 'populates login error when attribute is too long' do
    length = described_class::CONSTRAINTS.dig(:login, :length)
    validator = described_class.new(attributes: { login: 'l' * length.next }).validate
    expect(validator.errors).to include("Login is too long (maximum is #{length} characters)")
  end

  it 'populates title error when attribute is too long' do
    length = described_class::CONSTRAINTS.dig(:title, :length)
    validator = described_class.new(attributes: { title: 't' * length.next }).validate
    expect(validator.errors).to include("Title is too long (maximum is #{length} characters)")
  end

  it 'populates ip error when attribute is invalid' do
    validator = described_class.new(attributes: { ip: '192.' }).validate
    expect(validator.errors).to include('IP is invalid')

    validator = described_class.new(attributes: { ip: 'invalid string' }).validate
    expect(validator.errors).to include('IP is invalid')
  end

  it 'does not populate errors' do
    attributes = { login: 'login', title: 'title', content: 'content', ip: '192.168.1.1' }
    validator = described_class.new(attributes: attributes).validate

    expect(validator.errors).to be_empty
  end
end
