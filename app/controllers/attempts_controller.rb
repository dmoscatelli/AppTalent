class AttemptsController < ApplicationController

  helper 'surveys'

  before_filter :load_survey, only: [:new, :create]
  before_action :check_company, only: [ :new]


  def index
    @surveys = Survey::Survey.active
  end

  def show
    @attempt = Survey::Attempt.find_by(id: params[:id])
    if current_admin
      render :access_error if current_admin.id != @attempt.participant_id
    else
      render :access_error if current_user.id != @attempt.participant_id
    end 
  end

  def new
    if current_admin
      @participant = current_admin
    else
       @participant = current_user
    end

    unless @survey.nil?
      @attempt = @survey.attempts.new
      @attempt.answers.build
    end
  end

  def create
    @attempt = @survey.attempts.new(params_whitelist)
    if current_admin
      @attempt.participant = current_admin
    else
      @attempt.participant = current_user
    end 

    if @attempt.valid? && @attempt.save
      correct_options_text = @survey.correct_options.present? ? 'Bellow are the correct answers marked in green' : ''
      redirect_to attempt_path(@attempt.id), notice: "Thank you for answering #{@survey.name}! #{correct_options_text}"
    else
      build_flash(@attempt)   
      @participant = current_user
      render :new
    end
  end

  def delete_user_attempts
    Survey::Attempt.where(participant_id: current_user, survey_id: params[:survey_id]).destroy_all
    redirect_to new_attempt_path(survey_id: params[:survey_id])
  end

  private

  def load_survey
    @survey = Survey::Survey.find_by(id: params[:survey_id])
  end

  def params_whitelist
    if params[:survey_attempt]
      params[:survey_attempt][:answers_attributes] = params[:survey_attempt][:answers_attributes].map { |attrs| { question_id: attrs.first, option_id: attrs.last } }
      params.require(:survey_attempt).permit(Survey::Attempt::AccessibleAttributes)
    end
  end


  def check_company
      unless current_admin
      unless current_user.company_key == @survey.company_key
      flash[:notice] = "You do not have access to this company"
      redirect_to root_path
    end 
  end 
end


end
