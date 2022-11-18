module LimeAid
  class Getter

    def self.ping
      #client = Limeade::Client.new(url, 'colyn.prater', 'TK4MmH9wUeD7nGY', retry_options: {max: 1})
      
      # url = 'https://premfa.premosystems.com/rest/v1/survey/572686'
      # url = 'https://premfa.premosystems.com/admin/survey/sa/view/surveyid/572686'
      #surveys = client.list_surveys
      #summary = client.get_summary(surveys.first['sid'])
      
      # https://premfa.premosystems.com/admin/remotecontrol/rest/v1/survey/572686
      url = 'https://premfa.premosystems.com/admin/remotecontrol'

    end
  end
end