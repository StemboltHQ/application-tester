require_relative 'lib/application_tester'

url = ARGV[0]
application_tester = Application_tester.new(url)
application_tester.check_all
