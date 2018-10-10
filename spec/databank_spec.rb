require "spec_helper"
require_relative "../lib/fpl_gsheet/databank.rb"

RSpec.describe FplGsheet::Databank do
  let (:d) { FplGsheet::Databank.new }
  context "teams" do
    let (:teams) { d.teams }
    it "returns an array of 20 Teams" do
      expect(teams).to be_a_kind_of(Array)
      expect(teams).to all(be_a_kind_of(FplGsheet::Team))
      expect(teams.count).to eq(20)
    end
    it "can find Arsenal" do
      expect(teams.find {|t| t.name=="Arsenal"}).to be_a_kind_of(FplGsheet::Team)
    end
  end
  
  context "players" do
    let (:players) { d.players }
    it "returns an array of players" do
      expect(players).to be_a_kind_of(Array)
      expect(players).to all(be_a_kind_of(FplGsheet::Player))
    end
    it "can find James Maddison" do
      expect(players.find {|t| t.full_name=="James Maddison"}).to be_a_kind_of(FplGsheet::Player)
    end
    
    it "can't find someone with first name of Satan" do
      expect(players.find {|t| t.first_name=="Satan"}).to eq(nil)
    end
    
    it "can't find John Doe" do
      expect(players.find {|t| t.full_name=="John Doe"}).to eq(nil)
    end
  end
end
