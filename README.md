# README

Just a small foray into the capabilities of the [tailwindcss-rails](https://github.com/rails/tailwindcss-rails) gem and tailwind itself

To use simply just clone the repo and enter the following

```bash
cd tailwind-test-app
bundle
rails db:migrate
rails s
```

then navigate to `http://localhost:<port>/` in your browser

## LimeSurvey

Also included is a trial of gems used to integrate with the LimeSurvey `Remote Control 2` API.
Thus far the findings have been that the `limeade` and `limesurvey` gems don't give us the degree of control we need.
Mostly in terms of sending the parameters we want to, in requests such as [export_responses_by_token](https://api.limesurvey.org/classes/remotecontrol_handle.html#method_export_responses_by_token)

See `app/services/lime_survey_getters/candidate.rb` for a simple integration thrown together from scratch.

```bash
# ensure that the LIMESURVEY_USERNAME and LIMESURVEY_PASSWORD env vars are set in .env
rails c
LimeSurveyGetters::Candidate.new.user_survey_data
```