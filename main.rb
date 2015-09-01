require_relative 'lib/application_tester'

begin
  domain = ARGV[0]
  application_tester = Application_tester.new(domain)
  application_tester.test_from_command_line
rescue
  puts "Check your input"
end

