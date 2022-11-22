# README

Just a small foray into the capabilities of the [tailwindcss-rails](https://github.com/rails/tailwindcss-rails) gem and tailwind itself, as well as integrations with some third-party systems:

- Limesurvey Remote Control 2 API
- SurveyMonkey API v3

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

See [app/services/lime_survey_client/candidate_survey_getter.rb](https://github.com/colyn-tomahawk-labs/tailwind-test-app/blob/master/app/services/lime_survey_client/candidate_survey_getter.rb) for a simple integration thrown together from scratch.

```bash
# ensure that the LIMESURVEY_USERNAME and LIMESURVEY_PASSWORD env vars are set in .env
rails c
LimeSurveyClient::CandidateSurveyGetter.new.get
```

## SurveyMonkey

A slick platform, however the only gem available for it does not interate with the current Surveymonkey API v3.
Though API is more conventional and RESTful than LimeSurvey, and just as easy to integrate with.
See the integration [here](https://github.com/colyn-tomahawk-labs/tailwind-test-app/blob/master/app/services/survey_monkey/getter.rb) for [this test survey](https://www.surveymonkey.com/r/KS32HSH)

## LimeSurvey vs SurveyMonkey

The SurveyMonkey gives us a lot more information in its response (survey urls, question text, date created, date modified etc) though we may have no use for them.

[LimeSurvey sample response](https://github.com/colyn-tomahawk-labs/tailwind-test-app/wiki/Limesurvey-Remote-Control-API-sample-response)\
[SurveyMonkey sample response](https://github.com/colyn-tomahawk-labs/tailwind-test-app/wiki/SurveyMonkey-API-v3-sample-response)

Essentially though there are no real boons I've found yet to find with SurveyMonkey, other than perhaps a better user experience for those creating surveys, essesntially the two services give us the same thing.
My opinion after playing around with both services is that perhaps a jump from LimeSurvey to SurveyMonkey isn't worth it, we may be trying to improve on something that was particularly lacking in the first place