diff =: 0 , 2 </\  bid__kinverse

features =: 1 ,. (- ^. bid__kindex) + (^. bid__kinverse)
predictions =: features (+/ .*) (diff LR features)

require 'plot'

pd 'reset'
pd 'sub 2 1'
pd 'new'
pd 'type line'
pd 'color blue'
pd 'key kindex kinverse'
pd - ^. bid__kindex

pd 'y2axis'
pd 'type line'
pd 'color red'
pd ^. bid__kinverse

pd 'new'
pd 'type dot'
pd 'pensize 4'
pd diff
pd features (+/ .*) diff LR features

pd 'show'