class MessageTemplatesController < ApplicationController
  def new; end

  def index
    @message_templates = MessageTemplate.all.order(name: :asc).page(params[:page])
  end

  def create

  end
end
