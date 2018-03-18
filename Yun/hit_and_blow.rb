=begin 
メソッド：input_player_number
説明：プレイヤーのナンバーを設定(対戦用)※まだ実装してないよ！
=end
def input_player_number(digitNum)
  playerNum = "0" #プレイヤーのナンバー
  answer = "no"   #確認結果
  ret = "NG"      #ナンバーチェック結果

  #確認(yes)がとれるまで繰り返す
  while answer != "yes"
    #ナンバーチェックがOKとなるまで繰り返す
    while ret != "OK"

      puts ">>あなたのナンバーを入力してください。"
      playerNum = gets.chomp

      #ナンバーチェック(形式、桁数、重複)
      ret = check_numbers(playerNum,digitNum)
      if ret == "formErr"
        puts "不正な入力です。数字を入力してください。"
      elsif ret == "digitErr"
        puts "桁数が不正です。「#{digitNum}桁」の数字を入力してください。"
      elsif ret == "overlapErr"
        puts "数字が重複しています。同じ数字は2度以上使用できません。"
      end
    end

    #入力確認
    puts ">>あなたのナンバーは「#{playerNum}」でよろしいですか？[yes/no]"
    answer = gets.chomp
    if answer == "yes"
      puts "あなたのナンバーが確定しました。"
      gets.chomp
    elsif answer == "no"
      puts "ではもう一度確認致します。"
      ret = "NG"
    else
      puts "もう一度確認します。"
      ret = "NG"
    end
  end

  #設定したナンバーを返却
  return playerNum

end

=begin 
メソッド：set_enemy_number
説明：CPUのナンバーを設定(一人用)
=end
def set_enemy_number(digitNum)
  enemyNum = "0"  #相手CPUのナンバー
  randNum = ""    #ランダム生成用ナンバー
  ret = "NG"      #ナンバーチェック結果

  #桁数に応じてランダム用ナンバーを生成
  digitNum.times{
    randNum << "9"  #桁数分"9"を追加 (ex. 3桁なら"999")
  }

  #ナンバーチェックがOKとなるまで繰り返す
  while ret != "OK"
    #ナンバーをランダムで設定する
    enemyNum = rand(randNum.to_i).to_s
    #ナンバーチェック(形式、桁数、重複)
    ret = check_numbers(enemyNum, digitNum)
  end

  #設定したナンバーを返却
  return enemyNum

end

=begin 
メソッド：check_numbers
説明：ナンバーがルールに準じているかチェック
１．形式チェック
２．桁数チェック
３．重複チェック
=end
def check_numbers(numbers,digitNum)

  #整数以外の文字が混入していた場合、型式エラー
  if (numbers =~ /\A[0-9]+\z/) == nil
    return "formErr"
  end

  #設定した桁数と入力したナンバーの桁数が一致しない場合、桁数エラー
  if numbers.length != digitNum
    return "digitErr"
  end

  #入力したナンバーの各要素に重複した要素がある場合、重複エラー
  numAry = numbers.split(//)
  if numAry.size != numAry.uniq.size
    return "overlapErr"
  end

  #エラーなしの場合、正常終了
  return "OK"

end
=begin 
メソッド：set_digit_num
説明：桁数設定
=end
def set_digit_num
  
  digitNum = 0  #桁数初期化

  #桁数が決定されるまで繰り返す
  while digitNum == 0
    puts ">>桁数を決めてください。(3～5桁)"
    digitNum = gets.to_i

    #3,4,5以外の入力は不正とする
    if ((digitNum != 3) && (digitNum != 4) && (digitNum != 5))
      puts "不正な入力です。「3～5」のいずれかを入力してください。"
      digitNum = 0; #「0」を強制設定し、処理を繰り替えさせる
    end
  end

  #設定した桁数を返却
  return digitNum

end

=begin 
メソッド：ask_number
説明：ナンバーの宣言し、相手のナンバーとの同一性を確認する（ゲーム本編）
=end
def ask_number(enemyNum,digitNum,ask_count)

  attackNum = "0"     #宣言ナンバー
  ret = "NG"          #ナンバーチェック結果
  youCorrect = false  #ゲーム終了フラグ

  ask_count += 1      #質問数をカウント(+1)
  puts "=============【ROUND:#{ask_count}】============="

  #ナンバーチェックが通るまで繰り返す
  while ret != "OK"
    puts ">>相手のナンバーを宣言してください。(#{digitNum}桁)"
    attackNum = gets.chomp

    #ナンバーチェック
    ret = check_numbers(attackNum,digitNum)
    if ret == "formErr"
      puts "不正な入力です。数字を入力してください。"
    elsif ret == "digitErr"
      puts "桁数が不正です。「#{digitNum}桁」の数字を入力してください。"
    elsif ret == "overlapErr"
      puts "数字が重複しています。同じ数字は2度以上使用できません。"
    end
  end

  #宣言ナンバー、相手ナンバーを配列化
  attackAry = attackNum.split(//)
  enemyAry = enemyNum.split(//)

  i = 0     #each用カウンタ
  hit = 0   #HIT数（一致した数）
  blow = 0  #BITE数（一致していないが含まれている数）

  #ナンバーが的中した場合ゲーム終了フラグを立てる
  if attackAry == enemyAry
    puts "=============【YOU CORRECT】============="
    youCorrect = true
  else
    #宣言ナンバーを、要素数分確認
    attackAry.each do |str|
      if str == enemyAry[i]
        #桁、数ともに一致している場合、HIT数をカウント(+1)
        hit += 1
      elsif enemyAry.include?(str)
        #桁は一致しないが、数自体は含まれている場合、BITE数をカウント(+1)
        blow += 1
      end
      i += 1
    end
    #HIT数、BITE数を提示
    puts "==>【HIT: #{hit}  BLOW: #{blow}】"
  end

  #質問数とゲーム終了フラグを返却
  return ask_count,youCorrect

end

#変数初期化
playerNum   = "0"   #プレイヤーのナンバー（対戦用）
enemyNum    = "0"   #相手CPUのナンバー
digitNum  = 0       #桁数
ask_count = 0       #質問回数（ラウンド数）
youCorrect = false  #ゲーム終了フラグ

puts "=============【数当てゲーム】============="

#ゲーム設定（桁数を決定）
digitNum = set_digit_num

#自分のナンバーを入力
#playerNum = input_player_number(digitNum)  #未実装のためコメントアウト

#相手CPUのナンバーを設定
enemyNum = set_enemy_number(digitNum)

#puts "自分：「#{playerNum}」"
#puts "相手：「#{enemyNum}」"

#ゲーム本編（ゲーム終了フラグが立つまで繰り返す）
while youCorrect == false
  #相手のナンバーを宣言、HIT(的中数)とBITE(含有数)を提供
  ask_count,youCorrect = ask_number(enemyNum,digitNum,ask_count)
end

#ゲームリザルト
puts "#{ask_count}回目の宣言で的中しました。"
puts "ゲームを終了します"
