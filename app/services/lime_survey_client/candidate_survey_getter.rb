module LimeSurveyClient
  class CandidateSurveyGetter < Base
    attr_accessor :survey_id, :candidate_id

    def initialize(survey_id: 572686, candidate_id: 'dFAVrdkEy1Kh')
      @survey_id    = survey_id
      @candidate_id = candidate_id
    end
    
    # Retrieves answers for candidate dFAVrdkEy1Kh in survey:
    # 572686 is the survey id of our 'test' survey

    # https://premfa.premosystems.com/admin/survey/sa/view/surveyid/572686
    # documentation: https://api.limesurvey.org/classes/remotecontrol_handle.html

    def get
      limesurvey_request(
        method: :export_responses_by_token,
        params: {
          sSessionKey: session_key,
          iSurveyId: survey_id.to_s,
          sDocumentType: :json,
          sToken: candidate_id,
          sLanguageCode: nil,
          sResponseType: :long
        }
      ) do |response|
        Disconnector.new(session_key: session_key).disconnect_from_live_session
        formatted_response(response.parsed_response)
      end
    end

    private

    def formatted_response(parsed_response)
      encoded_user_data = JSON.parse(parsed_response)
      decoded           = Base64.decode64(encoded_user_data['result'])
      
      JSON.parse(decoded).
        dig('responses').
        first.
        flatten.
        last
    end
  end
end