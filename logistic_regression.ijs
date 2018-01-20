pd 'reset'

pd 'sub 3 1'
pd 'new'
pd 'type line'
pd 'key index inverse'
pd -bid__kindex
pd 'y2axis'
pd bid__kinverse

pd 'new'
pd 'type line'
pd -bid__kindex
pd 'y2axis'
pd bid__kinverse

up =: I. (0 , 2 </\ bid__kinverse)

pd 'type dot'
pd 'pensize 4'
pd 'color green'
pd up j. up { bid__kinverse

pd 'new'
pd 'type line'
pd -bid__kindex


pd 'show'
 