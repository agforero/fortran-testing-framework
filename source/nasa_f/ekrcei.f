C$Procedure   EKRCEI ( EK, read column entry element, integer )
 
      SUBROUTINE EKRCEI ( HANDLE,  SEGNO,  RECNO,  COLUMN,
     .                    NVALS,   IVALS,  ISNULL          )
 
C$ Abstract
C
C     Read data from an integer column in a specified EK record.
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
C     EK
C
C$ Keywords
C
C     EK
C     FILES
C     UTILITY
C
C$ Declarations

      IMPLICIT NONE
 
      INCLUDE 'ekcoldsc.inc'
      INCLUDE 'eksegdsc.inc'
      INCLUDE 'ektype.inc'
 
      INTEGER               HANDLE
      INTEGER               SEGNO
      INTEGER               RECNO
      CHARACTER*(*)         COLUMN
      INTEGER               NVALS
      INTEGER               IVALS  ( * )
      LOGICAL               ISNULL
 
C$ Brief_I/O
C
C     Variable  I/O  Description
C     --------  ---  --------------------------------------------------
C     HANDLE     I   Handle attached to EK file.
C     SEGNO      I   Index of segment containing record.
C     RECNO      I   Record from which data is to be read.
C     COLUMN     I   Column name.
C     NVALS      O   Number of values in column entry.
C     IVALS      O   Integer values in column entry.
C     ISNULL     O   Flag indicating whether column entry is null.
C
C$ Detailed_Input
C
C     HANDLE         is an EK file handle.  The file may be open for
C                    read or write access.  
C
C     SEGNO          is the index of the segment from which data is to
C                    be read.
C
C     RECNO          is the index of the record from which data is to be
C                    read.  This record number is relative to the start
C                    of the segment indicated by SEGNO; the first
C                    record in the segment has index 1.
C
C     COLUMN         is the name of the column from which data is to be
C                    read.
C
C
C$ Detailed_Output
C
C     NVALS,
C     IVALS          are, respectively, the number of values found in
C                    the specified column entry and the set of values
C                    themselves.
C
C                    For columns having fixed-size entries, when a 
C                    a column entry is null, NVALS is still set to the
C                    column entry size.  For columns having variable-
C                    size entries, NVALS is set to 1 for null entries.
C
C     ISNULL         is a logical flag indicating whether the returned 
C                    column entry is null.  
C
C$ Parameters
C
C     None.
C
C$ Exceptions
C
C     1)  If HANDLE is invalid, the error will be diagnosed by routines
C         called by this routine.
C
C     2)  If SEGNO is out of range, the error will diagnosed by routines
C         called by this routine.
C
C     3)  If RECNO is out of range, the error will diagnosed by routines
C         called by this routine.
C
C     4)  If COLUMN is not the name of a declared column, the error
C         will be diagnosed by routines called by this routine.
C
C     5)  If COLUMN specifies a column of whose data type is not
C         integer, the error SPICE(WRONGDATATYPE) will be
C         signaled.
C
C     6)  If COLUMN specifies a column of whose class is not
C         an integer class known to this routine, the error
C         SPICE(NOCLASS) will be signaled.
C
C     7)  If an attempt is made to read an uninitialized column entry,
C         the error will be diagnosed by routines called by this 
C         routine.  A null entry is considered to be initialized, but
C         entries do not contain null values by default.
C
C     8)  If an I/O error occurs while reading the indicated file,
C         the error will be diagnosed by routines called by this
C         routine.
C
C$ Files
C
C     See the EK Required Reading for a discussion of the EK file
C     format.
C
C$ Particulars
C
C     This routine is a utility that allows an EK file to be read
C     directly without using the high-level query interface.
C
C$ Examples
C
C     1)  Read the value in the third record of the column ICOL in
C         the fifth segment of an EK file designated by HANDLE.
C
C            CALL EKRCEI ( HANDLE, 5, 3, 'ICOL', N, IVAL, ISNULL )
C
C$ Restrictions
C
C     1) EK files open for write access are not necessarily readable.
C        In particular, a column entry can be read only if it has been
C        initialized. The caller is responsible for determining
C        when it is safe to read from files open for write access.
C
C$ Literature_References
C
C     None.
C
C$ Author_and_Institution
C
C     N.J. Bachman   (JPL)
C
C$ Version
C
C-    SPICELIB Version 1.3.0, 06-FEB-2015 (NJB)
C
C        Now uses ERRHAN to insert DAS file name into
C        long error messages.
C
C-    SPICELIB Version 1.2.0, 20-JUN-1999 (WLT)
C
C        Removed unbalanced call to CHKOUT.
C
C-    SPICELIB Version 1.1.0, 28-JUL-1997 (NJB)
C
C        Bug fix:  Record number, not record pointer, is now supplied
C        to look up data in the class 7 case.  Miscellaneous header
C        changes were made as well.
C
C-    SPICELIB Version 1.0.0, 06-NOV-1995 (NJB)
C
C-&
 
