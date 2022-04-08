# frozen_string_literal: true

# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

# require 'faker'

# contribution_types = [
#   '2021 DLF Forum',
#   'Digital Preservation 2021',
#   'Learn@DLF'
# ]

# presentation_types = [
#   '55-minute Panel',
#   '18-minute Presentation',
#   '18-Minute Talks/Demos',
#   '7-Minute Snapshot (7x7)',
#   'Breakfast/Lunch Working Session'
# ]

# 10.times do |_p|
#   Proposal.create(
#     author: Faker::Name.name,
#     title: Faker::Book.title,
#     abstract: Faker::Hipster.paragraph(sentence_count: 5),
#     contribution_type: contribution_types.sample,
#     contribution_format: presentation_types.sample
#   )
# end

# t.string "author"
# t.string "title"
# t.text "abstract"
# t.datetime "created_at", precision: 6, null: false
# t.datetime "updated_at", precision: 6, null: false
# t.string "contribution_type"
# t.string "contribution_format"
