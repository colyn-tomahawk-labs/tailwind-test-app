module LimeSurveyGetters
  class Candidate

    def self.ping
      #retrieves answers for candidate dFAVrdkEy1Kh in survey:
      # https://premfa.premosystems.com/admin/survey/sa/view/surveyid/572686

      url = 'https://premfa.premosystems.com/admin/remotecontrol'

      session_key_response = HTTParty.post(url,
        body: {
          method: 'get_session_key',
          params: [
            ENV['LIMESURVEY_USERNAME'],
            ENV['LIMESURVEY_PASSWORD']
          ],
          id: 572686
        }.to_json,
        headers: {
          'content-type': 'application/json'
        }
      )
      session_key = JSON.parse(session_key_response)['result']

      response = HTTParty.post(url,
        body: {
          method: 'export_responses_by_token',
          params: {
            sSessionKey: session_key,
            iSurveyId: '572686',
            sDocumentType: "json",
            sToken: "dFAVrdkEy1Kh", # candidate id
            sLanguageCode: nil,
            sResponseType: "long"
          },
          id: '2'
        }.to_json,
        headers: {
          'content-type' => 'application/json'
        }
      )

      encoded_user_data = JSON.parse(response.parsed_response)
      decoded = Base64.decode64(encoded_user_data['result'])
      JSON.parse(decoded)['responses']
    end
  end
end