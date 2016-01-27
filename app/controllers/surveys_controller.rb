class SurveysController < ApplicationController

before_filter :authenticate_any!
before_filter :load_survey, only: [:show, :edit, :update, :destroy]
 

  def index
    type = view_context.get_survey_type(params[:type])
    query = if type then Survey::Survey.where(survey_type: type) else Survey::Survey end

    if admin_signed_in?
        @surveys = query.order(created_at: :desc).page(params[:page]).per(15)
      elsif user_signed_in?
        @surveys = query.order(created_at: :desc).page(params[:page]).per(15).where(company_key: current_user.company_key)
    end 
  end

  def new
    @survey = Survey::Survey.new(survey_type: view_context.get_survey_type(params[:type]))
  end

  def create
    @survey = Survey::Survey.new(params_whitelist)

    if @survey.company_key.present?
      if @survey.valid? && @survey.save
        default_redirect
      else
        build_flash(@survey)
        render :new
      end
    else
      flash[:notice] = "You need a company"
      render 'new'
    end
  end

  def edit
  end

  def show
  end 



  def update
    if @survey.update_attributes(params_whitelist)
      default_redirect
    else
      build_flash(@survey)
      render :edit
    end
  end

  def destroy
    @survey.destroy
    default_redirect
  end

  private

  def authenticate_any!
    if admin_signed_in?
      true
    else
      authenticate_user!
    end 
  end 

  def default_redirect
    redirect_to surveys_path, notice: I18n.t("surveys_controller.#{action_name}")
  end

  def load_survey
    @survey = Survey::Survey.find(params[:id])
  end

  def params_whitelist
    params.require(:survey_survey).permit(Survey::Survey::AccessibleAttributes << :survey_type, :company_key)
  end
end
