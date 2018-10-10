require 'bundler'
require 'google_drive'
#Bundler.require
#with thanks to https://www.twilio.com/blog/2017/03/google-spreadsheets-ruby.html

module FplGsheet
  class Spreadsheet

    attr_reader :spreadsheet

    def initialize(spreadsheet_title)
      # Authenticate a session with your Service Account
      session = GoogleDrive::Session.from_service_account_key("client_secret.json")

      # Get the spreadsheet by its title
      @spreadsheet = session.spreadsheet_by_title(spreadsheet_title)
      @worksheet = @spreadsheet.worksheets.first # the default
      @max_row = @worksheet.num_rows
      @rows_to_add = Array.new
    end
    
    def new_sheet(sheet_name)
      doomed_ws = @spreadsheet.worksheet_by_title(sheet_name)
      doomed_ws.delete if !doomed_ws.nil?
      @worksheet = @spreadsheet.add_worksheet(sheet_name)
      @max_row = 1
      save
    end
    
    def insert_new_row(row_data)
      @rows_to_add << row_data
    end
    
    def insert_new_rows(row_data) # assumes array of arrays
      @rows_to_add += row_data
    end
    
    def save
      @worksheet.insert_rows(@max_row +1, @rows_to_add) if !@rows_to_add.empty?
      @worksheet.save
      @rows_to_add.clear # empty the array
      @max_row = @worksheet.num_rows
    end
    
    def all_rows
      @worksheet.rows
    end
  end
end