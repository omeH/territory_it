module Posts
  class AttributesValidator

    attr_reader :attributes, :errors

    def initialize(attributes: {})
      @attributes = attributes
      @errors = []
    end

    def self.constraints
      {
        login: { length: 50 },
        title: { length: 200 },
      }.freeze
    end

    def validate
      if attributes[:login].blank?
        errors << "#{I18n.t('attributes.login')} #{I18n.t('errors.messages.blank')}"
      end
      if attributes[:login].present?
        unless attributes[:login].match?(/^[\w_]*$/)
          errors << "#{I18n.t('attributes.login')} #{I18n.t('errors.messages.invalid')}"
        end

        length = self.class.constraints.dig(:login, :length)
        if attributes[:login].length > length
          errors << "#{I18n.t('attributes.login')} #{I18n.t('errors.messages.too_long.other', count: length)}"
        end
      end

      if attributes[:title].blank?
        errors << "#{I18n.t('attributes.title')} #{I18n.t('errors.messages.blank')}"
      end

      length = self.class.constraints.dig(:title, :length)
      if attributes[:title].present? && attributes[:title].length > length
        errors << "#{I18n.t('attributes.title')} #{I18n.t('errors.messages.too_long.other', count: length)}"
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
