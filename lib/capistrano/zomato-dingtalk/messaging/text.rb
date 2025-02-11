require_relative 'base'

module Capistrano::ZomatoDingtalk::Messaging
  class Text < Base
    def build_hash(action)
      {
        msgtype: "text",
        text: {
          content: message_for(action)
        }
      }
    end
  end
end