C$ Index_Entries
C
C     read integer data from EK column
C
C-&
 
C$ Revisions
C
C-    SPICELIB Version 1.1.0, 28-JUL-1997 (NJB)
C
C        Bug fix:  Record number, not record pointer, is now supplied
C        to look up data in the class 7 case.  For class 7 columns,
C        column entry locations are calculated directly from record 
C        numbers; no indirection is used.
C
C        Miscellaneous header changes were made as well.
C
C-&
 
 
C
C     SPICELIB functions
C
      LOGICAL               FAILED
 
C
C     Non-SPICELIB functions
C
      INTEGER               ZZEKESIZ
 
C
C     Local variables
C
      INTEGER               COLDSC ( CDSCSZ )
      INTEGER               CLASS
      INTEGER               DTYPE
      INTEGER               RECPTR
      INTEGER               SEGDSC ( SDSCSZ )
 
      LOGICAL               FOUND
 
C
C     Use discovery check-in.
C
C     First step:  find the descriptor for the named segment.  Using
C     this descriptor, get the column descriptor.
C
      CALL ZZEKSDSC ( HANDLE, SEGNO,  SEGDSC          )
      CALL ZZEKCDSC ( HANDLE, SEGDSC, COLUMN, COLDSC  )
 
      IF ( FAILED() ) THEN
         RETURN
      END IF
 
C
C     This column had better be of integer type.
C
      DTYPE  =  COLDSC(TYPIDX)
 
      IF ( DTYPE .NE. INT ) THEN
 
         CALL CHKIN  ( 'EKRCEI'                                        )
         CALL SETMSG ( 'Column # is of type #; EKRCEI only works '    //
     .                 'with integer columns.  RECNO = #; SEGNO = '   //
     .                 '#; EK = #.'                                    )
         CALL ERRCH  ( '#',  COLUMN                                    )
         CALL ERRINT ( '#',  DTYPE                                     )
         CALL ERRINT ( '#',  RECNO                                     )
         CALL ERRINT ( '#',  SEGNO                                     )
         CALL ERRHAN ( '#',  HANDLE                                    )
         CALL SIGERR ( 'SPICE(WRONGDATATYPE)'                          )
         CALL CHKOUT ( 'EKRCEI'                                        )
         RETURN
 
      END IF
 
C
C     Now it's time to read data from the file.  Call the low-level
C     reader appropriate to the column's class.
C
      CLASS  =  COLDSC ( CLSIDX )
 
 
      IF ( CLASS .EQ. 1 ) THEN
C
C        Look up the record pointer for the target record.
C
         CALL ZZEKTRDP ( HANDLE, SEGDSC(RTIDX),  RECNO,  RECPTR )
 
         CALL ZZEKRD01 ( HANDLE, SEGDSC, COLDSC, RECPTR, IVALS, ISNULL )
         NVALS  =  1
 
 
      ELSE IF ( CLASS .EQ. 4 ) THEN
 
         CALL ZZEKTRDP ( HANDLE, SEGDSC(RTIDX),  RECNO,  RECPTR )
 
         NVALS  =  ZZEKESIZ ( HANDLE, SEGDSC, COLDSC, RECPTR )
 
         CALL ZZEKRD04 (  HANDLE,  SEGDSC,  COLDSC,  RECPTR,
     .                    1,       NVALS,   IVALS,   ISNULL,  FOUND  )
 
 
      ELSE IF ( CLASS .EQ. 7 ) THEN
C
C        Records in class 7 columns are identified by a record number
C        rather than a pointer.
C 
         CALL ZZEKRD07 ( HANDLE, SEGDSC, COLDSC, RECNO, IVALS, ISNULL )
         NVALS  =  1
 
      ELSE
 
C
C        This is an unsupported integer column class.
C
         SEGNO  =  SEGDSC ( SNOIDX )
 
         CALL CHKIN  ( 'EKRCEI'                                        )
         CALL SETMSG ( 'Class # from input column descriptor is not ' //
     .                 'a supported integer class.  COLUMN = #; '     //
     .                 'RECNO = #; SEGNO = #; EK = #.'                 )
         CALL ERRINT ( '#',  CLASS                                     )
         CALL ERRCH  ( '#',  COLUMN                                    )
         CALL ERRINT ( '#',  RECNO                                     )
         CALL ERRINT ( '#',  SEGNO                                     )
         CALL ERRHAN ( '#',  HANDLE                                    )
         CALL SIGERR ( 'SPICE(NOCLASS)'                                )
         CALL CHKOUT ( 'EKRCEI'                                        )
         RETURN
 
      END IF
 
 
      RETURN
      END
