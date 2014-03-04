def b n;"#{n} bottle"+(n>1??s:"")+" of beer";end
o,e=" on the wall",".\n"
99.downto(1){|n|$><<b(n)+o+", "+b(n)+e+(n>1?"Take one down and pass it around":"Go to the store and buy some more")+", "+b(n>1?n-1:99)+o+e+(n>1?"\n":"")}