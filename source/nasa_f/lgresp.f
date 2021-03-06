C$Procedure LGRESP ( Lagrange interpolation on equally spaced points )
 
      DOUBLE PRECISION FUNCTION LGRESP (  N,      FIRST,  STEP,
     .                                    YVALS,  WORK,   X      )
 
C$ Abstract
C
C     Evaluate a Lagrange interpolating polynomial for a specified
C     set of coordinate pairs whose first components are equally
C     spaced, at a specified abscissa value.
C
C$ Disclaimer
C
C     THIS SOFTWARE AND ANY RELATED MATERIALS WERE CREATED BY THE
C     CALIFORNIA INSTITUTE OF TECHNOLOGY (CALTECH) UNDER A U.S.
C     GOVERNMENT CONTRACT WITH THE NATIONAL AERONAUTICS AND SPACE
C     ADMINISTRATION (NASA). THE SOFTWARE IS TECHNOLOGY AND SOFTWARE
C     PUBLICLY AVAILABLE UNDER U.S. EXPORT LAWS AND IS PROVIDED "AS-IS"
C     TO THE RECIPIENT WITHOUT WARRANTY OF ANY KIND, INCLUDING ANY
C     WARRANTIES OF PERFORMANCE OR MERCHANTABILITY OR FITNESS FOR A
C     PARTICULAR USE OR PURPOSE (AS SET FORTH IN UNITED STATES UCC
C     SECTIONS 2312-2313) OR FOR ANY PURPOSE WHATSOEVER, FOR THE
C     SOFTWARE AND RELATED MATERIALS, HOWEVER USED.
C
C     IN NO EVENT SHALL CALTECH, ITS JET PROPULSION LABORATORY, OR NASA
C     BE LIABLE FOR ANY DAMAGES AND/OR COSTS, INCLUDING, BUT NOT
C     LIMITED TO, INCIDENTAL OR CONSEQUENTIAL DAMAGES OF ANY KIND,
C     INCLUDING ECONOMIC DAMAGE OR INJURY TO PROPERTY AND LOST PROFITS,
C     REGARDLESS OF WHETHER CALTECH, JPL, OR NASA BE ADVISED, HAVE
C     REASON TO KNOW, OR, IN FACT, SHALL KNOW OF THE POSSIBILITY.
C
C     RECIPIENT BEARS ALL RISK RELATING TO QUALITY AND PERFORMANCE OF
C     THE SOFTWARE AND ANY RELATED MATERIALS, AND AGREES TO INDEMNIFY
C     CALTECH AND NASA FOR ALL THIRD-PARTY CLAIMS RESULTING FROM THE
C     ACTIONS OF RECIPIENT IN THE USE OF THE SOFTWARE.
C
C$ Required_Reading
C
C     None.
C
C$ Keywords
C
C     INTERPOLATION
C     POLYNOMIAL
C
C$ Declarations
 
      INTEGER               N
      DOUBLE PRECISION      FIRST
      DOUBLE PRECISION      STEP
      DOUBLE PRECISION      YVALS ( * )
      DOUBLE PRECISION      WORK  ( * )
      DOUBLE PRECISION      X
 
