# ユーザー名
# 先頭に@がある
# @を抜いて最低3文字以上であること
# アルファベット大文字のみ
def check_name(name)
  # そもそも空だったら
  if( /\s/ =~ name || name == "")
    return '[required : 名前]'
  end
  # [@ A-Z]以外の文字があるか
  if( /[^@ A-Z]+/ =~ name )
    return '[invalid : 名前] 不正な文字が入っています'
  end
  # 先頭が@で始まり[A-Z]が3文字以上含まれているか
  if( /\A@[A-Z]{3,}\z/ =~ name)
    return name
  end
  return '[invalid : 名前] 先頭に@をつけて半角英語大文字のみで3文字以上入力してください'
end

# 電話番号
# 先頭0から始まること
# 11桁または10桁（ハイフン含まない）
# 数値のみ
# [3桁-4桁-4桁 or 4桁-3桁-3桁 or 3桁-3桁-4桁]に限りハイフン（半角）がある場合もない場合もOKとする
def check_tel(tel)
  # そもそも空だったら
  if( /\s/ =~ tel || tel == "")
    return '[required : 電話番号]'
  end

  # -を含まない数値以外の文字があるか
  if( /[^- 0-9]+/ =~ tel)
    return '[invalid : 電話番号] 不正な文字が入っています'
  end

  # ここまで来たらとりあえず-があって数値のみである
  # [3桁-4桁-4桁 or 4桁-3桁-3桁 or 3桁-3桁-4桁]の形式ならばtrue
  if( /\A\d{3}-\d{4}-\d{4}\z/ =~ tel || /\A\d{4}-\d{3}-\d{3}\z/ =~ tel || /\A\d{3}-\d{3}-\d{4}\z/ =~ tel)
  	return tel
  end

  # 先頭が0であり、[0-9]が10~11行であるか
  if( /\A0/ =~ tel && /\A\d{10,11}\z/ =~ tel)
  	return tel
  end

  return '[invalid : 電話番号] 先頭を0にして-を含めず文字数を10以上11以下で入力してください'
end

# 住所
# 7桁
# 数値のみ
# [3桁-4桁]に限りハイフン（半角）がある場合もない場合もOKとする
def check_address(address)
  # そもそも空だったら
  if( /\s/ =~ address || address == "")
    return '[required : 住所]'
  end

  # -を含めない、数値以外の文字があるか
  if( /[^- 0-9]+/ =~ address)
    return '[invalid : 住所] 不正な文字が入っています'
  end

  # [3桁-4桁]の形式はtrue
  if( /\A\d{3}-\d{4}\z/ =~ address )
  	return address
  end

  # 数値のみで7桁か
  if( /\A\d{7}\z/ =~ address)
  	return address
  end

  return '[invalid : 住所] 数値のみで7桁で入力してください'
end

# メールアドレス
# アドレス@ドメインの形式
# アルファベット大文字・小文字・半角数値・（+-_.!$#%）は可能文字とする
# ドメインには必ず.(ドット)が1つ以上存在する事
def check_mail(mail)
  # そもそも空だったら
  if( /\s/ =~ mail || mail == "")
    return '[required : メールアドレス]'
  end

  # 全角文字があるか、可能文字以外のものが入っているか
  if( /[^\x01-\x7E]+/ =~ mail || /[^+-_.!$#%@ a-z 0-9 A-Z]+/ =~ mail)
    return '[invalid : メールアドレス] 不正な文字が入っています'
  end

  # [xxx@xxx.xxx]の形式のみ通す
  if( /\A[a-z A-Z 0-9]+@+[a-z A-Z 0-9]+.+[a-z A-Z 0-9]+\z/ =~ mail )
  	return mail
  end

  return '[invalid : メールアドレス] xxx@xxx.xxxの形式で入力してください'
end

log  = Array.new

print '名前を入力（@を先頭につけ、3文字以上で半角英語大文字のみ） : '
name = gets.chomp
log.push(check_name(name))

print '電話番号を入力（先頭が0から始まり数値で10桁11桁以下(xxx-xxx-xxxx xxx-xxx-xxxx xxx-xxx-xxxx でも可)） : '
tel = gets.chomp
log.push(check_tel(tel))

print '住所を入力（すべて数値で7桁（xxx-xxxx でも可）） : '
address = gets.chomp
log.push(check_address(address))

print 'メールアドレスを入力（xxx@xxx.xxxの形式で） : '
mail = gets.chomp
log.push(check_mail(mail))

log.each{|logs|
  puts logs
}