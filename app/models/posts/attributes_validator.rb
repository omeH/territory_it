module Posts
  class AttributesValidator

    include ActiveModel::Validations

    CONSTRAINTS = {
      login: { length: 50 },
      title: { length: 200 },
    }.freeze

    attr_reader :attributes

    def initialize(attributes: {})
      @attributes = attributes
    end

    validate do
      if attributes[:login].blank?
        errors.add(:login, "#{I18n.t('attributes.login')} #{I18n.t('errors.messages.blank')}")
      end
      if attributes[:login].present?
        if !attributes[:login].match?(/^[\w]*$/) || attributes[:login].match?(/[\s]/)
          errors.add(:login, "#{I18n.t('attributes.login')} #{I18n.t('errors.messages.invalid')}")
        end

        length = CONSTRAINTS.dig(:login, :length)
        if attributes[:login].length > length
          errors.add(:login, "#{I18n.t('attributes.login')} #{I18n.t('errors.messages.too_long.other', count: length)}")
        end
      end

      if attributes[:title].blank?
        errors.add(:title, "#{I18n.t('attributes.title')} #{I18n.t('errors.messages.blank')}")
      end

      length = CONSTRAINTS.dig(:title, :length)
      if attributes[:title].present? && attributes[:title].length > length
        errors.add(:title, "#{I18n.t('attributes.title')} #{I18n.t('errors.messages.too_long.other', count: length)}")
      end

      if attributes[:content].blank?
        errors.add(:content, "#{I18n.t('attributes.content')} #{I18n.t('errors.messages.blank')}")
      end

      ip = IPAddr.new(attributes[:ip]) rescue nil
      errors.add(:ip, "IP #{I18n.t('errors.messages.invalid')}") unless ip

      self
    end

  end
end
