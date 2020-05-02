module Authors
  class Finder

    attr_accessor :logins

    def initialize(logins:)
      @logins = logins
    end

    def find
      login_binds = ['(?)'] * logins.size
      condition = "users.login IN (VALUES #{login_binds.join(', ')})"

      relation = UserIp.joins(:user).where(condition, *logins)

      aggregate_clause = Arel.sql('ARRAY_AGG(DISTINCT users.login) AS logins')
      relation.select(:ip, aggregate_clause).group(:ip)
    end

  end
end
