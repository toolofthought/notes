NB.* LevenbergMarquardt.ijs: Von Bertalanffy fit using Marquardt nonlinear 
NB. least squares.
NB. Need to type 'objective function' NLLS initial parameter list to execute
NB. outputs stats matrix & parm vector
NB.
NB. Written by R. O'Boyle Dec 2008

NB.    Inputs
NB. Data from Haddon (2001) page 92
years=:    1.0 2.0 3.3 4.3 5.3 6.3 7.3 8.3 9.3 10.3 11.3
length=:   15.4 26.93 42.23 44.59 47.63 49.67 50.87 52.3 54.77 56.43 55.88
initial=:  100 0.05 1.0

NB.    Constraints
ucnstrnt=: 60 1 2                        
lcnstrnt=: 30 0 0                         
cnstrnt=:  'ON'
alpha=:    0.001 * initial          NB. influence of penalty function
NB. Solution with Excel's SOLVER is linf= 55.9778, k= 0.385595, t0= 0.171371

VON_B=: 3 : 0
   'a b c'=. y
   l_pred=. a * (1 -^ - (b * years - c))
   length - l_pred
)

NLLS=: 1 : 0
NB. Marquardt nonlinear least squares
NB. Need to type 'objective function' NLLS initial parameter list to execute
NB. Need to supply upper & lower parameter constraints
NB. outputs stats matrix & parm vector
   identity=.=/~i.$y
   limit=.     200
   p=.     $par=. npar=. ,y
   rss=.     e +/ .* e=. u par
   n=.     $e
   pnlty=.    alpha PNLTY_FN par        NB. PENALTY FOR CONSTRAINTS
   nphi=.    phi=. rss + pnlty
   lambda=.    0.01    
   con=.     10
   j=. 0
   whilst.                        NB. Start of Main Loop
    1=<./(10>:i),(limit>:j),(0.0001<con=.(((n-p)*q +/ . * -v)%p*rss)^0.5), (0.00001<|(nphi-phi)%phi), (0.00001 +./ . < |(npar-par)%0.00000000000000000001 + |par) 
   do.
       j=.    j + 1
       par=.    npar
       phi=.    nphi
       de=. ((0.00001*|npar) + (0.00000001*npar= 0)) u D: 1 npar
       q=.    2 * de +/ . * e        NB.    Gradient
       hess=.    2 *  (] +/ . *"2 1 ]) de    NB.    Hessian
       if. 'ON' -: cnstrnt do.            NB. Start of Difference for penalty
           dpnlty=.    pnlty DIFF_PNLTY par
           q=.    q + {. dpnlty
           hess=.    hess + identity * {: dpnlty    NB. Adds penalty to diag of Hessian
       end.                                NB.    Difference for penalty

       lambda=.    0.000001 >. lambda * 0.01
       hess=.    hess + hess * identity * lambda=. lambda * 10
       norm=.    %:(+/"2 hess^2)          NB. Column norms
       hess=.    hess %" 1 1 norm         NB.    Scale Hessian to norm
       npar=.    par + v=.    (-q %. hess) % norm    NB. Step direction; step size= 1
       rss=.     e +/ . * e=. u npar
       pnlty=.     alpha PNLTY_FN par
       i=.     1
       if. (phi < nphi=. rss + pnlty) do.
           lambda=. lambda * 100
           while. (phi < nphi=. rss + pnlty) *. (i <: 10) do.
               i=.     i + 1
               npar=.     par + v=. v * 0.1^i
               rss=.     e +/ . * e=. u npar
               pnlty=.    alpha PNLTY_FN par
           end.
       end.
   end.                                 NB. End of Main Loop

   e=.    u npar
   msr=: {.(rss=. e +/ . * e) % n - p
   aic=: (^.rss) + 2*p%n              NB. AIC analog for least squares:
        NB. (Hongzhi,A. 1989. Acta Mathematica Applicatae Sinica. 5: 60-67)
        NB. Invert hessian & re-normalize
   hess_inv=: (%.hess)%"1 0 norm    
        NB. Covariance matrix (msr divided by hessian)
   cov=: 2 * msr * hess_inv
        NB. Standard error (diagonal of covariance matrix)
   par_se=: %:(+/"2 identity * cov)
        NB. Correlation matrix
   corr=:  cov%(*/~par_se)                
   cv=:    par_se % par
   stats=: 7 2 $ 'Loops'; j; 'Lambda'; lambda; 'No. Observations'; n; 'No. Parameters'; p; 'RSS'; rss; 'MSR'; msr; 'AIC'; aic
   parm=:     npar    
)

PNLTY_FN=: 4 : 0
NB.    Penalty function for specified constraints
NB. r= resultant penalty
NB. y= parameters
NB. x= vector of constants for the constraints
   if. 'ON' -: cnstrnt do.
       r=. +/(x, x)%(y-lcnstrnt),ucnstrnt-y 
NB. GENERIC LOWER AND UPPER CONSTRAINTS
   else.  r=. 0                         NB. Default is no penalty
   end.
)

DIFF_PNLTY=: 4 : 0
   r=.    2 0 $ 0
   identity=.=/~i.$y
   delta=.    (0.01*y) + (0.001*y= 0)
   tpar_f=.    y +" 1 1 (identity * delta)
   tpar_b=.    y -" 1 1 (identity * delta)
   for_a. i. $y do.    
       r1=.    (x-fpnlty=.alpha PNLTY_FN a { tpar_f)% a { delta
       bpnlty=.    alpha PNLTY_FN a { tpar_b
       r=.    r,.r1,(fpnlty+bpnlty-2*x)% a { delta
   end.
)
