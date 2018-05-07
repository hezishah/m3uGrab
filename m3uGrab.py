import os
import sys
import re
from urllib.request import urlopen
import httplib2

def grab(uri):
    print(uri)
    master = []
    with open(uri[0],'r') as f:
        master = f.readlines()
    for line in master:
        if line.startswith('http'):
            search = re.search('http.*?:/(?:/([^/]+))+',line)
            filename = search[1].replace('.m3u8','.')+'mpeg'
            with open(filename,'wb') as outFile:
                child = urlopen(line).readlines()
                for line in child:
                    line = line.decode("utf-8")
                    if line.startswith('http'):
                        print(line)
                        response = urlopen(line.replace('\n',''))
                        outFile.write(response.read())



if __name__ == "__main__":
   grab(sys.argv[1:])
