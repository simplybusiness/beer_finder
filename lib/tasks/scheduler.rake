desc "Pull in a last weeks Xero data This task is called by the Heroku scheduler add-on"
task :update_last_week_from_xero => :environment do
  puts 'updating from xero'
  OutletCreatorService.create_from_xero
end
