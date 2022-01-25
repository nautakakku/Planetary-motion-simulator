# Planetary-motion-simulator
A simulation of the Solar System using verlet integration for 9 bodies, written in Fortran95.

The planetary_motion_simulator-directory contains the necessary files to run the program, input.dat and main.f90. The output file is created based on the input file, which should include the following items:

|item            |value           |
|----------------|----------------|
|n.o. planets (N)|9               |
|steps to stdout |20              |
|steps to save   |1000            |
|size of timestep|60              |
|size of simulation|315360000     |
|array of r, v and m|-|

The position and mass array should be formatted exactly like 'input.dat', where the first line contains all the info on object #1. First three elements are the (x, y, z)-positions, the second three elements are the (x, y, z)-velocities and the last element is the mass of the object. Position has the unit E+09 meters, velocity E+03 meters/second and mass the unit E+24 kilograms (these can be changed in the main program).

To run the code, simply compile it using a compiler of your choice and run the file it creates ('a.out').
