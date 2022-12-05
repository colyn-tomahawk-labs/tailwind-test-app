module RapidfireEvals
  extend ActiveSupport::Concern

  included do
    before_action :allow_file_upload_for_rapidfire,
      if: -> { controller_path == 'rapidfire/questions' }

    before_action :authenticate_survey_domain,
      if: -> { controller_path.include?('rapidfire') }

    def authenticate_survey_domain
      non_admin_in_survey_crud = current_account.present? &&
        !current_account.sys_admin?                       &&
        ['new', 'create'].exclude?(action_name)           &&      # allow candidates to take surveys
        request.controller_class != Rapidfire::AttemptsController # allow redirect to thank you page
      
      # eg: /rapidfire/surveys/2/attempts/new

      redirect_to '/' if non_admin_in_survey_crud
    end

    def allow_file_upload_for_rapidfire
      Rapidfire::QuestionForm.class_eval do
        # overwrites the :create_question method found at
        # https://github.com/code-mancers/rapidfire/blob/ecabaded9f591a219db1041da591020bf6624008/app/services/rapidfire/question_form.rb#L38
        # to allow for our custom Rapidfire::Questions::File (a file field input)
        def create_question
          klass = nil
          if ::Rapidfire::QuestionForm::QUESTION_TYPES.values.include?(type) || type == "Rapidfire::Questions::File"
            klass = type.constantize
          else
            errors.add(:type, :invalid)
            return false
          end
    
          @question = klass.create(to_question_params)
        end

        def to_question_params
          {
            survey: survey,
            question_text: question_text,
            position: position,
            default_text: default_text,
            placeholder: placeholder,
            answer_options: answer_options,
            type: type, 
            validation_rules: {
              presence: answer_presence,
              minimum: answer_minimum_length,
              maximum: answer_maximum_length,
              greater_than_or_equal_to: answer_greater_than_or_equal_to,
              less_than_or_equal_to: answer_less_than_or_equal_to
            }
          }
        end
      end
      
      Rapidfire::Question.class_eval do
        # ActiveRecord::Base#update_attributes is deprecated so we overwrite it here
        def update_attributes(params)
          update(params)
        end
      end
    end
  end

end
