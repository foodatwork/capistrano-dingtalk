namespace :zomato_dingtalk do
  namespace :deploy do
    desc 'Notify about updating deploy'
    task :updating do
      Capistrano::ZDingtalk.new(self).run(:updating)
    end

    desc 'Notify about reverting deploy'
    task :reverting do
      Capistrano::ZDingtalk.new(self).run(:reverting)
    end

    desc 'Notify about updated deploy'
    task :updated do
      Capistrano::ZDingtalk.new(self).run(:updated)
    end

    desc 'Notify about reverted deploy'
    task :reverted do
      Capistrano::ZDingtalk.new(self).run(:reverted)
    end

    desc 'Notify about failed deploy'
    task :failed do
      Capistrano::ZDingtalk.new(self).run(:failed)
    end

    desc 'Test dingtalk integration'
    task test: %i[updating updated reverting reverted failed] do
      # all tasks run as dependencies
    end
  end
end

before 'deploy:updating',           'zomato_dingtalk:deploy:updating'
before 'deploy:reverting',          'zomato_dingtalk:deploy:reverting'
after  'deploy:finishing',          'zomato_dingtalk:deploy:updated'
after  'deploy:finishing_rollback', 'zomato_dingtalk:deploy:reverted'
after  'deploy:failed',             'zomato_dingtalk:deploy:failed'
