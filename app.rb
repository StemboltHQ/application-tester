require 'sinatra'
require 'Haml'

  get '/' do
    haml :index
  end

  post '/redirection-test' do
    application = ApplicationTester.new(params[:url])
    "#{application.redirection_check}"
  end
require_relative 'lib/application_tester'
