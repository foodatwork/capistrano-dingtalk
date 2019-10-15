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
      repo_link = "https://#{fetch(:repo_url).split('@').last.gsub(':', '/').split('.git').first}"
      if branch[0] == 'v'
        "#{repo_link}/releases/tag/#{branch}"
      else
        "#{repo_link}/tree/#{current_revision}"
      end
    end

    def release_details
      api_base_url = 'https://api.github.com/repos'
      repo_path = fetch(:repo_url).split(':').second.split('.git').first
      api_url =
        if branch[0] == 'v'
          "#{api_base_url}/#{repo_path}/releases/tags/#{branch}?oauth_token=#{fetch(:zomato_ding_github_token)}"
        else
          "#{api_base_url}/#{repo_path}/releases/latest?oauth_token=#{fetch(:zomato_ding_github_token)}"
        end
      release_response = RestClient.get(api_url)
      release_response_hash = JSON.parse(release_response)
      {
        name: release_response_hash['name'],
        notes: release_response_hash['body']
      }
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
