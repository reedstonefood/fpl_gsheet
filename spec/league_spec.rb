require "spec_helper"
require_relative "../lib/fpl_gsheet/league.rb"

RSpec.describe FplGsheet::League do

  context "league basic checks" do
    let (:l) { FplGsheet::League.new('539116') }
    it "is a League object" do
      expect(l).to be_a_kind_of(FplGsheet::League)
    end
    it "is called Pep is Bald" do
      expect(l.name).to eq("Pep Is Bald")
    end
    it "standings returns an Enumerable" do
      expect(l.standings).to be_a_kind_of(Enumerable)
    end
    it "has Niall top of the standings" do #may need to change this one! Was 148pts clear
      expect(l.standings.first['player_name']).to eq("Niall Danaher")
    end
  end
  
end
