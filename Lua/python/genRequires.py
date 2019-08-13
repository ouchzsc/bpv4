import os


def getFileList(rootDir, filelist):
    list_dirs = os.walk(rootDir)
    for root, dirs, files in list_dirs:
        for f in files:
            filelist.append(convertToluaReq(os.path.join(root, f)))


def convertToluaReq(fullpath):
    luapath, _ = fullpath.split('.')
    luapath = luapath.replace('\\', '.')
    filename = os.path.basename(fullpath)
    head, tail = filename.split('.')
    return "{mod} = require '{path}'\n".format(mod=head, path=luapath)


def wirteRequiresToFile(file, filelist):
    for line in filelist:
        file.write(line)


folder = "autoScript"
filename = "autoRequires.lua"

def runGenerate(folder,filename):
    filepath = os.path.join(folder, filename)

    if not os.path.exists(folder):
        os.mkdir(folder)

    curFileList = []
    getFileList("lua", curFileList)

    oldFileList = []
    if os.path.exists(filepath):
        file = open(filepath, "r")
        for line in file:
            oldFileList.append(line)
    else:
        file = open(filepath, "w")


    newFileList = []

    for line in oldFileList:
        if line in curFileList:
            newFileList.append(line)

    for line in curFileList:
        if not (line in oldFileList):
            newFileList.append(line)
            print("New:", line)

    file.close()
    file = open(filepath, "w")
    wirteRequiresToFile(file, newFileList)
    file.close()

runGenerate(folder,filename)