require "spec_helper"
require_relative "../lib/fpl_gsheet/league.rb"

RSpec.describe FplGsheet::League do

  context "league basic checks" do
    let (:l) { FplGsheet::League.new('55432') }
    it "is a League object" do
      expect(l).to be_a_kind_of(FplGsheet::League)
    end
    it "is called Bungy's Boys" do
      expect(l.name).to eq("Bungy's Boys")
    end
    it "standings returns an Enumerable" do
      expect(l.standings).to be_a_kind_of(Enumerable)
    end
    it "has David top of the standings" do
      expect(l.standings.first['player_name']).to eq("David Peeling")
    end
  end

end
