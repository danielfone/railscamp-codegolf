def levenshtein(s1, s2)
  d = {}
  (0..s1.size).each do |row|
    d[[row, 0]] = row
  end
  (0..s2.size).each do |col|
    d[[0, col]] = col
    end
  (1..s1.size).each do |i|
    (1..s2.size).each do |j|
      cost = 0
      if (s1[i-1] != s2[j-1])
        cost = 1
      end
      d[[i, j]] = [d[[i - 1, j]] + 1,
                   d[[i, j - 1]] + 1,
                   d[[i - 1, j - 1]] + cost
                  ].min
      #next
      if (i > 1 and j > 1 and s1[i-1] == s2[j-2] and s1[i-2] == s2[j-1])
        d[[i, j]] = [d[[i,j]],
                     d[[i-2, j-2]] + cost
                    ].min
      end
    end
  end
  return d[[s1.size, s2.size]]
end

while line = gets do
  word1, word2 = line.split
  puts levenshtein word1.to_s, word2.to_s
end

