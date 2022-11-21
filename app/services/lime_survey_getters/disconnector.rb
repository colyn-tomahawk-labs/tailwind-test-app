module LimeSurveyGetters
  class Disconnector
    attr_accessor :session_key

    def initialize(session_key:)
      @session_key = session_key
    end

    def disconnect
      encoded_session_key = Base64.encode64(session_key)

      HTTParty.post(
        'https://premfa.premosystems.com/admin/remotecontrol',
        body: {
          method: 'release_session_key',
          params: {
            sSessionKey: encoded_session_key,
          },
          id: '2'
        }.to_json,
        headers: {
          'content-type' => 'application/json'
        }
      )
    end
  end
end