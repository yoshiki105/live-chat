class RoomChannel < ApplicationCable::Channel
  # Websocket通信した時に呼ばれる
  def subscribed
    # どのチャネルとコネクションするか
    stream_from "room_channel"
  end

  # 通信切断した時に呼ばれる
  def unsubscribed
    # Any cleanup needed when channel is unsubscribed
  end

  # ユーザからのリクエストを受信する度に呼ばれる
  def receive(data)
    user = User.find_by(email: data[:email])

    if message = Message.create(content: data[:message], user_id: user.id)
      # room_channelに接続している全てのブラウザにデータを送信
      ActionCabble.server.broadcast 'room_channel',
        { message: data[:message], name: user.name, created_at: message.created_at }
    end
  end
end
