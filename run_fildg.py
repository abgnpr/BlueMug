# run a program - select file dialog
# to select an .exe .py or .js file

from tkinter import Tk
from tkinter.filedialog import askopenfilename
import os

Tk().withdraw()

try:
	# loc.wsp is located in %LOCALAPPDATA%\BlueMug
	# loc.wsp is opened
	locationFile = open(os.environ['LOCALAPPDATA']+'\\BlueMug\\loc.wsp')

	# Reads the string in loc.wsp
	wspLocation = locationFile.readline()

	# strips the newline character '\n' from the end in wspLocation
	wspLocation = wspLocation[0:-1]

	# asks the user to select a file
	filename = askopenfilename(
		title="Run", 
		initialdir=(wspLocation),
		filetypes=(("executable or script","*.exe;*.py;*.js"), ("all files", "*.*")))

	# loc.wsp is closed
	locationFile.close()

	print(filename)
	
except:
	# to display errors when the loc.wsp file doesn't exist
	# this prompts the user to run BM so that it may create 
	# and define a new workspace, where the statements given
	# in the above try block will be executed.
	os.system('cls')
	os.system('color 47')
	os.system('echo.')
	os.system('echo.')
	print("         Run BM at least once!")
	os.system('echo.')
	os.system('echo.')
	os.system('pause')