module LimeSurveyClient
  class Disconnector < Base
    attr_accessor :session_key

    def initialize(session_key:)
      @session_key = session_key
    end

    def disconnect_from_live_session
      limesurvey_request(
        method: :release_session_key,
        params: {
          sSessionKey: Base64.encode64(session_key)
        }
      )
    end
  end
end