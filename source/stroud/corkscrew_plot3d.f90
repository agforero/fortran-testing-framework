program main

!*****************************************************************************80
!
!! MAIN is the main program for CORKSCREW_PLOT3D.
!
!  Discussion:
!
!    CORKSCREW_PLOT3D creates a plot of a 3D curve resembling a corkscrew.
!
!    This program creates files that must be processed by GNUPLOT.
!
!  Licensing:
!
!    This code is distributed under the GNU LGPL license.
!
!  Modified:
!
!    27 April 2018
!
!  Author:
!
!    John Burkardt
!
  implicit none

  character ( len = 255 ) command_filename
  integer ( kind = 4 ) command_unit
  character ( len = 255 ) data_filename
  integer ( kind = 4 ) data_unit
  character ( len = 9 ) :: header = 'corkscrew'
  integer ( kind = 4 ) i
  integer ( kind = 4 ) n
  real ( kind = 8 ), allocatable :: r(:)
  real ( kind = 8 ), parameter :: r8_pi = 3.141592653589793D+00
  real ( kind = 8 ), allocatable :: theta(:)
  real ( kind = 8 ) theta_max
  real ( kind = 8 ) theta_min
  real ( kind = 8 ), allocatable :: x(:)
  real ( kind = 8 ), allocatable :: y(:)
  real ( kind = 8 ), allocatable :: z(:)

  call timestamp ( )
  write ( *, '(a)' ) ''
  write ( *, '(a)' ) 'CORKSCREW_PLOT3D:'
  write ( *, '(a)' ) '  FORTRAN90 version'
  write ( *, '(a)' ) '  Define (X,Y,Z) data on a 3D curve.'
  write ( *, '(a)' ) '  Create corresponding GNUPLOT input files.'
!
!  Number of points in plot.
!
  n = 101
!
!  Allocate arrays.
!
  allocate ( r(1:n) )
  allocate ( theta(1:n) )
  allocate ( x(1:n) )
  allocate ( y(1:n) )
  allocate ( z(1:n) )
!
!  Define the data.
!
  call r8vec_linspace ( n, -2.0D+00, 2.0D+00, z )
  theta_min = - 6.0D+00 * r8_pi
  theta_max = + 6.0D+00 * r8_pi
  call r8vec_linspace ( n, theta_min, theta_max, theta )
  r(1:n) = 1.0D+00 + z(1:n) ** 2
  x(1:n) = r(1:n) * sin ( theta(1:n) )
  y(1:n) = r(1:n) * cos ( theta(1:n) )
!
!  Create the data file.
!
  call get_unit ( data_unit )

  data_filename = header // '_data.txt'

  open ( unit = data_unit, file = data_filename, status = 'replace' )

  do i = 1, n
    write ( data_unit, '(5(2x,g14.6))' ) x(i), y(i), z(i)
  end do

  close ( unit = data_unit )

  write ( *, '(a)' ) ' '
  write ( *, '(a)' ) '  CORKSCREW_PLOT3D: data stored in "' &
    // trim ( data_filename ) // '".'
!
!  Create the command file.
!
  call get_unit ( command_unit )

  command_filename = trim ( header ) // '_commands.txt'

  open ( unit = command_unit, file = command_filename, status = 'replace' )

  write ( command_unit, '(a)' ) '# ' // trim ( command_filename )
  write ( command_unit, '(a)' ) '#'
  write ( command_unit, '(a)' ) '# Usage:'
  write ( command_unit, '(a)' ) '#  gnuplot < ' // trim ( command_filename )
  write ( command_unit, '(a)' ) '#'
  write ( command_unit, '(a)' ) 'set term png'
  write ( command_unit, '(a)' ) 'set output "' // trim ( header ) // '_plot3d.png"'
  write ( command_unit, '(a)' ) 'set xlabel "X"'
  write ( command_unit, '(a)' ) 'set ylabel "Y"'
  write ( command_unit, '(a)' ) 'set zlabel "Z"'
  write ( command_unit, '(a)' ) 'set title "Corkscrew curve"'
  write ( command_unit, '(a)' ) 'set grid'
  write ( command_unit, '(a)' ) 'set style data lines'
  write ( command_unit, '(a)' ) 'splot "' // trim ( data_filename ) // &
    '" using 1:2:3 with lines'
  write ( command_unit, '(a)' ) 'quit'

  close ( unit = command_unit )

  write ( *, '(a)' ) '  CORKSCREW_PLOT3D: plot commands stored in "' &
    // trim ( command_filename ) // '".'
!
!  Free memory.
!
  deallocate ( r )
  deallocate ( theta )
  deallocate ( x )
  deallocate ( y )
  deallocate ( z )
!
!  Terminate.
!
  write ( *, '(a)' ) ''
  write ( *, '(a)' ) 'CORKSCREW_PLOT3D:'
  write ( *, '(a)' ) '  Normal end of execution.'

  return
end
subroutine get_unit ( iunit )

