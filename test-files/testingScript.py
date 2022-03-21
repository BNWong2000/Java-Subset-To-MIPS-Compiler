import sys
import subprocess
from os import listdir
from os.path import isfile

outputFile = open("results.txt", "w")

inputFiles = listdir("SemChecker/")
inputFiles.sort()

for testFile in inputFiles:
    filePath = "SemChecker/" + testFile
    if(isfile(filePath)):
        outputFile.write("Testing SemChecker/" + testFile + " - ")
        cp = subprocess.run(["../main", filePath])
        outputFile.write("Returned " + str(cp.returncode))
        cpRef = subprocess.run(["/home/profs/aycock/411/TEST/reference/main", "-psemantic", "SemChecker/" + testFile])
        outputFile.write(", Ref returned " + str(cpRef.returncode) + "\n") 
        if cp.returncode != cpRef.returncode:
            outputFile.write("\n****************** FILE: " + testFile + " FAILED. ******************\n")

outputFile.close()

