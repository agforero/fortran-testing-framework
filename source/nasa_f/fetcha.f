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
 
 
      SUBROUTINE FETCHA ( ID, COMPNT, STRING, WIDTH )
 
      IMPLICIT NONE
C
C     Fetch the alias for a column ID.
C
      INTEGER               ID
      INTEGER               COMPNT
      CHARACTER*(*)         STRING
      INTEGER               WIDTH
 
      INTEGER               ALIAS
      PARAMETER           ( ALIAS = 1 )
 
      INTEGER               MYID
      INTEGER               N
      INTEGER               LOCID
 
C
C     First get the width of this column
C
      LOCID = ID
 
      CALL CLQ2ID  ( LOCID,  MYID               )
      CALL CLGAI   ( MYID,  'WIDTH',  N, WIDTH  )
C
C     Finally get the alias or a blank.
C
      IF ( COMPNT .EQ. ALIAS ) THEN
 
         CALL CLGQAL ( LOCID, STRING )
 
      ELSE
 
         STRING = ' '
 
      END IF
      RETURN
 
      END
 
 
 
 
 