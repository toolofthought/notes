require 'plot'
require 'numeric'
require 'format/printf'

require 'stats/base/univariate stats/base/multivariate'
require 'data/sqlite'

NB. asset class
coclass 'asset'
NB.  mfuture =: ('105M8000';'2017-08-09 09:01:00';'2017-08-09 15:45:00') conew 'asset'
query =: 'select %s from quotes where code="%s" and date(datetime) between "%s" and "%s" and time(datetime) between "%s" and "%s"'
path_to_db =: 'C:\Users\yunskim\sites\pytrader\database\db.sqlite3'
db =: sqlopen_psqlite_ path_to_db

create =: 3 : 0
'code fromDate toDate fromTime toTime' =: y
NB. price =: select 'price';code;fromDate;toDate;fromTime;toTime
ask =: select 'best_ask';code;fromDate;toDate;fromTime;toTime
bid =: select 'best_bid';code;fromDate;toDate;fromTime;toTime
NB. theoretical =: select 'theoretical_price';code;fromDate;toDate;fromTime;toTime

NB. mu =: 225 meanSmooth^:3 ask NB. 7.5분
NB. difference =: 0, 2 -~/\ mu
NB. interval이 시작하는 지점에서 5단계 후퇴합니다.
NB. buy =: >: I. _1 1 E. * difference
NB. buy보다 sell은 항상 커야합니다.
NB. buy와 sell은 항상 짝지어져야 합니다. 그래서 마지막 (<: # difference)를 추가합니다.
NB. sell =: (sell , <: # difference) {~ (sell =: >: I. 1 _1 E. * difference) I. buy
NB. theoretical =: select 'theoretical_price';code;from;to 

NB. priceRate =:  <: (% {.) price
NB. askRate =:  <: (% {.) ask
NB. bidRate =:  <: (% {.) bid
)

destroy =: codestroy

select =: 3 : 0
'column code fromDate toDate fromTime toTime' =. y
NB. printf는 화면에
NB. sprintf는 string을 생성
NB. 가격은 + - 가 앞에 붙어 있
if. (< column) e. 'price';'best_ask';'best_bid';'theoretical_price' do.
fillna | (1;0) {:: sqlread__db query sprintf column;code;fromDate;toDate;fromTime;toTime
else.
(1;0) {:: sqlread__db query sprintf column;code;fromDate;toDate;fromTime;toTime
end.
)

fillna =: 3 : 0
'backward' fillna y
:
opt =. x

if. opt -: 'backward' do.
  (13 : '(y {~ (<:#y) <. >: I. 0 = y) (I. 0 = y) } y')^:(0 e. ])^:_ y
elseif. opt -: 'forward' do.
  (13 : '(y {~ 0 >. <: I. 0 = y) (I. 0 = y) } y')^:(0 e. ])^:_ y
end.

)

map =: 3 : 0
0 1 map y
:
domain =. (<./ , >./) y
range =. x
step =. (-/ _1 0 { range) % -/ _1 0 { domain
(0{range) + step * y - 0 { domain
)

update =: 3 : 0
NB. price =: select 'price';code;fromDate;toDate;fromTime;toTime
ask =: select 'best_ask';code;fromDate;toDate;fromTime;toTime
bid =: select 'best_bid';code;fromDate;toDate;fromTime;toTime
NB. theoretical =: select 'theoretical_price';code;fromDate;toDate;fromTime;toTime
)

meanSmooth=: 3 : 0
  3 meanSmooth y
: 
  assert. 1=2|x 
  y=. (({.y)$~-:<:|x),y,({:y)$~-:<:|x NB. Weight end-points to move less. 
  if. 0<x do. x mean\y
  else. (|x)([: mean {. , {:)\y 
  end. NB. Neg. window averages only endpoints. 
)

movingAverage =: 3 : 0
  3 : movingAverage
:
  assert. 1=2|x 
  (y {.~ <:x), mean\ y 
)

generalSmooth=: 1 : 0
  3 mean generalSmooth y 
: 
  assert. 1=2|x 
  y=. (({.y)$~-:<:|x),y,({:y)$~-:<:|x NB. Weight end-points to move less.  
  ;,x u\y
)

linterpEnds=: 3 : '(0{y)+((<:#y)%~-/_1 0{y)*i.#y'
gmSmooth=: 4 : '(#y){.x linterpEnds generalSmooth y'
lintSmooth=: 4 : '(0{x)gmSmooth (1{x)meanSmooth^:(2{x)"1 y'
