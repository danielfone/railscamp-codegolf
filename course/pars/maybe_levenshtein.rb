puts$<.map{|l|a,b=l.split
s,t=[a,b].map &:size
m=[(0..s).to_a]
1.upto(t){|j|m<<[j]+[0]*s}
t.times{|i|s.times{|j|m[i+1][j+1]=a[j]==b[i]?m[i][j]:[m[i][j+1],m[i+1][j],m[i][j],].min+1}}
m[-1][-1]}