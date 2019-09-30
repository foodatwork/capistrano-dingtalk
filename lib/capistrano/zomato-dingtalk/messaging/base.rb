require 'forwardable'
require 'json'
require_relative 'helpers'

module Capistrano::ZomatoDingtalk::Messaging
  class Base
    include Helpers
    extend Forwardable
    def_delegators :env, :fetch

    def initialize(info)
      @info = info || {}
    end

    def message_for_updating
      "food@work:#{stage} Deployment started for branch #{branch} of #{application}"
    end

    def message_for_reverting
      "food@work:#{stage} Rollback started for branch #{branch} of #{application}"
    end

    def message_for_updated
      "food@work:#{stage} Deployment finished for branch #{branch} of #{application}"
    end

    def message_for_reverted
      "food@work:#{stage} Rollback finished for branch  #{branch} of #{application}"
    end

    def message_for_failed
      "food@work:#{stage} #{deploying? ? 'Deployment' : 'Rollback'} failed for branch #{branch} of #{application}"
    end

    ################################################################################

    def message_for(action)
      method = "message_for_#{action}"
      respond_to?(method) && send(method)
    end

    def build_at_dict
      at = {}
      at["at"] = @info[:at_all]
      at["atMobiles"] = @info[:at_mobiles]
      at
    end

    def build_hash(action)
      # implements on children
    end

    def build_msg_json(action)
      build_hash(action).merge(build_at_dict).to_json
    end
  end
end
