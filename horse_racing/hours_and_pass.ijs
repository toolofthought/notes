NB. logistic regression example
NB. from wikipedia https://en.wikipedia.org/wiki/Logistic_regression
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

pass =:  0 0 0 0 0 0 1 0 1 0 1 0 1 0 1 1 1 1 1 1
pass2 =: 0 0 0 0 0 0 1 0 1 0 1 0 1 1 1 1 1 1 1 1
pass3 =: 0 0 0 0 0 0 1 0 1 1 1 1 1 1 1 1 1 1 1 1
pass4 =: 0 0 1 0 0 0 1 1 1 1 1 1 1 1 1 1 1 1 1 1