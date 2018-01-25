NB. load jpath '~home/sites/notes/logistic_regression.ijs'

update_weights_backtracking_average_delta =: 4 : 0
'features targets' =. x
'weights delta' =. y
scores =. features (+/ .*) weights
predictions =. (^ % 1 + ^) scores
grad =. x gradient_average weights
a =. 0.2
b =. 0.8
t =. 1

while.
  trial =.(features ; targets) ll weights + t * delta
  minimum_increment_guarantee =. ((features ; targets) ll weights) + a * grad (+/ .*) t * delta
  trial < minimum_increment_guarantee
do.
  t =. b * t
end.

(weights + t * delta) ; delta
)

OLR =: 4 : 0
features =. y
targets =. x
epsilon =. 1e_8

NB. 첫번째 targets으로 base weights을 정함
base_targets =. ]`{.@.(2 <: #@$) targets
base_weights =. base_targets LR features

ret =. ,: base_weights

for_i.
  >: i. <: # targets
do.
  t =. i { targets
  w =. base_weights
  delta =. ({: $ features) $ 1 0
  'next delta' =. (features; t) update_weights_backtracking_average_delta w ; delta
  while.
    epsilon < %: (+/ .*)~ next - w 
  do.
    w =. next
    'next delta' =. (features; t) update_weights_backtracking_average_delta w ; delta
  end.
  ret =. ret , w
end.
ret
)

NB. usage
NB. 'key 1 2 3' plot (^ % 1 + ^)  |: hours (+/ .*) |: (pass,pass2,:pass3) OLR hours
