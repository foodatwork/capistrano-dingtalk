require_relative 'base'

module Capistrano::ZomatoDingtalk::Messaging
  class Markdown < Base
    def initialize(info)
      @info = info || {}
    end

    def markdown_load(_action)
      "# food@work:#{application} [#{branch}](#{release_path})\r\n\r\n**#{release_details[:name]}**\n\n###{release_details[:notes]}"
    end

    ################################################################################

    def markdown(action)
      method = "message_for_#{action}"
      respond_to?(method) && send(method)
    end

    def build_hash(action)
      {
        msgtype: 'markdown',
        markdown: {
          title: release_details[:name],
          text: markdown_load(action)
        }
      }
    end
  end
end
