dwt =: 3 : 0
A =. (2 ^ _0.5) * 1 1 ,: 1 _1
'approximation detail' =. |: _2 A&(+/ .*)\ y
approximation ; detail
)

dwt2 =: 3 : 0
A =. (2 ^ _1) * 1 1 ,: 1 _1
'approximation detail' =. |: _2 A&(+/ .*)\ y
approximation ; detail
)

approx2 =: 3 : 0
A =. (2 ^ _1) * 1 1 ,: 1 _1
'approximation detail' =. |: _2 A&(+/ .*)\ y
approximation
)

get_approx =: 13 : '(2^x) # (approx2^:x) y' "0 _

idwt =: 3 : 0
'approximation detail' =. y
A =. (2 ^ _0.5) * 1 1 ,: 1 _1
, A (+/ .*)"_ 1 approximation ,. detail
)