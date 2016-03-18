# Anthony Skinner CSCI 305
# I did this one solo

# This is the most recent version of python, so version 3
# The biggest thing when running it is to include quotes with everything, so putting "Bozeman, Billings" instead of just Bozeman, Billings

import re


def initUnvisited(dictionary):
    unvisited = {}
    for key, value in dictionary.items():
        unvisited.setdefault(key,{})["nowhere"] = 999
    return unvisited

def shortestUnvisited(unvisited):

    shortestPath = 999
    for frm, value in unvisited.items():
        for to, dist in value.items():
            if dist < shortestPath and dist > 0:
                shortestPath = dist
                frmm = frm
                too = to

    return shortestPath, frmm, too

def shortestPath(cur, goal, dictionary):
    start = cur
    visited = {}
    unvisited = initUnvisited(dictionary)
    unvisited.pop(cur, None)
    visited.setdefault(cur,{})[cur] = 0
    to = cur

    while(1):
        if cur == goal:
            break
        #update unvisited dictionary
        for city in dictionary[cur]:
            #couldn't think of a more efficient way
            if city in unvisited:
                for key in unvisited[city]:
                    if dictionary[cur][city]+visited[cur][to] < unvisited[city][key]:

                        unvisited[city].pop(key, None)
                        unvisited.setdefault(city,{})[cur] = (dictionary[cur][city]+visited[cur][to])
        #check if the unvisited is empty
        if bool(unvisited) == False :
            return None
        #pick next current and to
        sp, cur, to = shortestUnvisited(unvisited)
        unvisited[cur].pop(to, None)
        visited.setdefault(cur,{})[to] = sp

    return visited

#helper to Task 3
def connected(cur, to, visited, integer, path=[]):
    if cur == to:
        if len(path) <= integer:
            print "Yes"
            print "You can do it in",len(path),"hops"
            return path
        else:
            print "No"
            print "There is not a connection under",integer,"hops"
            return None
    path.append(to)
    for city, value in visited[to].items():
        connected(to, city, visited, path)


#Task 3 k hops
def shortestConn(frm, to, integer, dictionary):
    visited = shortestPath(frm, to, dictionary)
    if visited is None:
        print "No, there is no connection."
        return
    path = []
    connected(frm, to, visited, path)


#Task 4
def actualDist(frm, to, dictionary):
    visited = shortestPath(frm,to, dictionary)
    if visited == None:
        print "No, there is no connection."
        return

    for last in visited[to]:
        print "Yes"
        print "The shortest path between",frm,"and",to,"is",visited[to][last],"miles"

# OPEN THE CITY FILE
def initialize():
    with open('city.txt') as f:
      #initialize the grid with objects of cities
      dictionary = {}
      unvisited = {}
      for line in f:
        la = re.split(r'\s{2,}', line)
        if la[0].find("From") == -1 and la[0].find("-----------------------") == -1:
        #adding the same edge between the two cities
          dictionary.setdefault(la[0],{})[la[1]] = int(la[2])
          dictionary.setdefault(la[1],{})[la[0]] = int(la[2])

    return dictionary

#Task 1
def numCity(dictionary, city):
    if city in dictionary:
        print "There are", len(dictionary[city].keys()),"cities connected to", city
    else:
        print "You may have mispelled that name"

#Task 2
def directConn(dictionary, city1, city2):
    if city1 in dictionary[city2]:
        print "Yes, there is a direct connection between",city1,"and",city2
    else:
        print "There is no direct connection between", city1, "and",city2

def inputParams():
    while(1):
        print "Would you like to:"
        print "(1) See the number of cities directly connected to a city?"
        print "(2) Check if there is a direct connection between two cities?"
        print "(3) Check if there are k-hops between two cities?"
        print "(4) Check the total distance between two cities?"
        response = input("Choose 1, 2, 3, 4 or 5 to quit: ")
        if int(response)>5 or int(response)<1:
            print "Invalid response"
        else:
            break
    return int(response)

def main():
    while(1):
        dictionary = initialize()
        response = inputParams()
        print " "
        if response == 1:
            city = input("Which city do you want to find the # of connections for? Input should look like 'Bozeman' with quotes: ")
            numCity(dictionary,city.strip())
        elif response == 2:
            cities = input("Which two cities do you want to see if there is a direct connection? Input should look like this 'Bozeman, Billings' with quotes: ")
            c = re.split(',', cities)
            directConn(dictionary,c[0].strip(),c[1].strip())
        elif response == 3:
            cities = input("Which two cities do you want to see the number of hops? Take a guess too. Input should look like this 'Bozeman, Billings, 3' with quotes: ")
            c = re.split(',', cities)
            if c[0].strip() in dictionary and c[1].strip() in dictionary:
                shortestConn(c[0].strip(),c[1].strip(),int(c[2].strip()),dictionary)
            else:
                print "One of those cities may not exist, or you may have mispelled them."
        elif response == 4:
            cities = input("Which two cities do you want to see total distance? Input should look like this 'Bozeman, Billings' with quotes: ")
            c = re.split(',', cities)
            if c[0].strip() in dictionary and c[1].strip() in dictionary:
                actualDist(c[0].strip(),c[1].strip(), dictionary)
            else:
                print "One of those cities may not exist, or you may have mispelled them."
        else:
            print "Goodbye!"
            break
        print " "




main()
