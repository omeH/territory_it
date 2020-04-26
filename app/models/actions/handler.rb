module Actions
  class Handler

    attr_reader :action

    def initialize(action:)
      @action = action
    end

    def on_success
      yield if action.errors.nil? || action.errors&.empty?
    end

    def on_fail
      yield if action.errors&.any?
    end

  end
end
