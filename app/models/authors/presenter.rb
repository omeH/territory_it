module Authors
  class Presenter

    attr_accessor :logins

    def initialize(logins:)
      @logins = logins
    end

    def gather
      relation = Author.by_logins(logins)

      aggregate_clause = Arel.sql('ARRAY_AGG(DISTINCT users.login)')
      authors = relation.group(:ip).pluck(:ip, aggregate_clause)

      Hash[authors.map { |ip, logins| [ip.to_s, logins] }]
    end

  end
end
