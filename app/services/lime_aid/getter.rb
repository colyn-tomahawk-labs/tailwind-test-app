module LimeAid
  class Getter

    def self.ping
      # TODO get correct api url
      url = 'https://demo.limesurvey.org/index.php?r=survey/index&sid=88881&lang=en'
      client = Limeade::Client.new(url, 'demo', 'test')
      surveys = client.list_surveys
      summary = client.get_summary(surveys.first['sid'])
    end
  end
end