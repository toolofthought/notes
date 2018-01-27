load jpath '~home/sites/notes/asset.ijs'
kindex =: ('069500';'2017-10-27';'2017-10-27';'09:01:00';'15:00:00') conew 'asset'
kinverse =: ('114800';'2017-10-27';'2017-10-27';'09:01:00';'15:00:00') conew 'asset'
kinverse2 =: ('252670';'2017-10-27';'2017-10-27';'09:01:00';'15:00:00') conew 'asset'

diff =: 0 , 2 </\ bid__kinverse
