require "spec_helper"
require_relative "../lib/fpl_gsheet/spreadsheet.rb"

RSpec.describe FplGsheet::Spreadsheet do

  context "databank basic checks" do
    let (:s) { FplGsheet::Spreadsheet.new('FPL-databank_1819') }
    it "is a spreadsheet object" do
      expect(s.spreadsheet).to be_a_kind_of(GoogleDrive::Spreadsheet)
    end
  end
  
end
