
module FplGsheet
  class Pick
    def initialize(input_hash)
    
      @input_hash = input_hash
      #@fixtures = fixtures.map { |f| TeamFixture.new(f, @data['id']) }
    end
  
    def player_id
      @input_hash['element']
    end
  
    #def selling_price
    #  @input_hash['selling_price'].to_f/10).round(1)
    #end
  
    def captain?; @input_hash['is_captain']; end
    def vice_captain?; @input_hash['is_vice_captain']; end
    def multiplier; @input_hash['multiplier']; end
  
    # the above 5 are the only ones that show up all the time, eg this page
    # https://fantasy.premierleague.com/drf/entry/483663/event/1/picks
    # There's also this...
    # https://fantasy.premierleague.com/drf/my-team/483663/ NUTS this is only if you are logged in :(
   
   def on_bench? #not subsititue? cos you could be subbed on
     return @input_hash['position'] > 11
   end
   
    # can_sub, has_played, can_captain
    
  end
  
  
end