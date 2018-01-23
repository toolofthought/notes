l =: 4 : 0
'features targets' =. x
weights =. y

scores =. features (+/ .*) weights
predictions =. (^ % 1 + ^) scores
*/ (predictions ^ targets) * (-. predictions) ^ (-. targets)
)

D=: 1 : 'u"0 D.1'
VD=: 1 : 'u"1 D.1'

ll =: 4 : 0
'features targets' =. x
weights =. y

scores =. features (+/ .*) weights
predictions =. (^ % 1 + ^) scores
^. */ (predictions ^ targets) * (-. predictions) ^ (-. targets)
)

gradient =: 4 : 0
'features targets' =. x
weights =. y
scores =. features (+/ .*) weights
predictions =. (^ % 1 + ^) scores

(|: features) (+/ .*) targets - predictions
)

update_weight_backtracking =: 4 : 0
'features targets' =. x
weights =. y
scores =. features (+/ .*) weights
predictions =. (^ % 1 + ^) scores
a =. 0.2
b =. 0.8
t =. 1

delta =. x gradient y

while.
  trial =.(features ; targets) ll weights + t * delta
  minimum =. ((features ; targets) ll weights) + a * delta (+/ .*) t * delta
  trial < minimum
do.
  t =. b * t
end.

y + t * delta
)

update_weight =: 4 : 0
'features targets' =. x
weights =. y
scores =. features (+/ .*) weights
predictions =. (^ % 1 + ^) scores
delta =. x gradient y
learning_rate =. 1e_5

y + learning_rate * delta
)

LR =: 4 : 0
features =. y
targets =. x
weights =. ({: $ features) $ 0
epsilon =. 1e_6

next =. (features; targets) update_weight_backtracking weights
while.
  epsilon < %: (+/ .*)~ next - weights 
do.
  weights =. next
  next =. (features; targets) update_weight_backtracking weights
end.

weights
)

hours =: ".;._2 ] 0 : 0
1  0.5
1 0.75
1    1
1 1.25
1  1.5
1 1.75
1 1.75
1    2
1 2.25
1  2.5
1 2.75
1    3
1 3.25
1  3.5
1    4
1 4.25
1  4.5
1 4.75
1    5
1  5.5
)

pass =: 0 0 0 0 0 0 1 0 1 0 1 0 1 0 1 1 1 1 1 1