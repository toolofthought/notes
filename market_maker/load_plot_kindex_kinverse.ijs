diff_up =: diff =: 0 , 2 </\ bid__kinverse2
diff_down =: 0 , 2 >/\ bid__kinverse2
sum =: (^. bid__kindex) + -: (^. bid__kinverse2)
mu =: (+/ % #) sum

pd 'reset'
pd 'key sum mu up down'
pd 'type line'
pd sum ,: mu

pd 'type dot'
pd 'pensize 4'
pd (I. diff_up) j. (I. diff_up) { sum
pd (I. diff_down) j. (I. diff_down) { sum
pd 'show'
