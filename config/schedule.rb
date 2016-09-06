
set :output, 'log/crontab.log'
set :environment, :production

every 1.day, at: '9:00 am' do
    rake 'scrape:navitime'
end