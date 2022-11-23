module SurveyMonkey
  class Getter

    def get
      # our survey id: 509565505
      # the survey: https://www.surveymonkey.com/r/KS32HSH
      url = 'https://api.surveymonkey.com/v3/surveys/509565505/responses/bulk?simple=true'
      
      response = HTTParty.get(url,
        headers: {
          "Content-Type": "application/json",
          "Accept": "application/json",
          "Authorization": "Bearer #{ENV.fetch('SURVEY_MONKEY_ACCESS_TOKEN')}"
        }
      ).parsed_response
    end
  end
end