!*****************************************************************************80
!
!! GET_UNIT returns a free FORTRAN unit number.
!
!  Discussion:
!
!    A "free" FORTRAN unit number is a value between 1 and 99 which
!    is not currently associated with an I/O device.  A free FORTRAN unit
!    number is needed in order to open a file with the OPEN command.
!
!    If IUNIT = 0, then no free FORTRAN unit could be found, although
!    all 99 units were checked (except for units 5, 6 and 9, which
!    are commonly reserved for console I/O).
!
!    Otherwise, IUNIT is a value between 1 and 99, representing a
!    free FORTRAN unit.  Note that GET_UNIT assumes that units 5 and 6
!    are special, and will never return those values.
!
!  Licensing:
!
!    This code is distributed under the GNU LGPL license. 
!
!  Modified:
!
!    26 October 2008
!
!  Author:
!
!    John Burkardt
!
!  Parameters:
!
!    Output, integer ( kind = 4 ) IUNIT, the free unit number.
!
  implicit none

  integer ( kind = 4 ) i
  integer ( kind = 4 ) ios
  integer ( kind = 4 ) iunit
  logical lopen
 
  iunit = 0
 
  do i = 1, 99
 
    if ( i /= 5 .and. i /= 6 .and. i /= 9 ) then

      inquire ( unit = i, opened = lopen, iostat = ios )
 
      if ( ios == 0 ) then
        if ( .not. lopen ) then
          iunit = i
          return
        end if
      end if

    end if
 
  end do

  return
end
subroutine r8vec_linspace ( n, a, b, x )

!*****************************************************************************80
!
!! R8VEC_LINSPACE creates a vector of linearly spaced values.
!
!  Discussion:
!
!    An R8VEC is a vector of R8's.
!
!    4 points evenly spaced between 0 and 12 will yield 0, 4, 8, 12.
!
!    In other words, the interval is divided into N-1 even subintervals,
!    and the endpoints of intervals are used as the points.
!
!  Licensing:
!
!    This code is distributed under the GNU LGPL license.
!
!  Modified:
!
!    14 March 2011
!
!  Author:
!
!    John Burkardt
!
!  Parameters:
!
!    Input, integer ( kind = 4 ) N, the number of entries in the vector.
!
!    Input, real ( kind = 8 ) A, B, the first and last entries.
!
!    Output, real ( kind = 8 ) X(N), a vector of linearly spaced data.
!
  implicit none

  integer ( kind = 4 ) n

  real ( kind = 8 ) a
  real ( kind = 8 ) b
  integer ( kind = 4 ) i
  real ( kind = 8 ) x(n)

  if ( n == 1 ) then

    x(1) = ( a + b ) / 2.0D+00

  else

    do i = 1, n
      x(i) = ( real ( n - i,     kind = 8 ) * a   &
             + real (     i - 1, kind = 8 ) * b ) &
             / real ( n     - 1, kind = 8 )
    end do

  end if

  return
end
subroutine timestamp ( )

!*****************************************************************************80
!
!! TIMESTAMP prints the current YMDHMS date as a time stamp.
!
!  Example:
!
!    31 May 2001   9:45:54.872 AM
!
!  Licensing:
!
!    This code is distributed under the GNU LGPL license.
!
!  Modified:
!
!    06 August 2005
!
!  Author:
!
!    John Burkardt
!
!  Parameters:
!
!    None
!
  implicit none

  character ( len = 8 ) ampm
  integer ( kind = 4 ) d
  integer ( kind = 4 ) h
  integer ( kind = 4 ) m
  integer ( kind = 4 ) mm
  character ( len = 9 ), parameter, dimension(12) :: month = (/ &
    'January  ', 'February ', 'March    ', 'April    ', &
    'May      ', 'June     ', 'July     ', 'August   ', &
    'September', 'October  ', 'November ', 'December ' /)
  integer ( kind = 4 ) n
  integer ( kind = 4 ) s
  integer ( kind = 4 ) values(8)
  integer ( kind = 4 ) y

  call date_and_time ( values = values )

  y = values(1)
  m = values(2)
  d = values(3)
  h = values(5)
  n = values(6)
  s = values(7)
  mm = values(8)

  if ( h < 12 ) then
    ampm = 'AM'
  else if ( h == 12 ) then
    if ( n == 0 .and. s == 0 ) then
      ampm = 'Noon'
    else
      ampm = 'PM'
    end if
  else
    h = h - 12
    if ( h < 12 ) then
      ampm = 'PM'
    else if ( h == 12 ) then
      if ( n == 0 .and. s == 0 ) then
        ampm = 'Midnight'
      else
        ampm = 'AM'
      end if
    end if
  end if

  write ( *, '(i2,1x,a,1x,i4,2x,i2,a1,i2.2,a1,i2.2,a1,i3.3,1x,a)' ) &
    d, trim ( month(m) ), y, h, ':', n, ':', s, '.', mm, trim ( ampm )

  return
end
