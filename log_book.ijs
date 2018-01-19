data =: _13 ]\  (LF, ',') cutopen clipread ''
NB. 'ask bid sell' =: boxed =: 1 2 6 { |: data
'ask bid sell' =: ".@(-.&'"') each 1 2 7 { |: data
sell =: , sell
