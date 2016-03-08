# Anthony Skinner CSCI 305
import time
import re

class City:
#city object from ex. from: anaconda, to: anaconda, dist: 0

  def __init__(self, frm, to, dist, totalDist):
    self.frm = frm
    self.to = to
    self.dist = dist
    self.totalDist= totalDist

def search(cur):
    for r in range(len(grid)):
        #print grid[r][0].frm
        if(cur == grid[r][0].frm):
            return r

def dijsktra(initial, goal):
    visited = 

# OPEN THE CITY FILE
with open('city.txt') as f:
  #initialize the grid with objects of cities
  grid = []
  row = []
  i = 0

  for line in f:
    la = re.split(r'\s{2,}', line)
    if la[0].find("From") == -1 and la[0].find("-----------------------") == -1:
      #adding a new city pair with distance to the row of the 2D grid
      row.append(City(la[0],la[1],la[2], 999999))
     # print la[0], la[1], la[2], "\n"
    else:
      #go to the next row of the grid
      if(i>0):
        grid.append(row)
        #initialize a new row
        row = []
      else:
        i+=1
  if(len(row)>0):
    grid.append(row)



search('Baker')
