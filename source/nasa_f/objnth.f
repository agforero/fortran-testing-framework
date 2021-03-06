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
C     Return the N'th object from an object list.
C
      SUBROUTINE OBJNTH ( OBJLIS, N, OBJ, FOUND )
 
      IMPLICIT NONE
      INCLUDE              'object.inc'
 
      INTEGER               OBJLIS ( LBCELL: * )
      INTEGER               N
      INTEGER               OBJ    ( 2 )
      LOGICAL               FOUND
 
C
C     SPICELIB Functions
C
      INTEGER               CARDI
C
C     Local Variables
C
      INTEGER               MTASIZ
      INTEGER               NOBJ
      INTEGER               SIZE
      INTEGER               USED
      INTEGER               PTR
      INTEGER               I
 
 
      NOBJ   = OBJLIS ( NACTIV )
      MTASIZ = OBJLIS ( RMPOBJ )
      SIZE   = CARDI  ( OBJLIS )
      USED   = NOBJ * MTASIZ
 
      IF ( N .LE. 0 ) THEN
         OBJ(1) = 0
         OBJ(2) = NULL
         FOUND  = .FALSE.
         RETURN
      END IF
 
      IF ( N .GT. NOBJ ) THEN
         OBJ(1) = 0
         OBJ(2) = NULL
         FOUND  = .FALSE.
         RETURN
      END IF
C
C     The easy case is the one in which all objects are packed
C     together with no null objects between them.
C
      IF ( USED .EQ. SIZE ) THEN
         PTR    = (N-1)*MTASIZ + 1
         OBJ(1) = PTR
         OBJ(2) = OBJLIS(PTR)
         FOUND  = .TRUE.
         RETURN
      END IF
C
C     Hmmmm.  Well we don't have the easy case.  Look through
C     the objects until we find the n'th non-null object.
C
      PTR = 1 - MTASIZ
 
      DO I = 1, N
 
         PTR = PTR + MTASIZ
 
         DO WHILE ( OBJLIS(PTR) .EQ. NULL )
            PTR = PTR + MTASIZ
         END DO
 
      END DO
 
      OBJ(1) = PTR
      OBJ(2) = OBJLIS(PTR)
      RETURN
 
      END
