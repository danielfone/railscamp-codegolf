puts$<.map{|l|a,b=l.split
s,t=[a,b].map &:size
d={}
0.upto(s){|i|d[[i,0]]=i}
0.upto(t){|i|d[[0,i]]=i}
s.times{|i|t.times{|j|d[[i+1,j+1]]=[d[[i,j+1]]+1,d[[i+1,j]]+1,d[[i,j]]+(a[i]!=b[j]?1:0)].min}}
d[[s,t]]}