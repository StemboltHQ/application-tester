require 'sinatra'
require 'Haml'
require_relative 'lib/application_tester'

  get '/' do
    haml :index
  end

  post '/redirection-test' do
    haml :redirection_test
  end

  post '/robots-file-test' do
    haml :robots_file_test
  end

  post '/sitemaps-test' do
    haml :sitemap_test
  end

  post '/markup-test' do
    haml :markup_test
  end
