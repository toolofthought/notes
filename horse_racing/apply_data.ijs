require 'tables/csv'
apply_data =: readcsv jpath '~home/sites/notes/horse_racing/apply_data.txt'
apply =: apply_strings i.~ apply_factors =: ~. apply_strings =: }. 1&{"1 apply_data

pared =: ; ". each }. 2&{"1 apply_data
public =: ; ". each }. 3&{"1 apply_data
gpa =: ; ".@(4&{.) each }. 4&{"1 apply_data

targetss =: +/\  = apply

features =:  1 ,. pared ,. public ,. gpa
base_features =: 0 ,. pared ,. public ,. gpa