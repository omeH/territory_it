describe Actions::TimeTracker do
  it 'does not store result' do
    allow(described_class.instance).to receive(:enabled).and_return(false)

    expect { described_class.instance.track(request: :request) {} }
      .to change { Trail.count }.by(0)
  end

  it 'stores result' do
    request = double('request', fullpath: '/fullpath', params: {})
    allow(described_class.instance).to receive(:enabled).and_return(true)

    expect { described_class.instance.track(request: request) {} }
      .to change { Trail.count }.by(1)
  end
end
