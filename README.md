# CareerNet

Client Interview Link: http://youtu.be/nVIXn0le4u8 

Clone into CareerNet
* `git remote add careernet https://github.com/huangshan108/CareerNet.git`
* `git clone careernet`

Project and database setup
**Note: We are using Ruby >= 2.0.0 and Rails >= 4.0.0**
* `bundle install`
* `rake db:migrate`
* `rails server`

Then open web browser, go to `localhost:3000`

To seed database, run `rake db:seed:<seed_script>`

Currently avalible seed_scripts are:
* `seed_students`
* `seed_events`
* `seed_jobs`

To commit to this repo (if you are a collaborator)
* `git add <file-name>`
* `git commit -m <message>`
* `git push careernet <branch>`
