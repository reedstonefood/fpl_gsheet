require 'ostruct'

module FplGsheet
  class Player < OpenStruct # as in, football player, not an FPL manager
    #attr_reader :details

    def initialize(raw_hash, databank)
      super(raw_hash)
      @databank = databank
    end
    
    def full_name
      self.first_name + ' ' + self.second_name
    end
    
    def price # FPL stores £5.4m as 54, let's change it back
      (self.now_cost.to_f/10).round(1)
    end
  end
end