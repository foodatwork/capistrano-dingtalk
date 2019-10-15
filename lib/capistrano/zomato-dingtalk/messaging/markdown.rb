require_relative 'base'

module Capistrano::ZomatoDingtalk::Messaging
  class Markdown < Base
    def initialize(info)
      @info = info || {}
    end

    def markdown_load(_action)
      "
      ### [#{release_details[:name]}](#{release_path})
      #{release_details[:notes]}
      "
    end

    ################################################################################

    def markdown(action)
      method = "message_for_#{action}"
      respond_to?(method) && send(method)
    end

    def build_hash(action)
      {
        msgtype: "markdown",
        markdown: {
          title: message_for(action),
          text: markdown_load(action)
        }
      }
    end
  end
end
