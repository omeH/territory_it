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

      authors.map { |ip, logins| { ip: ip.to_s, logins: logins } }
    end

  end
end
