words = File.readlines('/usr/share/dict/words').sample(100).map(&:chomp).map(&:downcase)

pairs = words.map do |w|
  i = rand
  w2 = case 
    when i < 0.005 then
      ''
    when i < 0.2 then
      w
    when i < 0.4 then
      w.dup.tap { |e| e[rand e.size] = '' }
    when i < 0.6 then
      w.dup.tap { |e|  e.insert rand(e.size), e.chars.sample(rand e.size).join }
    else
      words.sample(1)
  end
  [w, w2].shuffle
end

puts pairs.map {|a| a.join ' '}
