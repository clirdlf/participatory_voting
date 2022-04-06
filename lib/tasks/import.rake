# frozen_string_literal: true

require 'csv'
require 'roo'

desc 'Convenience wrapper for resetting the database'
#task reset: ['db:reset', 'import:conftool']

def latest_csv
  # get the last updated CSV file from lib/assets
  Dir.glob('./lib/assets/*.csv').max_by { |f| File.mtime(f) }
end

def latest_excel
  Dir.glob('./lib/assets/*.xls*').max_by { |f| File.mtime(f) }
end

def latest_export(extension)
  Dir.glob("./lib/assets/*#{extension}").max_by { |f| File.mtime(f) }
end

def add_csv(csv, ignore = [], order = [])
  contribution_type_ignore = ignore

  contribution_order = order

  CSV.foreach(csv, headers: true, encoding: 'UTF-8') do |row|
    puts "Adding #{row['title']}"
    unless contribution_type_ignore.include? row['contribution_type']
      Proposal.find_or_create_by!(id: row['paperID']) do |proposal|
        proposal.author              = row['authors'],
        proposal.title               = row['title'],
        proposal.abstract            = row['abstract'],
        proposal.contribution_type   = row['contribution_type']
        proposal.contribution_format = row['contribution_format']

        proposal.order = contribution_order.index(row['contribution_type'])
      end
    end
  end
end

namespace :db do
  namespace :heroku do
    desc 'Create a heroku database backup'
    task backup: :environment do
      puts 'Creating a snapshot of the database on heroku'
      `heroku pg:backups capture`
    end

    desc 'Download a heroku database backup'
    task download: :environment do
      puts 'Downloading the latest database snapshot'
      # system("curl -o voting-#{Time.now.strftime('%Y-%m-%d_%H-%M-%S')}.dump #{url}")
      puts "Run the following command: \nheroku pg:backups:download"
      puts "\n See https://devcenter.heroku.com/articles/heroku-postgres-backups#restoring-backups for restoring database"
    end

    desc 'Download and restore the production database locally'
    task local_restore: :environment do
      `rm latest.dump*`
      `heroku pg:backups capture`
      `heroku pg:backups:download`
      `pg_restore --verbose --clean --no-acl --no-owner -h localhost -d voting_development latest.dump`
    end
  end
end

namespace :report do
  desc 'Generate report for voting; see https://gist.github.com/waynegraham/664a8d627168d51cea71836c6a20a060 for special sauce'
  task generate: :environment do
    # ActiveRecord::Base.establish_connection('development')
    ActiveRecord::Base.connection.execute("COPY (SELECT title, cached_votes_total, contribution_type FROM proposals ORDER BY contribution_type, cached_votes_total DESC) TO '#{Rails.root.join('report.csv')}' WITH CSV DELIMITER ',';")
  end
end

namespace :import do
  desc 'Import Excel file'
  task excel: :environment do
    contribution_type_ignore = ['']

    contribution_order = [
      'Learn@DLF',
      '2022 DLF Forum',
      'Digital Preservation 2022'
    ]

    converted = Roo::Spreadsheet.open(latest_excel, headers: true).to_csv

    add_csv(converted)
  end

  desc 'Import MemberSuite file'
  task membersuite: :environment do
    contribution_type_ignore = ['']

    contribution_order = [
      'DLF Forum',
      'NDSA\'s DigiPres',
      'Learn@DLF'
    ]

    workbook = Roo::Spreadsheet.open(latest_excel, headers: true)
    workbook.default_sheet = workbook.sheets[0]

    headers = {}
    workbook.row(1).each_with_index { |header, i| headers[header] = i }

    ((workbook.first_row + 1)..workbook.last_row).each do |row|
      id = workbook.row(row)[headers['ID']]
      name = workbook.row(row)[headers['Name']]
      author       = workbook.row(row)[headers['Entrant']]
      abstract     = workbook.row(row)[headers['Abstract: max 50 words for all formats.']]
      format_long  = workbook.row(row)[headers['Submission Format: Select the format of your submission.']].to_s
      split_format = format_long.split(' - ')

      puts "Adding #{name}"

      Proposal.find_or_create_by!(id: id) do |proposal|
        # NOTE: for some reason, the field in the first position adds the entire
        # record to the string. Reordered to a field that is not displayed to
        # go around the problem
        proposal.author              = author,
        proposal.title               = name,
        proposal.abstract            = abstract,
        proposal.contribution_format = split_format[1],
        proposal.contribution_type   = split_format[0]
        proposal.order               = contribution_order.index(split_format[0])
      end
    end
  end

  desc 'Import propo from ConfTool dump'
  task conftool: :environment do
    # contribution_type_ignore = ['LAC Preconference']
    contribution_type_ignore = ['']

    contribution_order = [
      'Learn@DLF',
      '2022 DLF Forum',
      'Digital Preservation 2022: Preserving Legacy'
    ]

    # add_csv(latest_csv)

    CSV.foreach(latest_csv, headers: true, encoding: 'UTF-8') do |row|
      puts "Adding #{row['title']}"
      unless contribution_type_ignore.include? row['contribution_type']
        Proposal.find_or_create_by!(id: row['paperID']) do |proposal|
          proposal.author              = row['authors'],
          proposal.title               = row['title'],
          proposal.abstract            = row['abstract'],
          proposal.contribution_type   = row['contribution_type']
          proposal.contribution_format = row['contribution_format']

          proposal.order = contribution_order.index(row['contribution_type'])
        end
      end
    end
  end
end

namespace :reset do
  desc 'Clean out the proposals, leave the people'
  task :proposals do
    Proposal.destroy_all
    sh 'rake import:conftool'
  end
 
  # task proposals: [:environment, 'db:heroku:backup', 'db:heroku:download'] do
  #   Proposal.destroy_all
  # end
end
