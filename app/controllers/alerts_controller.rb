class AlertsController < ApplicationController
  before_action :set_alert, only: %i[ show edit update destroy ]

  # GET /alerts
  def index
    @alerts = params[:delay].present? ? Alert.seconds_ago(params[:delay].to_i) : Alert.all
    render :json => @alerts.order(level: :asc)
  end

end
