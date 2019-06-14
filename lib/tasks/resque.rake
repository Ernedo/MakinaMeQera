require "resque/tasks"
require 'resque/scheduler/tasks'

task "resque:setup" => :environment  do
  Resque.schedule = YAML.load_file(File.join(Rails.root, 'config', 'resque_schedule.yml'))[Rails.env]
end

task "resque:pool:setup" do
  Resque::Pool.after_prefork do
    ActiveRecord::Base.connection.reconnect!
    Resque.redis.client.reconnect
  end
end

require 'colorize'

resque_grep_command = 'ps uax | grep resque | grep -v grep | grep -v rake'
resque_count_command = "#{resque_grep_command} | wc -l"

desc 'Kills, waits and starts Resque Scheduler and Resque Pool with workers'
task "resque:restart" => :environment do
  Rake::Task['resque:stop'].invoke
  Rake::Task['resque:start'].invoke
end

desc 'Stops all resque processes and workers'
task "resque:stop" => :environment do
  puts "Killing resque processes...".colorize(:red)
  Resque::Worker.working.each{|w| w.done_working}
  Resque.workers.each {|w| w.unregister_worker}
  `kill -9 $(ps uax | grep resque- | grep -v grep | awk '{print $2}')`
  sleep 3
  puts "Done."
  if `#{resque_count_command}`.to_i == 0 # should be no resque processes
    puts "No resque processes found. Rescue stop was successful".colorize(:green)
  else
    puts "I think resque processes are not shut down properly. Kill it manually.".colorize(:red)
  end
end

desc 'Start all resque processes and workers'
task "resque:start" => :environment do
  if `#{resque_count_command}`.to_i != 0
    puts "Resque can not be started because resque processes are not shut down properly. Kill it manually.".colorize(:red)
  else
    puts "Starting resque...".colorize(:green)

    puts "Starting resque pool..."
    `bundle exec resque-pool --daemon #{'--environment development' if Rails.env == 'development'}`

    puts "Starting resque scheduler..."
    system('LOGFILE=log/resque-scheduler.log VERBOSE=yes PIDFILE=tmp/pids/resque-scheduler.pid BACKGROUND=yes bundle exec rake resque:scheduler')
    sleep 3

    puts "Done.".green
    puts `#{resque_grep_command}`
    puts "Rescue process started successfully"
  end
end

desc "Clear pending tasks"
task "resque:clear" => :environment do
  queues = Resque.queues
  queues.each do |queue_name|
    puts "Clearing #{queue_name}..."
    Resque.redis.del "queue:#{queue_name}"
  end

  puts "Clearing delayed..." # in case of scheduler - doesn't break if no scheduler module is installed
  Resque.redis.keys("delayed:*").each do |key|
    Resque.redis.del "#{key}"
  end
  Resque.redis.del "delayed_queue_schedule"

  puts "Clearing stats..."
  Resque.redis.set "stat:failed", 0
  Resque.redis.set "stat:processed", 0
end