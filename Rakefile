# Add your own tasks in files placed in lib/tasks ending in .rake,
# for example lib/tasks/capistrano.rake, and they will automatically be available to Rake.

require_relative 'config/application'

Rails.application.load_tasks

require 'solr_wrapper/rake_task' unless Rails.env.production?

desc "Run solr and blacklight for interactive development"
task :server, [:rails_server_args] do |t, args|
  run_solr("dev", port: "8983") do
    system "bundle exec rails s #{args[:rails_server_args]}"
  end
end


def run_solr(environment, solr_params)
  solr_dir = "solr"
  SolrWrapper.wrap(solr_params) do |solr|
    ENV["SOLR_TEST_PORT"] = solr.port

    # additional solr configuration
    solr.with_collection(name: "blacklight-core-#{environment}", dir: File.join(solr_dir, "conf")) do
      puts "\n#{environment.titlecase} solr server running: http://localhost:#{solr.port}/solr/#/blacklight-core-#{environment}"
      puts "\n^C to stop"
      puts " "
      begin
        yield
      rescue Interrupt
        puts "Shutting down..."
      end
    end
  end
end
