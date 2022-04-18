# frozen_string_literal: true

# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

require 'faker'

contribution_types = [
  'Learn@DLF',
  '2022 DLF Forum',
  'Digital Preservation 2022: Preserving Legacy',
  'Digitizing Hidden Collections Symposium'
]

presentation_types = [
  'Three-hour Workshop',
  '45-minute Panel',
  '45-minute Workshop',
  '45-minute Working Session',
  '15-minute Presentation',
  '5-minute Lightning Talk',
  '45-minute Working Group Meeting',
  '15-minute Talk/Demo',
  '2-minute Lightning Talk/Poster',
  '45-minute DIY Session',
  '15-minute Paper',
  'Poster',
  '5-minute Demonstration Video'
]

13.times do |p|
  Proposal.create(
    author: Faker::Name.name,
    title: Faker::Book.title,
    abstract: Faker::Hipster.paragraph(sentence_count: 5),
    contribution_type: contribution_types.sample,
    contribution_format: presentation_types[p]
  )
end

# t.string "author"
# t.string "title"
# t.text "abstract"
# t.datetime "created_at", precision: 6, null: false
# t.datetime "updated_at", precision: 6, null: false
# t.string "contribution_type"
# t.string "contribution_format"
