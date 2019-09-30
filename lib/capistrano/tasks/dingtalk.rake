namespace :dingtalk do
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

before 'deploy:updating',           'dingtalk:deploy:updating'
before 'deploy:reverting',          'dingtalk:deploy:reverting'
after  'deploy:finishing',          'dingtalk:deploy:updated'
after  'deploy:finishing_rollback', 'dingtalk:deploy:reverted'
after  'deploy:failed',             'dingtalk:deploy:failed'
