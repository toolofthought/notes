dot =: +/ .*
sigmoid =: ^ % 1 + ^

likelihood =: 4 : 0
'features targets' =. x
weights =. y

scores =. features dot weights
predictions =. sigmoid scores

(predictions ^ targets) (*/ .*) (-. predictions) ^ -. targets 
)

loglikelihood =: 4 : 0
'features targets' =. x
weights =. y

scores =. features dot weights
predictions =. sigmoid scores

+/ (targets * scores) - ^. 1 + ^ scores
)

gradient =: 4 : 0
'features targets' =. x
weights =. y
scores =. features dot weights
predictions=. sigmoid scores

(%#targets) * (|: features) dot targets - predictions
)

update_weights =: 4 : 0
'features targets' =. x
weights =. y
scores =. features dot weights
predictions=. sigmoid scores
delta =. (features ; targets) gradient weights
learning_rate =. 1

weights + learning_rate * delta
)

LR =: 4 : 0
targets =. x
features =. y
weights =. ({:$ features) $ 0

scores =. features dot weights
predictions=. sigmoid scores
epsilon =. 1e_8
max_iteration =. 1e6
iteration =. 0
delta =. (features ; targets) gradient weights

while.
  (epsilon < %: dot~ delta) *. (iteration < max_iteration)
do.
  weights =. (features ; targets) update_weights weights
  delta =. (features ; targets) gradient weights
  iteration =. >: iteration
end.

weights
)