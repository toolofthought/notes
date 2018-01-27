data =: |. ','&cutopen;._2 clipread ''
NB. 'ask bid sell' =: boxed =: 1 2 6 { |: data
NB. 'ask bid sell' =: ".@(-.&'"') each 1 2 7 { |: data
'ask bid sell' =: ".@(-.&'"') each boxed =: 1 2 7 { |: data
ask =: ,ask
bid =: ,bid
sell =: , sell
