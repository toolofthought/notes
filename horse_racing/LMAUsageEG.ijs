NB.* LMAUsageEG.ijs: example of using Levenberg-Marquardt algorithm to solve a
NB. known problem: lLeast squares problem from Bard (1974) page 124.
NB. Constraints and boundaries as per Bard

NB.    Inputs
time=: 0.1 0.2 0.3 0.4 0.5 0.05 0.1 0.15 0.2 0.25 0.02 0.04 0.06 0.08 0.1
temp=: 100 100 100 100 100 200 200 200 200 200 300 300 300 300 300
fract=: 0.98 0.983 0.955 0.979 0.993 0.626 0.544 0.455 0.225 0.167 0.566 0.317 0.034 0.016 0.066
initial=: 750 1200

NB.    Constraints
ucnstrnt=: 1000 2000
lcnstrnt=: 500 750
cnstrnt=: 'OFF'

alpha=: 0.001 * initial            NB. influence of penalty function
NB. Unconstrained solution by Bard (1974) is a= 813.4583 and b= 960.9063

LS_PROB=: 3 : 0
   'a b'=. y
   fract - ^-a*time * ^-b%temp
)

eg_usage_=: 0 : 0
   'LS_PROB' NLLS 750 1200
)
