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

## rodauth-rails

First up: better than Devise for our use case.

Rodauth's implementation is leaner than Devise' and still just as flixible if not more.
It was relatively easy to create the concept of:
An account, with the account type user being able to view any other user (regardless if they're admin, OrgAdmin or System admin),
as well as create and edit them. A Sysadmin can create an account, hand the email and password to someone and they're able
to log in with it. All with a very small, simple implementation. Thats huge

### A quirk (and a boon?)

Rodauth has its own routing implementation, but also allows routes to be declared in the classic `config/routes.rb`
On top of this, it dynamically generates and removes routes altogether in the same user session depending if the user is an admin or not [see here](https://github.com/colyn-tomahawk-labs/tailwind-test-app/blob/master/config/routes.rb#L6). While other precautions should be put in place, this could potentially act as a permissions barrier for candidates or OrgAdmins trying to nose around parts of the platform where they're not welcome.

### Furthermore

It easy to [configure](https://github.com/colyn-tomahawk-labs/tailwind-test-app/tree/master/app/misc) and brings a lot of goodies right out the [box](https://github.com/janko/rodauth-rails).
It comes with the same handy methods Devise does, we can always access the current user with the `current_account` method.
It's a thumbs up from me, perfectly library for easy, secure authentication.

Currently, to play around as admin, sign up for the app and use
```bash
rails c
Account.find_by('<email you signed up with>').update(user_type: 'sys_admin')
```