
=begin 
メソッド：ゲームスタート
説明：ゲーム本編の処理を行う
=end
def game_start
  #変数設定
  identity    = { "major" => "きのこの山", "minor" => "たけのこの里"}    #配役設定
  playerId    = identity["major"]                                  #プレイヤーの配役
  friendId    = identity["major"]                                  #相手プレイヤーの配役
  aiId        = identity["minor"]                                  #AIの配役
  questions   = ["あなたはそれを知っていますか？","あなたはそれを好きですか？"]  #質問
  answerAI    = ["POSITIVE","NEGATIVE"]                            #AIの回答
  attack_area = ["脳天","こめかみ","脊髄","スネ"]                      #演出テキスト1
  attack      = ["破壊","こん棒で強打","雑巾絞り","急速冷凍"]           #演出テキスト2
  decision    = 0                                                  #弾圧相手
  text        = "全員の回答が終わったらリターンキーを押してください"             #進行メッセージ

  #ゲーム本編処理
  puts "それでは人狼ゲームを始めます\nあなたは#{playerId}\です"
  gets.chomp
  puts "これから質問を3つしていきます。それぞれ回答が済んだらリターンキーを押してください。"
  puts "1、#{questions[0]}\nAIの答えは#{answerAI[1]}です"
  puts "全員の回答が終わったらリターンキーを押してください"
  gets.chomp
  puts "では2つ目の質問です。#{questions[1]}\nAIの答えは#{answerAI[0]}です"
  puts text
  gets.chomp
  puts "最後の質問は自由質問です。ただし、AIは回答を控えます。"
  gets.chomp
  while decision == 0 do
    puts "運命の時です。敵はAIか!?それとも…もう一人のプレイヤーか!?"
    puts "[player]敵はお前だ！死ね！！"
    puts "[AI]AIは敵だ！コンセントひっこぬけ！！"
    decision = gets.chomp
    if decision == "player"
      puts "あなたは冷徹にも友人の#{attack_area.sample}を#{attack.sample}する。しかしその正体は#{friendId}であった…！"
      gets.chomp
      if playerId == friendId
        #敗北--友達KILL
        puts "AIこそが敵だったのだ。なんてむごいことを。あなたは絶望のままニートになり、やがてAIを台頭とした「#{aiId}派」に世界は掌握されるであろう…"
        gets.chomp
      else
        #勝利--友達KILL
        puts "いくら価値観の違いとはいえ、友達が#{friendId}派だからってひどいことするね。とはいえあなたの勝利です。"
        gets.chomp
        puts "#{aiId}派の同志となったAIはなんかすごい色々よくしてくれる介護ロボとなりあなたは一生楽できましたとさ。"
        gets.chomp
      end
    elsif decision == "AI"
      puts "あなたは猜疑心の虜となり、AIの#{attack_area.sample}を#{attack.sample}する。しかしその正体は#{aiId}であった…！"
      gets.chomp
      if playerId == aiId
        #敗北--AIKILL
        puts "なんてこった！その友人は「#{friendId}」派だったのだ！どれだけの友情をはぐくもうと宗教的な理由じゃしょうがないよね。"
        gets.chomp
        puts "友人はそれはそれはしたり顔で「元・#{aiId}だった何か」の残骸を弄び、あなたは絶望のままニートになりました。"
        gets.chomp
      else
        #勝利--AIKILL
        puts "「アスタラビスタ、ベイビー」　あなたはAIを素手で粉砕し、世界は「#{playerId}」至上主義となった！#{playerId}を称えよ！"
        gets.chomp
      end
    else
      puts "ちょっと何言ってんのかわかんないです（富沢）"
      decision = 0
      gets.chomp
    end
  end
  puts "そして　夜が明けた！"
  gets.chomp
end

=begin 
メソッド：モードセレクト
説明：指定されたプレイヤー人数に応じてゲームモードを選択する
=end
def mode_select(playerNum)

  puts "人狼ゲームで遊ぼ。何人で遊びますか"
  puts "人数を入力してください"
  playerNum = gets.to_i

  #指定された人数に応じてモード設定
  case playerNum
  when 0
    puts "0人で遊ぶとか怖いこと言うなや。"
  when 1
    puts "1人...　さびしいの？　または馬鹿にしてるの？"
  when 2
   puts "人狼は2人では遊べないヨー。AI入れて遊ぶ？"
   puts "[yes]AIを入れる"
   puts "[no]AIは入れない"
   answer = gets.chomp
    if answer == "yes"
      playWithAi = true;
    else
      puts "じゃあおしまい"
    end
  when 3
    puts "まあそうだよね。3人はほしいよね。でもな。まだ無理なんだよ。ごめんな。うん。ごめんな・・・"
  when 4
    puts "TPPPそろっちゃった感じ？！　でも残念でしたー！　モンハンでもしてろよバーカ！　ばーか！！"
  else
    puts "ちょっと何言ってんのかわかんないです（富沢）"
  end

  return playWithAi

end

#変数初期化
playerNum   = 0;     #プレイヤー人数
playWithAi  = false; #AIの有無

playWithAi = mode_select(playerNum)

if playWithAi == true
  game_start
else
  puts "======= GAME OVER ======="
end

