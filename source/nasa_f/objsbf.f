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
C     Object Search By Function
C
C     Find the first object for which F(OBJECT) is TRUE.
C
      SUBROUTINE OBJSBF ( F, START, OBJLIS, OBJ, FOUND )
 
      IMPLICIT NONE
      INCLUDE              'object.inc'
      EXTERNAL              F
      LOGICAL               F
      INTEGER               START
      INTEGER               OBJLIS ( LBCELL : * )
      INTEGER               OBJ    ( 2 )
      LOGICAL               FOUND
 
C
C     Local Variables.
C
      INTEGER               PTR
      INTEGER               LAST
      INTEGER               SIZE
      INTEGER               MYBEG
      INTEGER               I
 
C
C     Since we may have to do a lot of lookups, we first
C     compress the object list to improve search performance.
C
      CALL OBJCMP ( OBJLIS )
 
 
 
      LAST  = OBJLIS ( NACTIV ) + 1
      SIZE  = OBJLIS ( RMPOBJ ) - 1
      MYBEG = MIN    ( MAX ( START, 1 ), LAST )
 
      DO I = MYBEG, LAST
 
         CALL OBJNTH ( OBJLIS, I, OBJ, FOUND )
 
         PTR = OBJ(1) + 1
C
C        If this object matches the selection criteria, we
C        can simply return it.
C
         IF ( FOUND ) THEN
            IF ( F( OBJLIS(PTR), SIZE ) ) THEN
               RETURN
            END IF
         END IF
 
      END DO
 
      FOUND  = .FALSE.
      OBJ(1) = NULL
      OBJ(2) = 0
 
      RETURN
      END
