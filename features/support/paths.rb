# TL;DR: YOU SHOULD DELETE THIS FILE
#
# This file is used by web_steps.rb, which you should also delete
#
# You have been warned
module NavigationHelpers
  # Maps a name to a path. Used by the
  #
  #   When /^I go to (.+)$/ do |page_name|
  #
  # step definition in web_steps.rb
  #
  def path_to(page_name)
    case page_name

    when /^login page/ then '/account/login'
    when /^signup page/ then '/account/signup'
    when /^forgot password page/ then '/account/forgot-password'
    when /^logout page/ then '/account/logout'
    when /^list students page/ then '/profiles/students'
    when /^student profile page/ then '/profiles/student/1'
    when /^school profile page/ then '/profiles/school/1'
    when /^edit profile page/ then '/profiles/student/1/edit'
    when /(.+) view page/ then 
      split_page = page_name.split(' ').map(&:strip)
      job_id = split_page[2]
      '/jobs/' + job_id + '/view'
    when /jobs page/ then
      '/jobs/'
    when /^the events page$/ then '/events'
    when /^the main dashboard page$/ then'/dashboard'
    when /^the job create page$/ then '/jobs/new'

    # Add more mappings here.
    # Here is an example that pulls values out of the Regexp:
    #
    #   when /^(.*)'s profile page$/i
    #     user_profile_path(User.find_by_login($1))

    else
      begin
        page_name =~ /^the (.*) page$/
        path_components = $1.split(/\s+/)
        self.send(path_components.push('path').join('_').to_sym)
      rescue NoMethodError, ArgumentError
        raise "Can't find mapping from \"#{page_name}\" to a path.\n" +
          "Now, go and add a mapping in #{__FILE__}"
      end
    end
  end
end

World(NavigationHelpers)
