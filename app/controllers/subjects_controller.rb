class SubjectsController < ApplicationController
  before_action :set_subject, only: [:show, :edit, :update, :destroy]

  # GET /subjects
  # GET /subjects.json
  def index
    @subjects = Subject.all.sort_by{|s| (current_user.current_semester - s.study_semester).abs}
  end

  # GET /subjects/1
  # GET /subjects/1.json
  def show
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_subject
      @subject = Subject.find(params[:id])
    end
end
