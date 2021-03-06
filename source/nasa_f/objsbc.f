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
C     Search an object list by component
C
      SUBROUTINE OBJSBC (  VALUE, COMP, OBJLIS, OBJ, FOUND )
 
      IMPLICIT NONE
      INCLUDE              'object.inc'
      INTEGER               VALUE
      INTEGER               COMP
      INTEGER               OBJLIS ( LBCELL : * )
      INTEGER               OBJ    ( 2 )
      LOGICAL               FOUND
 
C
C     SPICELIB Functions
C
      INTEGER               OBJACT
C
C     Local Variables
C
      INTEGER               N
      INTEGER               I
      INTEGER               PTR
 
C
C     First compress the object list
C
      CALL OBJCMP ( OBJLIS )
      N =  OBJACT ( OBJLIS )
 
      DO I = 1, N+1
         CALL OBJNTH ( OBJLIS, I, OBJ, FOUND )
 
         IF ( FOUND ) THEN
            PTR = OBJ(1) + COMP
 
            IF ( OBJLIS(PTR) .EQ. VALUE ) THEN
               RETURN
            END IF
         END IF
      END DO
C
C     If you get to this point you tried to get the N+1st object
C     (and there are only N)  FOUND will be FALSE and OBJ
C     will be a null object.  So we can just return.
C
      RETURN
      END
