import subprocess
import os
import re
from pyds import MassFunction
import numpy as np

# General method for running any reasoner and outputs results to a file
def runReasoner(theory_file):
    reasoner = "clingo"
    options1 = "--verbose=0"
    options2 = "--models=0"
    (name,ext) = os.path.splitext(theory_file)
    output_file = name+".txt"
    f = open(output_file,'w')
    s = subprocess.run([reasoner,theory_file,options1,options2], stdout=f)
    return True

def evalOutput(theory):
    f = open(theory+".txt",'r')
    output = {'all':[],'satisfiable':[],'best_entity':''}

    # Get all the objects being reasoned about
    all_objects = []
    sat_objects=[]
    best_objects=[]
    flag_sat = False
    for line in f.readlines():
        word_list = line.split()
        for predicate in word_list:
            if "satisfiable(" in predicate:
                object = re.search('\(([^)]+)',predicate).group(1).split(",")[0]
                sat_objects.append(object)
                flag_sat = True
            if "bestObject(" in predicate:
                bo = re.search('\(([^)]+)',predicate).group(1).split(",")[0]
                best_objects.append(bo)
            if "object" in predicate:
                o = re.search('\(([^)]+)',predicate).group(1).split(",")[0]
                all_objects.append(o)
        output['satisfiable'] = sat_objects
        output['best_entity'] = best_objects[-1]
        output['all'] = all_objects

    # Assigning masses
    #all_objects_d = {x for x in all_objects}
    mass = MassFunction()
    mass[{best_objects[-1]}] = 0.5 #picking last object as best object, but it might be better to go with looking at all best objects and doing some overall stats.
    sat_objects_d = {x for x in sat_objects}
    mass[sat_objects_d] = 0.5

    # set remaining masses to zero
    rem_objects = np.setdiff1d(all_objects,sat_objects) #stuff in all_objects but not in sat_objects
    if len(rem_objects)!=0:
        rem_objects_d = {x for x in rem_objects}
        mass[rem_objects_d] = 0.0

    output['mass'] = mass

    # Check if theory is SATISFIABLE
    return output

def main():
    theory1  = "D1_can"
    # Run a particular reasoner
    runReasoner(theory1+".lp")
    # Extract useful things from the output
    results1 = evalOutput(theory1)
    print(results1["mass"].bel())
    print("-------------")
    theory2 = "D1_speaker"
    runReasoner(theory2+".lp")
    results2 = evalOutput(theory2)
    print(results2["mass"].bel())
    print("-------------")
    theory3 = "D1_norms"
    runReasoner(theory3+".lp")
    results3 = evalOutput(theory3)
    print(results3["mass"].bel())
    print("-------------")


    combined = results1["mass"] & results2["mass"] & results3["mass"]
    print(combined.bel())

    # Receive utterance and add to discourse history
    # Parse utterance and put objects into candidate objects list
    # Run reasoners against these objects and obtain measurements
    # Combine frame measurements and compute overall
    # Pick object with highest confidence

if __name__ == "__main__":

    main()
