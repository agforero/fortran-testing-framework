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
C     Round the windows for objects inward.
C
      SUBROUTINE FILTEM ( KERTYP, OBNAM,  OBJLIS, FROM, TO,
     .                    FILWIN, TMPWIN,
     .                    WINSYM, WINPTR, WINVAL )

      IMPLICIT NONE
      INTEGER               LBCELL
      PARAMETER           ( LBCELL = -5 )

      CHARACTER*(*)         KERTYP
      LOGICAL               OBNAM
      INTEGER               OBJLIS ( LBCELL : * )
      DOUBLE PRECISION      FROM
      DOUBLE PRECISION      TO
      DOUBLE PRECISION      FILWIN ( LBCELL : * )
      DOUBLE PRECISION      TMPWIN ( LBCELL : * )
      CHARACTER*(*)         WINSYM ( LBCELL : * )
      INTEGER               WINPTR ( LBCELL : * )
      DOUBLE PRECISION      WINVAL ( LBCELL : * )

C
C     Spicelib Functions
C
      LOGICAL               WNINCD
      INTEGER               OBJSIZ
C
C     Local Variables.
C
      INTEGER               N
      INTEGER               OBJ  ( 2 )
      INTEGER               OBJN ( 2 )
      INTEGER               OBJECT ( 3 )
      INTEGER               SOBJ

      LOGICAL               FOUND
      LOGICAL               FND
      LOGICAL               KEEP

      INTEGER               WDSIZE
      PARAMETER           ( WDSIZE = 32 )

      CHARACTER*(WDSIZE)    OBJNAM



      TMPWIN (-5) = 0.0D0

      SOBJ = OBJSIZ ( OBJLIS )

      CALL OBJNTH ( OBJLIS, 1, OBJ,   FOUND  )

      DO WHILE ( FOUND )

C
C        Look up the window associated with the current
C        object.  If it doesn't contain the FROM and TO
C        interval, remove the current object from the
C        list of objects to disply.
C
         CALL OBJGET ( OBJ,    OBJLIS, OBJECT        )
         CALL MAKNAM ( OBJECT, SOBJ,   OBNAM,  KERTYP, OBJNAM )
         CALL SYGETD ( OBJNAM, WINSYM,    WINPTR, WINVAL,
     .                  N,      FILWIN(1), FND )

         CALL SCARDD    ( N,        FILWIN )
         KEEP =  WNINCD ( FROM, TO, FILWIN )

         CALL OBJNXT ( OBJ, OBJLIS, OBJN, FOUND )

         IF ( .NOT. KEEP ) THEN
C
C           Remove the current object from this
C           list of objects to give summaries for.
C
            CALL OBJREM ( OBJ, OBJLIS )

         END IF

         OBJ(1) = OBJN(1)
         OBJ(2) = OBJN(2)

      END DO
C
C     Compress the object list.
C
      CALL OBJCMP ( OBJLIS )

      RETURN
      END