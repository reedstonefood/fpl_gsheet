# Fpl_Gsheet

A Ruby gem for extracting information from [Fantasy Premier League](https://fantasy.premierleague.com/a/home) & storing the information in a Google Sheet, for onwards analysis.

For example, you could use Tableau Public to access the Google Sheet and create some great visualisations.

## Installation

1. Install the gem.
gem install fpl_gsheet

2. To allow the gem access to a Google sheet, the following steps must be followed.

* Create a Google service account
* Store the client_secret.json file in the same location as the script you write that uses this gem
* Create a google sheet & share it (giving it edit access) with the user created in the first step
More detailed instructions & a nice animated gif can be [found here](https://www.twilio.com/blog/2017/03/google-spreadsheets-ruby.html).


## Usage

```ruby
gem 'fpl_gsheet'

# stores all "generic" data, eg teams, players, fixtures
databank = FplGsheet::Databank.new

# put the reference to your spreadsheet here.
# This must already exist & have been shared with the service account
spreadsheet = FplGsheet::Spreadsheet.new('FplGsheet sample')

# Put all team names into the spreadsheet
spreadsheet.new_sheet('Teams')
spreadsheet.add_row(['Team ID', 'Team Name']) # header row
databank.teams.each do |t|
  spreadsheet.insert_new_row([t['id'], t['name'])
end
spreadsheet.save # commits the changes you've written

# load a league - the ID can be found in the URL of the league table page,
# eg https://fantasy.premierleague.com/a/leagues/standings/487590/classic
league = FplGsheet::League.new(487590)

# Put team names & score into spreadsheet
spreadsheet.new_sheet('League')
spreadsheet.insert_new_row(%w(Rank Team Score))

league.standings.each do |s|
  spreadsheet.insert_new_row([
    s['rank'],
    s['entry_name'],
    s['total']
  ])
end
spreadsheet.save
```

## More usage information

See the wiki on the [GitHub repo page](https://github.com/reedstonefood/fpl_gsheet).