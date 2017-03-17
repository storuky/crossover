class Public::Request::MessagesController < Public::ApplicationController
  before_action :set_request

  def index
    @request.read! :sender
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
    end

    def set_request
      @request = current_user.requests.find(params[:request_id])
    end
end
