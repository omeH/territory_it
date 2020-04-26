module Posts
  class AttributesValidator

    attr_reader :attributes, :errors

    def initialize(attributes: {})
      @attributes = attributes
      @errors = []
    end

    def validate
      if attributes[:login].blank?
        errors << "#{I18n.t('attributes.login')} #{I18n.t('errors.messages.blank')}"
      end
      if attributes[:login].present? && !attributes[:login].match?(/^[\w_]*$/)
        errors << "#{I18n.t('attributes.login')} #{I18n.t('errors.messages.invalid')}"
      end

      if attributes[:title].blank?
        errors << "#{I18n.t('attributes.title')} #{I18n.t('errors.messages.blank')}"
      end

      if attributes[:content].blank?
        errors << "#{I18n.t('attributes.content')} #{I18n.t('errors.messages.blank')}"
      end

      ip = IPAddr.new(attributes[:ip]) rescue nil
      errors << "IP #{I18n.t('errors.messages.invalid')}" unless ip

      self
    end

  end
end
