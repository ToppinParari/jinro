def game_start
  text = "全員の回答が終わったらリターンキーを押してください"
  puts "それでは人狼ゲームを始めます\nあなたは「ビアンカ」です"
  gets.chomp
  puts "これから質問を3つしていきます。それぞれ回答が済んだらリターンキーを押してください。"
  puts "1、あなたはそれを知っていますか？\nAIの答えはnegativeです"
  puts "全員の回答が終わったらリターンキーを押してください"
  gets.chomp
  puts "では2つ目の質問です。好きですか？\nAIの答えはpositiveです"
  puts text
  gets.chomp
  puts "最後の質問は自由質問です。ただし、AIは回答を控えます。"
  gets.chomp

end


puts "人狼ゲームで遊ぼ。何人で遊びますか\n[0]2人\n[1]3人"
puts "番号を入力してください"
input = gets.to_i

if input == 0
  puts "人狼は2人では遊べないヨー。AI入れて遊ぶ？"
  puts "[0]AIを入れる"
  puts "[1]AIは入れない"
  puts "番号を入力してください"
  answer = gets.to_i
    if answer == 0
    game_start
    elsif answer == 1
    puts "じゃあおしまい"
    end
else
  puts "まだ実装してへんねんごめんな"
end
