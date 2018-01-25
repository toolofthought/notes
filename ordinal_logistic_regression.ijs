load jpath '~home/sites/notes/logistic_regression.ijs'

update_weight_backtracking_average_delta =: 4 : 0
'features targets' =. x
weights =. y
scores =. features (+/ .*) weights
predictions =. (^ % 1 + ^) scores
a =. 0.2
b =. 0.8
t =. 1

delta =. x gradient_average y
delta_olr =. x gradient_average y

while.
  trial =.(features ; targets) ll weights + t * delta_olr
  minimum_increment_guarantee =. ((features ; targets) ll weights) + a * delta (+/ .*) t * delta
  trial < minimum_increment_guarantee
do.
  t =. b * t
end.

base_weights ; y + t * delta_olr
)

OLR =: 4 : 0
features =. y
targets =. x

base_targets =. [`{.@.(2 <: #@$) targets 
base_weights =. ({: $ features) $ 0

epsilon =. 1e_8

NB. get base_weights
next =. (features; base_targets) update_weight_backtracking_average base_weights
while.
  epsilon < %: (+/ .*)~ next - base_weights 
do.
  base_weights =. next
  next =. (features; base_targets) update_weight_backtracking_average base_weights
end.

base_weights
)

