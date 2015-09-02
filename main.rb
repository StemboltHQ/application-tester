require_relative 'lib/application_tester'

url = ARGV[0]
application_tester = ApplicationTester.new(url)
application_tester.check_all
