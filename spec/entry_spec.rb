require "spec_helper"
require_relative "../lib/fpl_gsheet/entry.rb"
require_relative "../lib/fpl_gsheet/pick.rb"

RSpec.describe FplGsheet::Entry do

  context "entry basic checks" do
    let (:e) { FplGsheet::Entry.new('2702629') }
    it "is an Entry object" do
      expect(e).to be_a_kind_of(FplGsheet::Entry)
    end
    it "Niall Danaher" do
      expect(e.name).to eq("Niall Might Do It")
    end
    it "is managed by Niall Danaher" do
      expect(e.manager_name).to eq("Niall Danaher")
    end
  end
  
  context "transfers" do
    let (:e) { FplGsheet::Entry.new('2702629') }
    let (:t) { e.transfers }
    it "is Enumerable" do
      expect(t).to be_a_kind_of(Enumerable)
    end
    it "has the right details for the first transfer" do
      expect(t[0]["element_in_cost"]).to eq(55)
      expect(t[0]["element_out_cost"]).to eq(60)
      expect(t[0]["element_in"]).to eq(260)
      expect(t[0]["element_out"]).to eq(282)
      expect(t[0]["event"]).to eq(3)
    end
  end
  
  context "chips" do
    let (:e) { FplGsheet::Entry.new('2702629') }
    let (:c) { e.chips }
    it "used triple captain in week 2" do
      expect(c[0]["name"]).to eq("3xc")
      expect(c[0]["event"]).to eq(2)
    end
  end
  
  context "past seasons" do
    let (:e) { FplGsheet::Entry.new('2702629') }
    let (:ps) { e.past_seasons }
    it "had a blinder in 2015/16" do
      expect(ps.find {|x| x["season_name"]=="2015/16"}["rank"]).to eq(5736)
    end
  end
  
  context "gameweek history" do
    let (:e) { FplGsheet::Entry.new('2702629') }
    let (:gh) { e.gameweek_history }
    it "had a good first week" do
      expect(gh.find {|x| x["event"]==1}["rank"]).to eq(13594)
      expect(gh.find {|x| x["event"]==1}["points"]).to eq(100)
    end
  end
  
  context "picks" do
    let (:e) { FplGsheet::Entry.new('2702629') }
    let (:p) { e.picks_for_gameweek(1)}
    it "is an array of Picks" do
      expect(p).to be_a_kind_of(Array)
      expect(p).to all(be_a_kind_of(FplGsheet::Pick))
    end
  end
end

RSpec.describe FplGsheet::Entries do

  context "basic checks" do
    let (:es) { FplGsheet::Entries.new}
    it "returns an Entry" do
      expect(es[2702629]).to be_a_kind_of(FplGsheet::Entry)
    end
  end
end