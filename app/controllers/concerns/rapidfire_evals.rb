module RapidfireEvals
  extend ActiveSupport::Concern

  included do
    before_action :allow_file_upload_for_rapidfire,
      if: -> { controller_path == 'rapidfire/questions' }

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
