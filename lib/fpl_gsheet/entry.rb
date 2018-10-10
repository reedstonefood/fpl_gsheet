
module FplGsheet
  class Entry
    attr_reader :name, :id
    def initialize(entry_id)
      entry_json=JSON.load(open("https://fantasy.premierleague.com/drf/entry/#{entry_id}/transfers", {ssl_verify_mode: 0}))
      @entry_data=entry_json['entry']
      @league_data=entry_json['leagues']
      @name=@entry_data['name']
      @id=@entry_data['id']
      @historical_gameweeks = Hash.new()
      #@fixtures = fixtures.map { |f| TeamFixture.new(f, @data['id']) }
    end
  
    def manager_name
      @entry_data['player_first_name'] + ' ' + @entry_data['player_last_name']
    end
  
    def history
      @history ||= JSON.load(open("https://fantasy.premierleague.com/drf/entry/#{id}/history", {ssl_verify_mode: 0}))
    end
  
    
    def transfers
      @transfer_data ||= JSON.load(open("https://fantasy.premierleague.com/drf/entry/#{id}/transfers", {ssl_verify_mode: 0}))
      @transfer_data["history"]
    end
    
    def chips; history["chips"]; end
    
    def summary; history["entry"]; end
    
    def past_seasons; history["season"]; end
    
    def gameweek_history; history["history"]; end
    
    def picks
      latest_gameweek = gameweek_history.last['event']
      picks_for_gameweek[latest_gameweek]
    end
    
    def picks_for_gameweek(gw)
      return @historical_gameweeks[gw] if @historical_gameweeks.key?(gw)
      api ||= JSON.load(open("https://fantasy.premierleague.com/drf/entry/#{id}/event/#{gw}/picks", {ssl_verify_mode: 0}))
      @historical_gameweeks[gw] = api['picks'].map { |p| Pick.new(p)}
    end
    
  end
  
  class Entries < Hash
  
    def [](key)
      val = super
      if val.nil?
        # Load it
        val = Entry.new(key)
        # Cache it so we don't have to create the Entry again
        self[key] = val
      end

      val
    end
  end
  
end