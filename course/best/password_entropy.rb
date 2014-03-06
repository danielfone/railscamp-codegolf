puts$<.map{|p|a=->r,s{p[r].to_s.size*s}
p[0]&&b=4+a[1..7,2]+a[8..19,1.5]+a[20..-1,1]
u=p=~/[A-Z]/
l=p=~/[a-z]/
n=p=~/\d/
o=p=~/[^\w]/
u&&l&&o&&n&&b+=6
u&&l&&o&&!n&&b+=5
n&&o&&!u&&!l&&b-=2
n&&!o&&!u&&!l&&b-=6
p[' ']||b-=2
p.count(' ')>2&&b+=1
b}