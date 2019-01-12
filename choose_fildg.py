# choose an existing source file (for editiing)
# arguments - loca, extension, language, 
# prompt the user to select a file from 
# from among the files with the given extension
# print the name of the file selected
# else return blank

from tkinter import Tk
from tkinter.filedialog import askopenfilename
import sys

Tk().withdraw()

# get arguments from command line
loca=sys.argv[1]
ext =sys.argv[2]
lang=sys.argv[3]

# asks the user to select a file
filename = askopenfilename(
	title="Choose a " + lang + " source file", 
	initialdir=loca,
	# filetypes=((str(lang),'*'+ext)))
	filetypes=((lang,'*'+ext), ("no files", "")))

print(filename)