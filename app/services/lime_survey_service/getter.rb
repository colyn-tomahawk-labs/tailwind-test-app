module LimeSurveyService
  class Getter

    def self.ping
      url = 'https://premfa.premosystems.com/admin/remotecontrol'
      # client = Limeade::Client.new(url, 'colyn.prater', 'TK4MmH9wUeD7nGY')
      # surveys = client.list_surveys
      # client.get_summary(surveys.first['sid'])

      @lime_survey_api = Limesurvey::API.new(url)
      
      # @session_key = @lime_survey_api.get_session_key(ENV['LIMESURVEY_USERNAME'], ENV['LIMESURVEY_PASSWORD'])
      
      #participant = LIMESURVEY_API.get_participant_properties(LIMESURVEY_API_SESSION_KEY, sid, tid, [property])
      #@lime_survey_api.release_session_key(@session_key)
      #response = JSON.parse(participant.to_json)
      #return response[property]
    end
  end
end