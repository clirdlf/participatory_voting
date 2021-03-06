# Participatory Voting

[![Build Status](https://travis-ci.org/clirdlf/participatory_voting.svg?branch=main)](https://travis-ci.org/clirdlf/participatory_voting)

## MemberSuite Notes

## ConfTool Notes

To get the download for this, navigate to **Data Import and Export** on the **Overview** screen. Click on **Export Data** and select the following:

-   Under **Export Submission and Review Information, Reviewers and Session Details**
    -   **Export Contributions**
        -   Select **Include abstracts of submissions**
-   Click **Create Export File**

This will download an Excel spreadsheet that you need to open in LibreOffice (there is a bug in the Mac version of Excel with UTF-8 characters and CSV files). In LibreOffice, click **File -> Save As** and select **Text (CSV)** and tick the **Edit filter settings** box. Set the output to `lib/assets` for the project and click **Save**. On the next screen, make sure the **Character set** field is set to **Unicode (UTF-8)**.

No need to delete any old files; the `rake` task uses the most recently modified file.

> **Note**: Use [LibreOffice](https://www.libreoffice.org/) to save the Excel spreadsheet as a CSV.

## Setting Display Order

Open `lib/tasks/import.rake` and search for the `contribution_order` (around line 52). Set these values from the `contribution_type` field from the CSV in the order you want them displayed.

## Ignore Contribution Types

In the `lib/tasks/import.rake`, there is a task to add a `Proposal` to the database. There is an ignore list that you can simply place the strings used in ConfTool to ignore.

    contribution_type_ignore = ['LAC Preconference']

## Local Dependencies

`brew tap heroku/brew && brew install heroku`
`brew install postgresql`

## RVM

-   Install [RVM](https://rvm.io/)

    $ rvm install 3.0.1

## Project Setup

    $ cd projects
    $ git clone git@github.com:clirdlf/participatory_voting.git
    $ cd participatory_voting
    $ gem install bundler
    $ bundle install
    $ rake db:create
    $ rake db:migrate
    $ rake import:membersuite

## Postgresql

This system uses PostgreSQL for it's database backend.

To start the service:

    $ brew services postgresql start
    $ brew services postgresql stop

### Create the database

    $ cd path/to/project
    $ rake create:db

## Running the project

Open the project in atom.

    $ cd ~/projects/participatory_voting
    $ atom .

Edit the files

    $ git commit -am "message about what you just did"
    $ git push

Running the server:

    $ rails s

## Deploy

This project is set up to auto-deploy after tests pass on [travis](https://travis-ci.org/clirdlf/participatory_voting).

## Seeding the data

Run the `import:membersuite` task in the terminal. If you want to clear out the data first, run `rake reset`, but the `import:membersuite` task _should_ be idempotent and update any changes detected in the spreadsheet.

### Travis

Travis will deploy on pushes to `main`. You may need to update the token periodically ((see docs)[https://docs.travis-ci.com/user/deployment/heroku/]).

# Other Notes

-   [Sendgrid SPF Records](https://sendgrid.com/docs/Glossary/spf.html)

# Database

The database for this on Heroku has a limit of 10,000 records in the default deployment. However, the votes pushed us past this limit this year (2018). I had to run the following to move the database in to a paid plan:

From <https://devcenter.heroku.com/articles/upgrading-heroku-postgres-databases>

    heroku maintenance:on
    heroku pg:copy DATABASE_URL HEROKU_POSTGRESQL_BLUE_URL
    heroku pg:promote HEROKU_POSTGRESQL_BLUE_URL
    heroku maintenance:off

## Resetting

    heroku run rake reset DISABLE_DATABASE_ENVIRONMENT_CHECK=1

# Production Checklist

- [ ] Promote to **Hobby** level in Heroku
- [ ] Force TLS connection (`config/environments/production.rb`)
- [ ] Set default route to `root 'proposals#index'` (`config/routes.rb`)
- [ ] Remove last year's data (`heroku rails console` then `Proposal.destroy_all`)
- [ ] Load new data (`rake import:membersuite`)

# Prelaunch Tests

- [ ] Verify new account creation functions as expected
- [ ] Verify password reset functions as expected
- [ ] Verify votes are recorded
- [ ] Verify scrolling to different programs functions

# Post-Production Checklist

- [ ] Disable force TLS connection (`config/environments/production.rb`)
- [ ] Set default route to `root "pages#show", page: "home"` (in `config/routes.rb`)
- [ ] Demote to **Free** level in Heroku
