require 'rails_admin/config/actions'
require 'rails_admin/config/actions/base'

# module RailsAdminImportQuestionSet
# end

module RailsAdmin
  module Config
    module Actions
      class ImportQuestionSet < RailsAdmin::Config::Actions::Base
        # There are several options that you can set here.
        # Check https://github.com/sferik/rails_admin/blob/master/lib/rails_admin/config/actions/base.rb for more info.
        register_instance_option :controller do
          proc do
            if request.get?
              render "#{@action.template_name}-get"
            elsif request.post?
              data = ::QuestionsImporter.new.from_string(params[:question_import][:file].tempfile.read)
              @errors = data[:errors]
              @question_set = QuestionSet.find(params[:question_import][:question_set])
              @question_set.modify_from_importer_data(data)
              @question_set.save

              flash[:success] = "Succesfully imported questions"
              render "#{@action.template_name}-post"
            end
          end
        end
        register_instance_option :collection? do
          true
        end
        register_instance_option :http_methods do
          [:post,:get]
        end
        register_instance_option :link_icon do
          'icon-upload'
        end
      end
    end
  end
end
# See more at: http://fernandomarcelo.com/2012/05/rails-admin-creating-a-custom-action/#sthash.x9uTOoAC.dpuf