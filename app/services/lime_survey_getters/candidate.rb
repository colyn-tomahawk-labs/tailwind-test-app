module LimeSurveyGetters
  class Candidate
    attr_accessor :survey_id

    def initialize(survey_id = 572686)
      # 572686 is the survey id of our 'test' survey
      @survey_id = survey_id
    end

    def user_survey_data
      # retrieves answers for candidate dFAVrdkEy1Kh in survey:
      # https://premfa.premosystems.com/admin/survey/sa/view/surveyid/572686

      # documentation: https://api.limesurvey.org/classes/remotecontrol_handle.html

      session_key = SessionKey.new(survey_id: survey_id).get_session_key

      response = HTTParty.post(
        'https://premfa.premosystems.com/admin/remotecontrol',
        body: {
          method: 'export_responses_by_token',
          params: {
            sSessionKey: session_key,
            iSurveyId: survey_id.to_s,
            sDocumentType: 'json',
            sToken: 'dFAVrdkEy1Kh', # candidate id
            sLanguageCode: nil,
            sResponseType: 'long'
          },
          id: '2'
        }.to_json,
        headers: {
          'content-type' => 'application/json'
        }
      )

      encoded_user_data = JSON.parse(response.parsed_response)
      decoded = Base64.decode64(encoded_user_data['result'])
      user_response_data = JSON.parse(decoded)['responses']

      Disconnector.new(session_key: session_key).disconnect_from_live_session
      
      user_response_data.first.flatten.last
    end
  end
end