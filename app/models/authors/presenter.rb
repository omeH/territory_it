module Authors
  class Presenter

    attr_accessor :logins

    def initialize(logins:)
      @logins = logins
    end

    def gather
      relation = UserIp.by_logins(logins)

      aggregate_clause = Arel.sql('ARRAY_AGG(DISTINCT users.login) AS logins')
      relation.select(:ip, aggregate_clause).group(:ip)
    end

  end
end
