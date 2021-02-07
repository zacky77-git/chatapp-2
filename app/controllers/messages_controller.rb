class MessagesController < ApplicationController
  before_action :set_room, only: %i[index create]
  before_action :move_to_index

  def index
    require 'net/http'
    require 'uri'
    require 'json'

    @message = Message.new
    @rooms = current_user.rooms
    @messages = @room.messages.includes(:user).order(id: 'ASC')
  end

  def create
    @message = @room.messages.new(message_params)
    if @message.save
      @language = lang_data(@message.content)
      @translated_content = translate_to_japanese(@message.content) if @language != 'ja'
      @message.update(message_params)
      redirect_to room_messages_path(@room)
    else
      @messages = @room.messages.includes(:user)
      render :index
    end
  end

  private

  def message_params
    params.require(:message).permit(:content, :image).merge(user_id: current_user.id,
                                                            translated_content: @translated_content, lang_data: @language)
  end

  def set_room
    @room = Room.find(params[:room_id])
  end

  def move_to_index
    @rooms = current_user.rooms.ids
    redirect_to root_path unless @room.id.in?(@rooms)
  end

  require 'net/http'
  require 'uri'
  require 'json'

  # 言語の種類を検出するメソッド
  def lang_data(message)
    url = URI.parse('https://translation.googleapis.com/language/translate/v2/detect')
    params = {
      q: message,
      key: ENV['CLOUD_TRANSLATION_API']
    }
    url.query = URI.encode_www_form(params)
    res = Net::HTTP.get_response(url)
    json = res.body
    # レスポンスのjsonの言語のパラメータをパースする
    JSON.parse(json)['data']['detections'][0][0]['language']
  end

  def translate_to_japanese(message)
    url = URI.parse('https://www.googleapis.com/language/translate/v2')
    params = {
      q: message,
      target: 'ja', # 翻訳したい言語
      source: lang_data(message), # 翻訳する言語の種類
      key: ENV['CLOUD_TRANSLATION_API']
    }
    url.query = URI.encode_www_form(params)
    res = Net::HTTP.get_response(url)
    json = res.body
    # レスポンスのjsonの言語の翻訳結果の部分のパラメータをパースする
    "訳:#{JSON.parse(json)['data']['translations'].first['translatedText']}"
  end

  # puts translate_to_japanese("I want to eat something.")
end
