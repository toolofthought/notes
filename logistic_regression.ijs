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

update_weights_given_delta =: 4 : 0
'features targets' =. x
'weights delta' =. y
scores =. features dot weights
predictions=. sigmoid scores
grad =. (features ; targets) gradient weights
learning_rate =. 1

(weights + learning_rate * delta * grad dot delta) ; delta 
)

LR =: 4 : 0
targets =. x
features =. y
weights =. ({:$ features) $ 0

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

OLR =: 4 : 0
targetss =. x
features =. y

if. 1 >: # $ targetss
do.
  'length error' return.
end.

base_weights =.  ({. targetss) LR features
weightss =. ,: base_weights

for_j.
  >: i. # }. targetss
do.
  targets =. j { targetss
  delta =. ({:$ features) {. 1 0
  grad =. (features ; targets) gradient base_weights
  weights =. base_weights
  
  epsilon =. 1e_8
  max_iteration =. 1e6
  iteration =. 0  
  while.
    (epsilon < %: dot~ grad dot delta) *. (iteration < max_iteration)
  do.
    'weights delta' =. (features ; targets) update_weights_given_delta weights ; delta
    grad =. (features ; targets) gradient weights
    iteration =. >: iteration
  end.
  weightss =. weightss , weights
end.

weightss
)

