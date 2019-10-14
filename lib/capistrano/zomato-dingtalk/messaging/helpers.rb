module Capistrano::ZomatoDingtalk::Messaging
  module Helpers
    def username
      'cap-dingtalk-bot'
    end

    def deployer
      ENV['USER'] || ENV['USERNAME']
    end

    def branch
      fetch(:branch)
    end

    def application
      fetch(:application)
    end

    def rails_env
      fetch(:rails_env)
    end

    def stage(default = 'an unknown stage')
      fetch(:stage, default)
    end

    def current_revision
      fetch(:current_revision)
    end

    def release_path
      "https://#{fetch(:repo_url).split('@').last.gsub(':', '/').split('.git').first}/releases/tag/#{branch}"
    end

    #
    # Return the elapsed running time as a string.
    #
    # Examples: 21-18:26:30, 15:28:37, 01:14
    #
    def elapsed_time
      `ps -p #{$PROCESS_ID} -o etime=`.strip
    end
  end
end
