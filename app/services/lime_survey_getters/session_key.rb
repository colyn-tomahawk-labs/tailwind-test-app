module LimeSurveyGetters
  class SessionKey
    attr_accessor :survey_id

    def initialize(survey_id:)
      @survey_id = survey_id
    end

    def get_session_key
      session_key_response = HTTParty.post(
        'https://premfa.premosystems.com/admin/remotecontrol',
        body: {
          method: 'get_session_key',
          params: [
            ENV['LIMESURVEY_USERNAME'],
            ENV['LIMESURVEY_PASSWORD']
          ],
          id: survey_id
        }.to_json,
        headers: {
          'content-type': 'application/json'
        }
      )
      
      JSON.parse(session_key_response)['result']
    end
  end
end