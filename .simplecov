SimpleCov.command_name 'RSpec'

SimpleCov.start do
  # any custom configs like groups and filters can be here at a central place

  add_filter '/app/avo'
  add_filter '/spec/'
  add_filter '/config/'
  add_filter '/db/'

  add_group 'Controllers', 'app/controllers'
  add_group 'Models', 'app/models'
end
