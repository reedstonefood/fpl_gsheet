
module FplGsheet
  class League
    attr_reader :name, :id
    def initialize(league_id)
      @league_data=JSON.load(open("https://fantasy.premierleague.com/api/leagues-classic/#{league_id}/standings/", {ssl_verify_mode: 0}))
      @name=@league_data['league']['name']
      @id=@league_data['league']['id']
      #@fixtures = fixtures.map { |f| TeamFixture.new(f, @data['id']) }
    end

    def standings
      @standings ||= @league_data['standings']['results']
    end

  end

end