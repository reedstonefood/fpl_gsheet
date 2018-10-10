require 'recursive-open-struct'

module FplGsheet
  class Fixture < RecursiveOpenStruct
    #attr_reader :data
    def initialize(data, databank)
      super(data)
      @databank = databank
    end
  end
end