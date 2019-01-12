from tkinter import filedialog
from tkinter import Tk

Tk().withdraw()

try:
	folderName = filedialog.askdirectory(title="Change workspace - choose a folder")
	
	# changing / to \ to avoid problems while
	# working with batch scripts
	
	# if a drive folder is selected
	if folderName[-2] == ':' :
		print (folderName.replace('/', '\\\\'))
		# to avoid problems related with backslash 
		# and drive folders (C:, D: etc) in the 
		# while passing loca to choose_fildg module.
		
	# if any other folder is selected.
	else:
		print (folderName.replace('/', '\\'))

except:
	print()