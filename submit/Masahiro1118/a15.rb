#!/usr/bin/env ruby
# encoding utf-8
require 'thor'

class THOR < Thor

  desc 'wcex','-fで全ての情報 -wで文字数 -cでバイト数 -l行数のみ'
  option :full, :type => :boolean, :aliases => '-f', :desc => "all"
  option :word, :type => :boolean, :aliases => '-w', :desc => "word"
  option :byte, :type => :boolean, :aliases => '-c', :desc => "byte"
  option :line, :type => :boolean, :aliases => '-l', :desc => "line"

  def wcex(fileName)
  # コマンドラインに入力されたファイルパスからファイルを開く
  file = File::open(fileName,"r")
  
  # バイト数だけはわかるので収納
  byte = file.size

  word = 0 
  line = 0
  
  # とりあえず数値求める
  while lines = file.gets
  	a = line.split(",").reject{|w| w.empty?}
  	line += 1
    word += a.length
  end

  # 表示させる
  if options[:word] then
    put "文字数 : #{word}"

  elsif options[:byte] then
    put "バイト数 : #{byte}"

  elsif options[:line] then
    put "行数 : #{lines}"
  
  else
    p "[lines : #{line} words : #{word} byte : #{byte}]"
  end
end

THOR.start(ARGV)