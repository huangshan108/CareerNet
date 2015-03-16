# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)


require File.join(Rails.root, 'db', 'seeds', 'seed_students.rb')
require File.join(Rails.root, 'db', 'seeds', 'seed_events.rb')
require File.join(Rails.root, 'db', 'seeds', 'seed_jobs_and_companies.rb')
require File.join(Rails.root, 'db', 'seeds', 'seed_colleges.rb')
require File.join(Rails.root, 'db', 'seeds', 'seed_majors.rb')