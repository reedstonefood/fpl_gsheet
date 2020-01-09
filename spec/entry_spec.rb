require "spec_helper"
require_relative "../lib/fpl_gsheet/entry.rb"
require_relative "../lib/fpl_gsheet/pick.rb"

RSpec.describe FplGsheet::Entry do

  context "entry basic checks" do
    let (:e) { FplGsheet::Entry.new('13190') }
    it "is an Entry object" do
      expect(e).to be_a_kind_of(FplGsheet::Entry)
    end
    it "Cherrywood Village" do
      expect(e.name).to eq("Cherrywood Village")
    end
    it "is managed by David Peeling" do
      expect(e.manager_name).to eq("David Peeling")
    end
  end

  context "transfers" do
    let (:e) { FplGsheet::Entry.new('13190') }
    let (:t) { e.transfers }
    it "is Enumerable" do
      expect(t).to be_a_kind_of(Enumerable)
    end
    it "has the right details for the first transfer" do
      expect(t[0]["element_in_cost"]).to eq(55)
      expect(t[0]["element_out_cost"]).to eq(60)
      expect(t[0]["element_in"]).to eq(122)
      expect(t[0]["element_out"]).to eq(141)
      expect(t[0]["event"]).to eq(3)
    end
  end

  context "chips" do
    let (:e) { FplGsheet::Entry.new('673531') }
    let (:c) { e.chips }
    it "used wildcard in week 3" do
      expect(c[0]["name"]).to eq("wildcard")
      expect(c[0]["event"]).to eq(3)
    end
  end

  context "past seasons" do
    let (:e) { FplGsheet::Entry.new('673531') }
    let (:ps) { e.past_seasons }
    it "had a good season in 2017/18" do
      expect(ps.find {|x| x["season_name"]=="2017/18"}["rank"]).to eq(277873)
    end
  end

  context "gameweek history" do
    let (:e) { FplGsheet::Entry.new('673531') }
    let (:gh) { e.gameweek_history }
    it "had a good first week" do
      expect(gh.find {|x| x["event"]==1}["rank"]).to eq(397365)
      expect(gh.find {|x| x["event"]==1}["points"]).to eq(88)
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