from tkinter import Tk
from tkinter.filedialog import askopenfilename
import os

Tk().withdraw()

try:
	locationFile = open(os.environ['LOCALAPPDATA']+'\\BlueMug\\loc.wsp')

	wspLocation = locationFile.readline()

	wspLocation = wspLocation[0:-1]

	filename = askopenfilename(
		title="Run", 
		initialdir=(wspLocation),
		filetypes=(("executable or script","*.exe;*.py;*.js"), ("all files", "*.*")))

	locationFile.close()

	print(filename)
	
except:
	os.system('cls')
	os.system('color 47')
	os.system('echo.')
	os.system('echo.')
	print("         Run BM at least once!")
	os.system('echo.')
	os.system('echo.')
	os.system('pause')