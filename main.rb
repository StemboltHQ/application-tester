require_relative 'lib/application_tester'
require 'yaml'

begin
  file_name = ARGV[0]
  domain_list = YAML.load_file(file_name)
  domain_list.each do |domain|
    puts "\tTesting #{domain.colorize(:blue)}:"
    application_tester = ApplicationTester.new(domain)
    application_tester.test_from_command_line
  end
rescue
  puts "Something went wrong... Check your yaml file please!"
end
