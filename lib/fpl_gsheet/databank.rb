require 'json'
require 'open-uri'
require_relative 'team.rb'
require_relative 'fixture.rb'
require_relative 'player.rb'


module FplGsheet

  class Databank
    def initialize
      #some stuff outside the scope of this review
      #just assume the fixtures and teams methods work
      @all_data=JSON.load(open("https://fantasy.premierleague.com/api/bootstrap-static/", {ssl_verify_mode: 0}))
      @fixture_data=JSON.load(open("https://fantasy.premierleague.com/api/fixtures/", {ssl_verify_mode: 0}))
    end

    def fixtures
      #returns array of all Fixtures
      @fixtures ||= @fixture_data.map { |f| Fixture.new(f, self) }
    end

    def teams
      #returns array of all Teams
      return @teams if defined? @teams
      @teams = @all_data['teams'].map do |t|
        Team.new(t, self)
      end
    end

    def players
      return @players if defined? @players
      @players = @all_data['elements'].map do |t|
        Player.new(t, self)
      end
    end

    def fixtures_for_team(id)
      fixtures.select do |f|
        id==f.data['team_h'] || id==f.data['team_a']
      end
    end

    def gameweeks
      @gameweeks ||= @all_data['events']
    end
  end

  #class Fixture
  #  attr_reader :data
  #  def initialize(data)
  #    @data = data
  #  end
  #end
  #
  #class Team
  #  attr_reader :data, :fixtures
  #  def initialize(data, fixtures)
  #    @data = data
  #    @fixtures = fixtures.map { |f| TeamFixture.new(f, @data['id']) }
  #  end
  #end

  #class TeamFixture
  #  attr_reader :fixture, :venue
  #  def initialize(fixture,team_id)
  #    @fixture=fixture
  #    @venue = fixture.data['team_h']==team_id ? 'H' : 'A'
  #    @h_score = fixture.data['team_h_score']
  #    @a_score = fixture.data['team_a_score']
  #  end
  #
  #  def result
  #    return '-' if @h_score=='null'
  #    return 'D' if @h_score==a_score
  #    winner = @h_score==@a_score ? 'H' : 'A'
  #    return @venue==winner ? 'W' : 'L'
  #  end
  #
  #  def own_score
  #    @venue=='H' ? @h_score : @a_score
  #  end
  #
  #  def opp_score
  #    @venue=='H' ? @a_score : @h_score
  #  end
  #
  #  def opponent
  #    id = @venue=='H' ? @fixture['team_a'] : @fixture['team_h']
  #    # How to get from this id to the Team object it represents?
  #  end
  #end
end

#d = Databank.new
#d.teams.each do |t|
#  puts "#{t.data['name'].upcase} are playing these teams..."
#  if t.data['name']=='Arsenal'
#    t.fixtures.each do |tf|
#      puts "#{tf.fixture.data['kickoff_time_formatted']}, #{tf.own_score} - #{tf.opp_score}"
#    end
#  end
#end