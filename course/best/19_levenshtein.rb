$<.map{|l|s,t=l.split
m,x=t.size
d=(0..m).to_a
s.size.times{|i|e=i+1
m.times{|j|x=[d[j+1]+1,e+1,d[j]+(s[i]==t[j]?0:1)].min
d[j]=e
e=x}
d[m]=x}
p x}