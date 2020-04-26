describe Actions::Handler do
  context '#on_success' do
    it 'is executed when errors is nil' do
      action = double('action', errors: nil)
      result = false

      described_class.new(action: action).on_success { result = true }
      expect(result).to be_truthy
    end

    it 'is executed when errors is empty' do
      action = double('action', errors: [])
      result = false

      described_class.new(action: action).on_success { result = true }
      expect(result).to be_truthy
    end

    it 'is not executed when there are errors' do
      action = double('action', errors: %w[error])
      result = false

      described_class.new(action: action).on_success { result = true }
      expect(result).to be_falsey
    end
  end

  context '#on_fail' do
    it 'is not executed when errors is nil' do
      action = double('action', errors: nil)
      result = false

      described_class.new(action: action).on_fail { result = true }
      expect(result).to be_falsey
    end

    it 'is not executed when errors is empty' do
      action = double('action', errors: [])
      result = false

      described_class.new(action: action).on_fail { result = true }
      expect(result).to be_falsey
    end

    it 'is executed when there are errors' do
      action = double('action', errors: %w[error])
      result = false

      described_class.new(action: action).on_fail { result = true }
      expect(result).to be_truthy
    end
  end
end
