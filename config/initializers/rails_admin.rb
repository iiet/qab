require Rails.root.join('lib', 'rails_admin_import_question_set.rb')

RailsAdmin.config do |config|
  module RailsAdmin
    module Config
      module Actions
        class ImportQuestionSet < RailsAdmin::Config::Actions::Base
          RailsAdmin::Config::Actions.register(self)
        end
      end
    end
  end
  ### Popular gems integration

  ## == Devise ==
  config.authenticate_with do
    warden.authenticate! scope: :user
  end
  config.current_user_method(&:current_user)

  config.authorize_with do |controller|
    render nothing: true unless current_user.try(:admin)
  end

  ## == Cancan ==
  # config.authorize_with :cancan

  ## == PaperTrail ==
  # config.audit_with :paper_trail, 'User', 'PaperTrail::Version' # PaperTrail >= 3.0.0

  ### More at https://github.com/sferik/rails_admin/wiki/Base-configuration

  config.actions do
    dashboard                     # mandatory
    index                         # mandatory
    new
    export
    bulk_delete
    show
    edit
    delete
    show_in_app
    import_question_set do
      visible do
        bindings[:abstract_model].model.to_s == "QuestionSet"
      end
    end
    ## With an audit adapter, you can add:
    # history_index
    # history_show
  end
end
