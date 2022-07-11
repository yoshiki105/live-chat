3.times do |number|
  Message.create(content: "#{number}番目のメッセージ", user_id: User.first.id)
  puts "#{number}番目のメッセージを作成"
end
