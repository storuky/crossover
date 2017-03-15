class Admin::Request::MessagesController < Admin::ApplicationController
  before_action :set_request

  def index
    @messages = @request.messages.pluck_fields
    render json: @messages
  end

  def create
    @message = @request.messages.new(message_params)
    if @message.save
      render json: {}
    else
      render json: {msg: @message.errors.full_messages.join("; ")}, status: 403
    end
  end

  private
    def message_params
      params.require(:message).permit(:content)
            .merge(user_id: current_user.id)
    end

    def set_request
      @request = Request.find(params[:request_id])
    end
end
