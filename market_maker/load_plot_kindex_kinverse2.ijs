diff_up =: diff =: 0 , 2 </\ bid__kinverse
diff_down =: 0 , 2 >/\ bid__kinverse
sum =: (^. bid__kindex) +  (^. bid__kinverse)
mu =: (+/ % #) sum

pd 'reset'
pd 'type line'
pd sum
pd 'y2axis'
pd bid__kinverse
pd 'type dot'
pd 'pensize 4'
pd (I. diff_up) j. (I. diff_up) { bid__kinverse
pd (I. diff_down) j. (I. diff_down) { bid__kinverse
pd 'show'