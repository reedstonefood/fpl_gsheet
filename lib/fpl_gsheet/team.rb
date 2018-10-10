require 'recursive-open-struct'

module FplGsheet
  class Team < RecursiveOpenStruct
    #attr_reader :data
    def initialize(data, databank)
      super(data)
      @databank = databank
      @id = data['id']
      #@fixtures = fixtures.map { |f| TeamFixture.new(f, @data['id']) }
    end
    
    def fixtures
      @databank.fixtures.collect do |f| 
        fixture.team_h = id || fixture.team_a = id
      end
    end
  end
  
  class FixtureTeam
    def initialize(fixture,team_id)
      @fixture=fixture
      @venue = fixture.data['team_h']==team_id ? 'H' : 'A'
      @h_score = fixture.data['team_h_score']
      @a_score = fixture.data['team_a_score']
    end

    def result
      return '-' if @h_score=='null'
      return 'D' if @h_score==@a_score
      winner = @h_score==@a_score ? 'H' : 'A'
      return @venue==winner ? 'W' : 'L'
    end

    def own_score
      @venue=='H' ? @h_score : @a_score
    end

    def opp_score
      @venue=='H' ? @a_score : @h_score
    end

    def opponent
      id = @venue=='H' ? @fixture['team_a'] : @fixture['team_h']
      # How to get from this id to the Team object it represents?
    end
    
  end
end