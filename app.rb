require 'sinatra'
require 'Haml'

  get '/' do
    haml :index
  end

  post '/redirection-test' do
    application = ApplicationTester.new(params[:url])
    "#{application.redirection_check}"
  end

  post '/robots-file-test' do
    application = Application_tester.new(params[:url])
    "#{application.robots_check}"
  end

  post '/sitemaps-test' do
    application = Application_tester.new(params[:url])
    "#{application.sitemap_check}"
  end
require_relative 'lib/application_tester'
