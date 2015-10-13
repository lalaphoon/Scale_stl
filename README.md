# Scale_stl

Used to absolute change the scale of .stl ACSII files
by simply reading though the old stl file [Currently, the input file should/must have an extention of .txt and output file can be a .stl file ] and find all floating point numbers (except for the line starting with 'facet normal')
and multiply by a certain scale.
All things will be printed into a new file.
ScaleSTLACSII(oldfile, newfile, scale).
Oldfile should exist in the same folder with this function.



