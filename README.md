# CareerNet

Herokuapp Link: http://careernet.herokuapp.com/

Client Interview Link: http://youtu.be/nVIXn0le4u8/

Clone into CareerNet
* `git clone careernet https://github.com/huangshan108/CareerNet.git`

Project and database setup
* `bundle install`
* `rake db:migrate`
* `rails server`

Then open web browser, go to `localhost:3000`

To seed database, run `rake db:seed:<seed_script>`

Currently avalible seed_scripts are (It's highly recommended that you reset your local db before seeding):
* `seed_students`
* `seed_events`
* `seed_jobs_and_companies`
* `seed_colleges`
* `seed_majors`

To test this app with tests accounts:
* For students, use `careernet.student+<id>@gmail.com`
* For companies, use `careernet.company+<id>@gmail.com`
* All test account passwords are `careernet`

To commit to this repo (if you are a collaborator)
* `git add <file-name>`
* `git commit -m <message>`
* `git push origin <branch>`

**Note:**
* We are using Ruby >= 2.0.0 and Rails >= 4.0.0
* ActionMailer on dev env will only work via port 3000
* No ActionMailer for test env are configured
