program main
 implicit none
 real(kind=16),allocatable :: orbiters(:,:),a(:,:),r(:,:),dr(:),v(:,:),m(:)
 real :: start,now
 integer :: N,t,dt,ios,i,interval,k

 call cpu_time(start)
 open(unit=1,file='input.dat',status='old',iostat=ios)

 !some basic error handling
 if(ios .ne. 0) then
  print*,"Error opening the input file."
  stop
 end if
 
 !read the input file, the first three lines are reserved for the parameters given in the assignment
 read(1,*) N
 read(1,*) interval
 read(1,*) k
 read(1,*) dt
 read(1,*) t
 print*,t
 allocate(orbiters(7,N),r(3,N),a(3,N),dr(3),v(3,N),m(N))
 do i=1,N
  read(1,*) orbiters(:,i)
 end do
 close(1)

 !converting units to [r]=m,[v]=m/s and [m]=kg
 r(1:3,:)=orbiters(1:3,:)*10**9
 v(1:3,:)=orbiters(4:6,:)*10**3
 m(:)=orbiters(7,:)*10**24

 !open the output file w/ more error handling
 open(unit=2,file='output.dat',status='old',iostat=ios)
 if(ios .ne. 0) then
  print*,"Error opening the output file."
  stop
 end if
 
 !use the subroutine defined in the end of the program file 
 call verletint(t,dt,r,v,m,N,interval,k)
 close(2)

contains

 !the integrator takes in the positions, velocities and masses for N objects
 !the subroutine prints the info box in the stdout every interval and
 !writes the positions of the objects in the output file every kth iteration

subroutine verletint(t,dt,r,v,m,N,interval,k)
 integer,intent(in) :: N,k,t,dt
 real(kind=16),intent(inout) :: r(3,N),v(3,N),m(N)
 real(kind=16) :: dr(3),r_mag,a(3,N),anew(3,N),rnew(3,N),G=6.67e-11,m2AU
 integer :: counter,steps,i,j,p,interval
 steps=t/dt
 counter=0
 p=0
 m2AU=6.68458712e-12

 !the integrator computes the acceleration for each object at every time step by
 !adding each other object's gravitational effect to the acceleration-array

 !the counter goes through all the steps; steps=total_time/time_step
 a=0
 anew=0
 rnew=0

 do while(counter .le. steps)
  do i=1,N
   r(1:3,i)=r(1:3,i)+v(1:3,i)*dt+0.5*a(1:3,i)*dt**2
   !calculate the new acceleration of the object
   do j=1,N
    !the integrator skips one iteration, when it tries to compute the object's gravitational effect on itself
    if(i .eq. j) cycle
    dr(1:3)=r(1:3,j)-r(1:3,i)
    r_mag=sqrt(dr(1)**2+dr(2)**2+dr(3)**2)
    anew(1:3,i)=anew(1:3,i)+G*m(j)*dr(1:3)/r_mag**3
   end do
   v(1:3,i)=v(1:3,i)+0.5*(a(1:3,i)+anew(1:3,i))*dt
   a(1:3,i)=anew(1:3,i)
   anew=0

  end do

  !if statements to check whether to write or not to write
  if(mod(counter,interval) .eq. 0 .OR. counter .eq. 0 .OR. counter .eq. steps) then
   call cpu_time(now)
   if(mod(counter,k) .eq. 0) then 
    do j=1,N
     write(2,*) r(:,j)*m2AU
    end do
    p=p+1
   end if

   !the info box to stdout
   print'(a,1x,f7.3,a)','Time:',now-start,' seconds'
   print 10,'# objects:',N
   print 10,'# steps:',counter
   print 10,'# positions written:',p
   print'(a)','The x,y-coordinates of each body in the Solar System in astronomical units'
   print 11,'Sun      :',r(1:2,1)*m2AU
   print 11,'Mercury  :',r(1:2,2)*m2AU
   print 11,'Venus    :',r(1:2,3)*m2AU
   print 11,'the Earth:',r(1:2,4)*m2AU
   print 11,'Mars     :',r(1:2,5)*m2AU
   print 11,'Jupiter  :',r(1:2,6)*m2AU
   print 11,'Saturnus :',r(1:2,7)*m2AU
   print 11,'Uranus   :',r(1:2,8)*m2AU
   print 11,'Neptunus :',r(1:2,9)*m2AU
   print'(/)',

   10 format (a,1x,i0)
   11 format (a,1x,f15.7,f15.7)
  end if
  counter=counter+1
 end do

end subroutine verletint 
end program main
