def post_review(a_posts)      #レビュー投稿
  post = {}
  puts "ジャンルを入力："
  post[:genre] = gets.chomp
  puts "タイトルを入力："
  post[:title] = gets.chomp
  puts "感想を入力してください："
  post[:review] = gets.chomp
  puts "公開年を入力してください："
  post[:year] = gets.chomp
  puts "作品を星の数で評価してください。1~5の数字を入力してください"
    condition = true
    while condition do
      input = gets.to_i
      if input <= 5
      condition = false
      else
      puts "無効な数値です。1~5の数字を入力してください"
      condition = true
      end
    end

    post[:star] = input

      if post[:star] == 1
      star = "★"
      elsif post[:star] == 2
        star = "★★"
      elsif post[:star] == 3
        star = "★★★"
      elsif post[:star] == 4
        star = "★★★★"
      elsif post[:star] == 5
        star = "★★★★★"
      end
      post[:rate] = star

  a_posts << post

  return a_posts
  end

  def star_sort(a_posts)
  puts "読みたい星の数を1~5で入力してください"
  input = gets.to_i

  a_posts.each do |post|
    if post[:star] == input
      stars = ["★","★★","★★★","★★★★","★★★★★"]
      line = "----------------------------------"
      puts "ジャンル：#{post[:genre]}\n#{line}"
      puts "タイトル：#{post[:title]}\n#{line}"
      puts "感想：#{post[:review]}\n#{line}"
      puts "公開年：#{post[:review]}\n#{line}"
      puts "評価：#{stars[input - 1]}\n#{line}"
    end
  end
end

  def year_search(a_posts)
    a_posts.each do|post|
    line = "-----------------------------------"
    puts "映画の公開年を入力してください"
    input = gets.chomp
      if input == "#{post[:year]}"
      puts "ジャンル：#{post[:genre]}\n#{line}"
      puts "タイトル：#{post[:title]}\n#{line}"
      puts "感想：#{post[:review]}\n#{line}"
      puts "公開年：#{post[:year]}\n#{line}"
      puts "評価：#{post[:rate]}\n#{line}"
      else
      puts "その年の映画について書かれたレビューはありません"
      end
    end
  end


  def latest_movies(a_posts)
    a_posts.each do|post|
    line = "-----------------------------------"
      if post[:year].to_i >= 2017
        puts "ジャンル：#{post[:genre]}\n#{line}"
        puts "タイトル：#{post[:title]}\n#{line}"
        puts "感想：#{post[:review]}\n#{line}"
        puts "公開年：#{post[:year]}\n#{line}"
        puts "評価：#{post[:rate]}\n#{line}"
      end
    end
  end


def read_reviews(a_posts)
  number = 0

  a_posts.each do|post|
    puts "[#{number}]：#{post[:title]}のレビュー"
    number = number + 1
  end

  puts "見たいレビューの番号を入力してください："

  input = gets.to_i
  post = a_posts[input]
  line = "----------------------------------"
  puts "ジャンル：#{post[:genre]}\n#{line}"
  puts "タイトル：#{post[:title]}\n#{line}"
  puts "感想：#{post[:review]}\n#{line}"
  puts "公開年：#{post[:year]}\n#{line}"
  puts "評価：#{post[:rate]}\n#{line}"
end

def end_program
  exit
end

def exception
  puts "無効な数値です"
end

posts = []

while true do
  puts "レビュー数：#{posts.length}\n[0]レビューを書く\n[1]レビューを読む\n[2]レビューを評価順で検索する\n[3]公開年で検索する\n[4]最近公開のレビューのみ表示する\n[5]アプリを終了する"
  puts "番号を入力してください"
  input = gets.to_i

  if input == 0
    post_review(posts)
  elsif input == 1
    read_reviews(posts)
  elsif input == 2
    star_sort(posts)
  elsif input == 3
    year_search(posts)
  elsif input == 4
    latest_movies(posts)
  elsif input == 5
    end_program
  else
    exception
  end
end


