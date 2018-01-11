## bots for openresearch
Task 1 - Retrieve CORE 2017 and 2018 ranking for event series from CORE potal
* from within Openresearch generate a CSV with event series to get CORE ranking and place them into a folder csv_files (sample CSV included in project folder csv_files)

setup usage with rvm and process event series:
* create a gemset
`$ rvm gemset create <gemset>`
* use created gemset
`$ rvm <ruby version>@<gemset>`
* install bundler gem
`$ gem install bundler`
* install necessary gems
`$ bundle`
* make script executable
`$ chmod +x <script_name.rb>`
* run script
`$ ./<script_name.rb>`
