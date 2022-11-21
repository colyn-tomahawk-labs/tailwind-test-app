module LimeSurveyClient
  class SessionKeyGetter < Base
    attr_accessor :survey_id

    def initialize(survey_id:)
      @survey_id = survey_id
    end

    def get_session_key
      limesurvey_request(
        method: :get_session_key,
        params: [
          ENV.fetch('LIMESURVEY_USERNAME'),
          ENV.fetch('LIMESURVEY_PASSWORD')
        ]
      ) do |session_key_response|
        JSON.parse(session_key_response)['result']
      end
    end
  end
end