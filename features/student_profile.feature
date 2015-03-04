Feature: Students can create and/or modify profiles

	As a student, I want to update my profiles so that companies can know me better when I submit an application

Background: I have already created a CareerNet account

Scenario: I just signed up, and I don't have a profile yet

	Given that I am on the 'create profile page' page
	Then I should see a form for entering my information
	
	And I should see a section called 'Basic information' in the form
	And I should see the following text boxes under 'Basic information' section: 'First name', 'Last name', 'Date of birth', 'Major', 'Graduation date'
	
	And I should see a section called 'Experiences' in the form
	And I should see the 'add experience' button under 'Experiences' section
	When I click on 'add experience' button
	Then I should see a block with following text boxes: 'Company', 'Start date', 'End date', 'Role', 'Description', 'Income', 'Supervisor'
	Then I should be able to enter information in the boxes
	And I should see a button called 'Remove experience'
	When I click on 'Remove experience'
	Then the block should disappear
	
	And I should see radio buttons with following options: 'Looking for jobs', 'I already have a job', 'Don't put me into the job marcket'
	And I should be able to make selections and change my selections
	And only one option should be highlighted at any given time

	And I should see a button called 'upload resume'
	When I click on 'upload resume'
	I should be able to browse files on my local machine
	When I select a file and confirm
	I should see “Resume uploaded” along with the filename

	Then I should see the following buttons: 'Save profile', 'Discard changes'
	When I click on 'Save profile' or 'Discard changes'
	Then I should be redirected to the home page
	Given that I clicked on 'Save changes'
	Then I should see a prompt “Profile saved”
	
Scenario: I already have a profile, but I want to change my profile

	Given that I am on the modify profile page' page
	Then I should see a form for entering my information
	
	And I should see a section called 'Basic information' in the form
	And I should see the following text boxes under 'Basic information' section: 'First name' => 'Randy', 'Last name' => 'Wei', 'Date of birth' => '0X-XX-1992', 'Major' => 'EECS', 'Graduation date' => 'May 2015'
	
	And I should see a section called 'Experiences' in the form
	And I should see a block with my existing experience: 'Company' => 'XXX', 'Start date' => '05-19-2014', 'End date' => '08-22-2014', 'Role' => 'Developer', 'Description' => 'abcde fghijklmnopqrst uvwxyz', 'Income' => '$X', 'Supervisor' => 'Carol'

	And I should see the 'add experience' button under 'Experiences' section
	When I click on 'add experience' button
	Then I should see a block with following text boxes: 'Company', 'Start date', 'End date', 'Role', 'Description', 'Income', 'Supervisor'
	Then I should be able to enter information in the boxes
	And I should see a button called 'Remove experience'
	When I click on 'Remove experience'
	Then the block should disappear
	
	And I should see radio buttons with following options: 'Looking for jobs', 'I already have a job', 'Don't put me into the job marcket'
	And I should see my previous selection 'Looking for jobs'
	And I should be able to change my selections
	And only one option should be highlighted at any given time

	And I should see my old resume 'resume.pdf'
	And I should see a button called 'upload resume'
	When I click on 'upload resume'
	I should be able to browse files on my local machine
	When I select a file and confirm
	I should see “Resume uploaded” along with the filename of new resume

	Then I should see the following buttons: 'Save profile', 'Discard changes'
	When I click on 'Save profile' or 'Discard changes'
	Then I should be redirected to the home page
	Given that I clicked on 'Save changes'
	Then I should see a prompt “Profile saved”