C$ Brief_I/O
C
C     Variable  I/O  Description
C     --------  ---  --------------------------------------------------
C     N          I   Number of points defining the polynomial.
C     FIRST      I   First abscissa value.
C     STEP       I   Step size.
C     YVALS      I   Ordinate values.
C     WORK      I-O  Work space array.
C     X          I   Point at which to interpolate the polynomial.
C
C     The function returns the value at X of the unique polynomial of
C     degree N-1 that fits the points in the plane defined by FIRST,
C     STEP, and YVALS.
C
C$ Detailed_Input
C
C     N              is the number of points defining the polynomial.
C                    The arrays XVALS and YVALS contain N elements.
C
C     FIRST,
C     STEP           are, respectively, a starting abscissa value and a
C                    step size that define the set of abscissa values
C                    at which a Lagrange interpolating polynomial is to
C                    be defined.  The set of abscissa values is
C
C                       FIRST   +   I * STEP,     I = 0, ..., N-1
C
C                    STEP must be non-zero.
C
C
C     YVALS          is an array of ordinate values that, together with
C                    the abscissa values defined by FIRST and STEP,
C                    define N ordered pairs belonging to the graph of
C                    a function.  The set of points
C
C                       (  FIRST  +  (I-1)*STEP,   YVALS(I)  )
C
C                    where I ranges from 1 to N, define the Lagrange
C                    polynomial used for interpolation.
C
C
C     WORK           is a work space array of the same dimension as
C                    XVALS and YVALS.  It is used by this routine as a
C                    scratch area to hold intermediate results. 
C
C
C     X              is the abscissa value at which the interpolating
C                    polynomial is to be evaluated.
C
C$ Detailed_Output
C
C     The function returns the value at X of the unique polynomial of
C     degree N-1 that fits the points in the plane defined by FIRST,
C     STEP, and YVALS.
C
C$ Parameters
C
C     None.
C
C$ Exceptions
C
C     1)  If STEP is zero, the error SPICE(INVALIDSTEPSIZE) will
C         be signaled.  The function will return the value 0.D0.
C
C     2)  If N is less than 1, the error SPICE(INVALIDSIZE) is
C         signaled.  The function will return the value 0.D0.
C
C     3)  This routine does not attempt to ward off or diagnose
C         arithmetic overflows.
C
C$ Files
C
C     None.
C
C$ Particulars
C
C     Given a set of N distinct abscissa values and corresponding
C     ordinate values, there is a unique polynomial of degree N-1,
C     often called the `Lagrange polynomial', that fits the graph
C     defined by these values.  The Lagrange polynomial can be used to
C     interpolate the value of a function at a specified point, given a
C     discrete set of values of the function.
C
C     Users of this routine must choose the number of points to use
C     in their interpolation method.  The authors of Reference [1] have
C     this to say on the topic:
C
C        Unless there is solid evidence that the interpolating function
C        is close in form to the true function f, it is a good idea to
C        be cautious about high-order interpolation.  We
C        enthusiastically endorse interpolations with 3 or 4 points, we
C        are perhaps tolerant of 5 or 6; but we rarely go higher than
C        that unless there is quite rigorous monitoring of estimated
C        errors.
C
C     The same authors offer this warning on the use of the
C     interpolating function for extrapolation:
C
C        ...the dangers of extrapolation cannot be overemphasized:
C        An interpolating function, which is perforce an extrapolating
C        function, will typically go berserk when the argument x is
C        outside the range of tabulated values by more than the typical
C        spacing of tabulated points.
C
C
C     For Lagrange interpolation on unequally spaced abscissa values,
C     see the SPICELIB routine LGRINT.
C
C$ Examples
C
C     1)  Fit a cubic polynomial through the points
C
C             ( -1,  -2 )
C             (  1,  -8 )
C             (  3,  26 )
C             (  5, 148 )
C
C         and evaluate this polynomial at x = 2.
C
C
C            PROGRAM TEST_LGRESP
C
C            DOUBLE PRECISION      LGRESP
C            DOUBLE PRECISION      ANSWER
C            DOUBLE PRECISION      FIRST
C            DOUBLE PRECISION      STEP
C            DOUBLE PRECISION      YVALS (4)
C            DOUBLE PRECISION      WORK  (4)
C            INTEGER               N
C
C            N         =   4
C            FIRST     =  -1.D0
C            STEP      =   2.D0
C
C            YVALS(1)  =  -2.D0
C            YVALS(2)  =  -8.D0
C            YVALS(3)  =  26.D0
C            YVALS(4)  = 148.D0
C
C            ANSWER    =   LGRESP ( N, FIRST, STEP, YVALS, WORK, 2.D0 )
C
C            WRITE (*,*) 'ANSWER = ', ANSWER
C            END
C
C
C        The returned value of ANSWER should be 1.D0, since the
C        unique cubic polynomial that fits these points is
C
C                     3       2
C           f(x)  =  x   +  2x  -  4x  -  7
C
C
C        We also could have invoked LGRESP with the reference
C
C            ANSWER   =   LGRESP ( N, FIRST, STEP, YVALS, YVALS, 2.D0 )
C
C        if we wished to; in this case YVALS would have been
C        modified on output.
C
C        If we had solved the same problem using a negative step,
C        we would have set the elements of YVALS in reverse order,
C        as shown below:
C
C            FIRST     =   5.D0
C            STEP      =  -2.D0
C
C            YVALS(1)  = 148.D0
C            YVALS(2)  =  26.D0
C            YVALS(3)  =  -8.D0
C            YVALS(4)  =  -2.D0
C
C            ANSWER    =   LGRESP ( N, FIRST, STEP, YVALS, WORK, 2.D0 )
C
C        The returned value of ANSWER would still be 1.D0.
C
C
C$ Restrictions
C
C     None.
C
C$ Literature_References
C
C     [1]  "Numerical Recipes---The Art of Scientific Computing" by
C           William H. Press, Brian P. Flannery, Saul A. Teukolsky,
C           William T. Vetterling (see sections 3.0 and 3.1).
C
C$ Author_and_Institution
C
C     N.J. Bachman   (JPL)
C
C$ Version
C
C-    SPICELIB Version 1.0.1, 10-JAN-2014 (NJB)
C
C        Updated description of the workspace array: now the array WORK
C        is not described as being allowed to coincide with the input
C        YVALS. Such overlap would be a violation of the ANSI Fortran
C        77 standard. Corrected several spelling errors in header
C        documentation.
C     
C-    SPICELIB Version 1.0.0, 14-AUG-1993 (NJB)
C
C-&
C
C$ Index_Entries
C
C     interpolate function using Lagrange polynomial
C     Lagrange interpolation
C
C-&
 
 
C
C     SPICELIB functions
C
      LOGICAL               RETURN
 
C
C     Local variables
C
      DOUBLE PRECISION      C1
      DOUBLE PRECISION      C2
      DOUBLE PRECISION      NEWX
 
      INTEGER               I
      INTEGER               J
 
 
C
C     Check in only if an error is detected.
C
      IF ( RETURN() ) THEN
         LGRESP = 0.D0
         RETURN
      END IF
 
C
C     No data, no interpolation.
C
      IF ( N .LT. 1 ) THEN
 
         LGRESP = 0.D0
 
         CALL CHKIN  ( 'LGRESP'                              )
         CALL SETMSG ( 'Array size must be positive; was #.' )
         CALL ERRINT ( '#',  N                               )
         CALL SIGERR ( 'SPICE(INVALIDSIZE)'                  )
         CALL CHKOUT ( 'LGRESP'                              )
         RETURN
 
      END IF
 
 
C
C     The step size must be non-zero.
C
      IF ( STEP .EQ. 0.D0 ) THEN
 
         LGRESP = 0.D0
 
         CALL CHKIN  ( 'LGRESP'                 )
         CALL SETMSG ( 'Step size was zero.'    )
         CALL SIGERR ( 'SPICE(INVALIDSTEPSIZE)' )
         CALL CHKOUT ( 'LGRESP'                 )
         RETURN
 
      END IF
 
C
C     We can simplify the interpolation problem by shifting
C     and scaling the abscissa values so that they start at 1
C     and are separated by a unit step.  All we need to do is
C     shift and scale X.
C
      NEWX  =  (  ( X - FIRST ) / STEP  )  +  1.D0
 
C
C     We're going to compute the value of our interpolating polynomial
C     at X by taking advantage of a recursion relation between
C     Lagrange polynomials of order n+1 and order n.  The method works
C     as follows for the case of abscissa values that are not
C     necessarily uniformly spaced:
C
C        Define
C
C           P               (x)
C            i(i+1)...(i+j)
C
C        to be the unique Lagrange polynomial that interpolates our
C        input function at the abscissa values
C
C           x ,  x   , ... x   .
C            i    i+1       i+j
C
C
C        Then we have the recursion relation
C
C           P              (x)  =
C            i(i+1)...(i+j)
C
C                                  x - x
C                                   i
C                                 -----------  *  P                (x)
C                                  x - x           (i+1)...(i+j)
C                                   i   i+j
C
C
C                                  x  -  x
C                                         i+j
C                               + -----------  *  P                (x)
C                                  x  -  x         i(i+1)...(i+j-1)
C                                   i     i+j
C
C
C        Repeated application of this relation allows us to build
C        successive columns, in left-to-right order, of the
C        triangular table
C
C
C           P (x)
C            1
C                    P  (x)
C                     12
C           P (x)             P   (x)
C            2                 123
C                    P  (x)
C                     23               .
C                             P   (x)
C           .                  234            .
C           .
C           .        .                               .
C                    .
C                    .        .                           P      (x)
C                             .                      .     12...N
C                             .
C                                             .
C
C                                      .
C
C
C                             P           (x)
C                              (N-2)(N-1)N
C                    P     (x)
C                     (N-1)N
C           P (x)
C            N
C
C
C        and after N-1 steps arrive at our desired result,
C
C
C           P       (x).
C            12...N
C
C     In the current case, we've arranged the problem so that
C
C       x    =   i.
C        i
C
C     We'll use the scratch array WORK to contain the current column of
C     our interpolation table.  To start out with, WORK(I) will contain
C
C        P (x).
C         I
C
C
      DO I = 1, N
         WORK(I) = YVALS(I)
      END DO
 
C
C     Compute columns 2 through N of the table.
C
      DO J = 1, N-1
 
         DO I = 1, N-J
 
            C1       =   DBLE(I+J)   -   NEWX
            C2       =   NEWX        -   DBLE(I)
 
            WORK(I)  =  (  C1 * WORK(I)  +  C2 * WORK(I+1)  )  / DBLE(J)
 
         END DO
 
      END DO
 
C
C     Our result is sitting in WORK(1) at this point.
C
      LGRESP = WORK(1)
 
      RETURN
      END
