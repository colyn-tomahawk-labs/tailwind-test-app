module LimeSurveyClient
  class Base

    def limesurvey_request(method:, params:)
      response = HTTParty.post(
        ENV.fetch('LIMESURVEY_URL'),
        headers: { 'content-type': 'application/json' },
        body: {
          method: method,
          params: params,
          id: make_id
        }.to_json
      )

      block_given? ? yield(response) : response
    end

    private

    def session_key
      @_session_key ||= SessionKeyGetter.new(survey_id: survey_id).get_session_key
    end

    def make_id
      rand(1..99).to_s
    end
  end
end