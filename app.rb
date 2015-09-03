require 'sinatra'
require 'Haml'
require_relative 'lib/application_tester'

  get '/' do
    haml :index
  end

  post '/application-test' do
    haml :application_test, layout: (request.xhr? ? false : :layout)
  end

  post '/markup-test' do
    haml :markup_test, layout: (request.xhr? ? false : :layout)
  end
