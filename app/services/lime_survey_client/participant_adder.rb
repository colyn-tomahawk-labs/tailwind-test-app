module LimeSurveyClient
  # doesn't currently work, I think Limesurvey doesn't provide us with the token needed
  class ParticipantAdder < Base
    attr_accessor :survey_id, :token_id

    def initialize(survey_id: 572686, token_id: 'e2baWcH4oqfK')
      @survey_id = survey_id
      @token_id  = 'e2baWcH4oqfK'
    end

    def add
      limesurvey_request(
        method: :invite_participants,
        params: {
          sSessionKey: session_key,
          iSurveyId: survey_id.to_s,
          aTokenIds: {
            tid: token_id
          }
        }
      )
    end
  end
end