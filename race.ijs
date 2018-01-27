combbool=: 4 : 0
k=. <"1 (-i.1+d=.y-x)|."0 1 y{.1
z=. (d$<(0,y)$0),<,:y#0
for. i.x do. z=. k (+."1)&.> ,&.>/\. (_1&|."1)&.> z end.
; z
)

comb=: 4 : 0
  if. x e. 0 1 do. z=.<((x!y),x)$ i.y
  else. t=. |.(<.@-:)^:(i.<. 2^.x)x
    z=.({.t) ([:(,.&.><@;\.)/ >:@-~[\i.@]) ({.t)+y-x
    for_j. 2[\t do.
      z=.([ ;@:(<"1@[ (,"1 ({.j)+])&.> ])&.> <@;\.({&.><)~ (1+({.j)-~{:"1)&.>) z
      if. 2|{:j do. z=.(i.1+y-x)(,.>:)&.> <@;\.z end.
    end.
  end.
  ;z
)

permbool =: #~ 2 combbool #

second_conditional =: (+/ .*) %@-.

third_conditional =: 3 : 0
perm_index =. (, |."1) 2 comb # y
perm =. perm_index { y
numerators =. */"1 perm
denominators =. (*/"1) 1 - +/\"1 perm
numerators (+/ .*) % denominators
)

ws =: 0.00394115 0.0371231 0.0654936 0.423985 0.0433103 0.015889 0.164402 0.115082 0.10462 0.0261549
ss =: ws * 1 second_conditional\. ws
ts =: ws * 1 third_conditional\. ws

plot ws , (ws + ss) ,: (ws + ss + ts)
