NB.*update_weight v update weights for log-likelihood function for logistic regression
NB.
NB. syntax:
NB.   (features ; targets) update_weight weights 
NB. where
NB.   features  - M-by-N matrix,
NB.   targets   - M-by-1 matrix, 
NB.   weights   - M-by-N matrix

update_weight =: 4 : 0
step_size =. 1e_3
weights =. y
'features targets' =. x
scores =. features (+/ .*) weights
predictions =. (^ % 1 + ^) scores
gradient =. (|: features) (+/ .*) (targets - predictions)  
weights =. weights + step_size * gradient
)

NB.*LR v logistic regression
NB.
NB. syntax:
NB.   targets LR features 
NB. where
NB.   features  - M-by-N matrix,
NB.   targets   - M-by-1 matrix, 
NB.
LR =: 4 : 0
features =. y
targets =. x
weights =. ({: $ features) $ 0
(features ; targets) update_weight^:_ weights
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