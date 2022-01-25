# Planetary-motion-simulator
A simulation of the Solar System using verlet integration for 9 bodies, written in Fortran95.

The planetary_motion_simulator-directory contains the necessary files to run the program, input.dat and main.f90. The output file is created based on the input file, which should be formatted exactly like the one uploaded:

  number of planets (N=9)
  number of steps between each print to stdout (interval=20)
  number of steps between each save to output file (k=1000)
  the size of the time step (dt=60)
  the size of the whole simulation (t=315360000)
  x11,x12,x13 y11,y12,y13 m1
  x21,x22,x23 y21,y22,y23 m2
              .
              .
              .
              .
              .
              .
              .
              .
              .
  xN1,xN2,xN3 yN1,yN2,yN3 mN

The array above has units [xij]=E+09m (e.g. x41=149.596), [yij]=E+03m and [mi]=E+24kg (e.g. m1=1989000 and m4=5.9724).
