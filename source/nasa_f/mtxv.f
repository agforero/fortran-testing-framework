C$Procedure      MTXV  ( Matrix transpose times vector, 3x3 )
 
      SUBROUTINE MTXV ( MATRIX, VIN, VOUT )
 
C$ Abstract
C
C     MTXV multiplies the transpose of a 3x3 matrix on the left with
C     a vector on the right.
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
C     MATRIX
C     VECTOR
C
C$ Declarations
 
      DOUBLE PRECISION  MATRIX   ( 3,3 )
      DOUBLE PRECISION  VIN      (   3 )
      DOUBLE PRECISION  VOUT     (   3 )
 
C$ Brief_I/O
C
C     VARIABLE  I/O              DESCRIPTION
C     --------  ---  --------------------------------------------------
C     MATRIX     I   3X3 double precision matrix.
C     VIN        I   3-dimensional double precision vector.
C     VOUT       O   3-dimensional double precision vector. VOUT is
C                    the product MATRIX**T * VIN.
C
C$ Detailed_Input
C
C     MATRIX     is an arbitrary 3x3 double precision matrix.
C                Typically, MATRIX will be a rotation matrix since
C                then its transpose is its inverse (but this is NOT
C                a requirement).
C
C     VIN        is an arbitrary 3-dimensional double precision
C                vector.
C
C$ Detailed_Output
C
C     VOUT       is a 3-dimensional double precision vector. VOUT is
C                the product VOUT = (MATRIX**T)  x (VIN).
C$ Parameters
C
C     None.
C
C$ Exceptions
C
C     Error free.
C
C$ Files
C
C     None.
C
C$ Particulars
C
C     The code reflects precisely the following mathematical expression
C
C        For each value of the subscript I from 1 to 3:
C
C        VOUT(I) = Summation from K=1 to 3 of  ( MATRIX(K,I) * VIN(K) )
C
C     Note that the reversal of the K and I subscripts in the left-hand
C     matrix MATRIX is what makes VOUT the product of the TRANSPOSE of
C     and not simply of MATRIX itself. 
C
C$ Examples
C
C     Typically the matrix MATRIX will be a rotation matrix. Because
C     the transpose of an orthogonal matrix is equivalent to its
C     inverse, applying the rotation to the vector is accomplished by
C     multiplying the vector by the transpose of the matrix.
C
C                -1
C     Let  MATRIX   * VIN = VOUT. If MATRIX is an orthogonal matrix,
C     then  (MATRIX**T) * VIN = VOUT.
C
C
C     If MATRIX  = |  1.0D0  1.0D0  0.0D0 |   and  VIN = |  5.0D0 |
C                  |                      |              |        |
C                  | -1.0D0  1.0D0  0.0D0 |              | 10.0D0 |
C                  |                      |              |        |
C                  |  0.0D0  0.0D0  1.0D0 |              | 15.0D0 |
C
C
C     then the call
C
C        CALL MTXV ( MATRIX, VIN, VOUT )
C
C     produces the vector
C
C
C        VOUT = | -5.0D0 |
C               |        |
C               | 15.0D0 |
C               |        |
C               | 15.0D0 |
C
C
C$ Restrictions
C
C     The user is responsible for checking the magnitudes of the
C     elements of MATRIX and VIN so that a floating point overflow does
C     not occur.
C
C$ Literature_References
C
C     None.
C
C$ Author_and_Institution
C
C     W.M. Owen       (JPL)
C
C$ Version
C
C-    SPICELIB Version 1.0.2, 23-APR-2010 (NJB)
C
C        Header correction: assertions that the output
C        can overwrite the input have been removed.
C
C-    SPICELIB Version 1.0.1, 10-MAR-1992 (WLT)
C
C        Comment section for permuted index source lines was added
C        following the header.
C
C-    SPICELIB Version 1.0.0, 31-JAN-1990 (WMO)
C
C-&
 
C$ Index_Entries
C
C     matrix_transpose times 3-dimensional vector
C
C-&
 
 
 
C
C     Local variables
C
      DOUBLE PRECISION  PRODV(3)
      INTEGER           I
 
 
C
C  Perform the matrix-vector multiplication
C
      DO I = 1, 3
        PRODV(I) = MATRIX(1,I)*VIN(1) +
     .             MATRIX(2,I)*VIN(2) +
     .             MATRIX(3,I)*VIN(3)
      END DO
 
C
C  Move the result into VOUT
C
      VOUT(1) = PRODV(1)
      VOUT(2) = PRODV(2)
      VOUT(3) = PRODV(3)
 
 
      RETURN
      END
