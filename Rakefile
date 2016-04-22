require "rspec/core/rake_task"
require "rubocop/rake_task"
require "foodcritic"
require "kitchen"

# Style tests. Rubocop and Foodcritic
namespace :style do
  desc "Run Ruby style checks"
  RuboCop::RakeTask.new(:ruby)

  desc "Run Chef style checks"
  FoodCritic::Rake::LintTask.new(:chef) do |t|
    t.options = {
      fail_tags: ["any"],
      context: true,
    }
  end
end

desc "Run all style checks"
task style: ["style:chef", "style:ruby"]

# Rspec and ChefSpec
desc "Run ChefSpec examples"
RSpec::Core::RakeTask.new(:spec)

# Integration tests. Kitchen.ci
namespace :integration do
  desc "Run Test Kitchen with Vagrant"
  task :vagrant do
    Kitchen.logger = Kitchen.default_file_logger
    instances = Kitchen::Config.new.instances
    server = instances.find { |i| i.suite.name == "server" }
    client = instances.find { |i| i.suite.name == "client" }
    begin
      server.verify
      client.verify
    ensure
      #server.destroy
      #client.destroy
    end
  end
end

# Default
task default: ["style", "spec", "integration:vagrant"]
