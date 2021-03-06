C$Procedure   ZZEKRD05 ( EK, read class 5 column entry elements )
 
      SUBROUTINE ZZEKRD05 ( HANDLE,  SEGDSC,  COLDSC,  RECPTR,
     .                      BEG,     END,     DVALS,   ISNULL,  FOUND )
 
C$ Abstract
C
C     Read a specified element range from a column entry in a specified
C     record in a class 5 column.  Class 5 columns have d.p. arrays
C     as column entries.
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
C     PRIVATE
C
C$ Declarations
 
      INCLUDE 'ekcoldsc.inc'
      INCLUDE 'ekdatpag.inc'
      INCLUDE 'ekrecptr.inc'
      INCLUDE 'eksegdsc.inc'
      INCLUDE 'ektype.inc'
 
      INTEGER               HANDLE
      INTEGER               SEGDSC ( SDSCSZ )
      INTEGER               COLDSC ( CDSCSZ )
      INTEGER               RECPTR
      INTEGER               BEG
      INTEGER               END
      DOUBLE PRECISION      DVALS  ( * )
      LOGICAL               ISNULL
      LOGICAL               FOUND
 
C$ Brief_I/O
C
C     Variable  I/O  Description
C     --------  ---  --------------------------------------------------
C     HANDLE     I   Handle attached to EK file.
C     SEGDSC     I   Segment descriptor.
C     COLDSC     I   Column descriptor.
C     RECPTR     I   Record pointer.
C     BEG        I   Start element index.
C     END        I   End element index.
C     DVALS      O   Double precision values in column entry.
C     ISNULL     O   Flag indicating whether column entry is null.
C     FOUND      O   Flag indicating whether elements were found.
C
C$ Detailed_Input
C
C     HANDLE         is an EK file handle.
C
C     SEGDSC         is the descriptor of the segment from which data is
C                    to be read.
C
C     COLDSC         is the descriptor of the column from which data is
C                    to be read.
C
C     RECPTR         is a pointer to the record containing the column
C                    entry to be written.
C
C     BEG,
C     END            are, respectively, the start and end indices of
C                    the contiguous range of elements to be read from
C                    the specified column entry.
C
C$ Detailed_Output
C
C     DVALS          are the values read from the specified column
C                    entry.  The mapping of elements of the column entry
C                    to elements of DVALS is as shown below:
C
C                       Column entry element       DVALS element
C                       --------------------       -------------
C                       BEG                        1
C                       BEG+1                      2
C                       .                          .
C                       .                          .
C                       .                          .
C                       END                        END-BEG+1
C
C                    DVALS is valid only if the output argument
C                    FOUND is returned .TRUE.
C
C     ISNULL         is a logical flag indicating whether the entry is
C                    null.  ISNULL is set on output whether or not
C                    the range of elements designated by BEG and END
C                    exists.
C
C     FOUND          is a logical flag indicating whether the range
C                    of elements designated by BEG and END exists.
C                    If the number of elements in the specified column
C                    entry is not at least END, FOUND will be returned
C                    .FALSE.
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
C     2)  If the specified column entry has not been initialized, the
C         error SPICE(UNINITIALIZEDVALUE) is signaled.
C
C     3)  If the ordinal position of the column specified by COLDSC
C         is out of range, the error SPICE(INVALIDINDEX) is signaled.
C
C     4)  If an I/O error occurs while reading the indicated file,
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
C     This routine is a utility for reading data from class 5 columns.
C
C$ Examples
C
C     See EKRCED.
C
C$ Restrictions
C
C     None.
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
C-    SPICELIB Version 1.2.0, 07-FEB-2015 (NJB)
C
C        Now uses ERRHAN to insert DAS file name into
C        long error messages.
C
C        Bug fix: changed max column index in long error
C        message from NREC to NCOLS.
C
C-    SPICELIB Version 1.1.0, 12-SEP-2005 (NJB)
C
C        Updated to remove non-standard use of duplicate arguments
C        in ZZEKGFWD calls.
C
C-    SPICELIB Version 1.0.0, 18-OCT-1995 (NJB)
C
C-&
 
C$ Revisions
C
C-    SPICELIB Version 1.1.0, 12-SEP-2005 (NJB)
C
C        Updated to remove non-standard use of duplicate arguments
C        in ZZEKGFWD calls.
C
C-& 

 
C
C     SPICELIB functions
C
      LOGICAL               FAILED
 
C
C     Non-SPICELIB functions
C
      INTEGER               ZZEKRP2N
 
C
C     Local variables
C
      DOUBLE PRECISION      DPNELT
 
      INTEGER               BASE
      INTEGER               COLIDX
      INTEGER               DATPTR
      INTEGER               MAXIDX
      INTEGER               MINIDX
      INTEGER               NCOLS
      INTEGER               NELT
      INTEGER               NREAD
      INTEGER               P
      INTEGER               PTEMP
      INTEGER               PTRLOC
      INTEGER               RECNO
      INTEGER               REMAIN
      INTEGER               START
 
C
C     Use discovery check-in.
C
C
C     Make sure the column exists.
C
      NCOLS  =  SEGDSC ( NCIDX  )
      COLIDX =  COLDSC ( ORDIDX )
 
      IF (  ( COLIDX .LT. 1 ) .OR. ( COLIDX .GT. NCOLS )  ) THEN
 
         CALL CHKIN  ( 'ZZEKRD05'                              )
         CALL SETMSG ( 'Column index = #; valid range is 1:#.' )
         CALL ERRINT ( '#',  COLIDX                            )
         CALL ERRINT ( '#',  NCOLS                             )
         CALL SIGERR ( 'SPICE(INVALIDINDEX)'                   )
         CALL CHKOUT ( 'ZZEKRD05'                              )
         RETURN
 
      END IF
 
C
C     Compute the data pointer location, and read the pointer.
C
      PTRLOC  =  RECPTR + DPTBAS + COLIDX
 
      CALL DASRDI ( HANDLE, PTRLOC, PTRLOC, DATPTR )
 
 
      IF ( DATPTR .GT. 0 ) THEN
C
C        The entry is non-null.
C
         ISNULL  =  .FALSE.
 
C
C        Get the element count.  Check for range specifications that
C        can't be met.
C
         CALL DASRDD ( HANDLE, DATPTR, DATPTR, DPNELT )
 
         NELT  =  NINT ( DPNELT )
 
 
         IF (  ( BEG .LT. 1 ) .OR. ( BEG .GT. NELT )  )  THEN
 
            FOUND  =  .FALSE.
            RETURN
 
         ELSE IF (  ( END .LT. 1 ) .OR. ( END .GT. NELT )  )  THEN
 
            FOUND  =  .FALSE.
            RETURN
 
         ELSE IF ( END .LT. BEG ) THEN
 
            FOUND  =  .FALSE.
            RETURN
 
         END IF
 
C
C        The request is valid, so read the data.  The first step is to
C        locate the element at index BEG.
C
         CALL ZZEKPGPG ( DP, DATPTR, P, BASE )
 
         MINIDX  =  1
         MAXIDX  =  BASE   + DPSIZE - DATPTR
         DATPTR  =  DATPTR + BEG
 
 
         DO WHILE ( MAXIDX .LT. BEG )
C
C           Locate the page on which the element is continued.
C
            CALL ZZEKGFWD ( HANDLE, DP, P, PTEMP )
            P = PTEMP

            CALL ZZEKPGBS ( DP,         P, BASE  )
 
C
C           Determine the highest-indexed element of the column entry
C           located on the current page.
C
            MINIDX  =  MAXIDX  +   1
            MAXIDX  =  MIN ( MAXIDX + DPSIZE, NELT )
 
C
C           The following assignment will set DATPTR to the correct
C           value on the last pass through this loop.
C
            DATPTR  =  BASE    +   1   +  ( BEG - MINIDX )
 
         END DO
 
C
C        At this point, P is the page on which the element having index
C        BEG is located.  BASE is the base address of this page.
C        MAXIDX is the highest index of any element on the current page.
C
         REMAIN  =  END    -   BEG   +   1
         START   =  1
 
C
C        Decide how many elements to read from the current page, and
C        read them.
C
         NREAD   =  MIN ( REMAIN,  ( BASE + DPSIZE - DATPTR + 1 )  )
 
         CALL DASRDD ( HANDLE, DATPTR, DATPTR+NREAD-1, DVALS(START) )
 
         REMAIN  =  REMAIN  -  NREAD
 
 
         DO WHILE (  ( REMAIN .GT. 0 ) .AND.  ( .NOT. FAILED() )  )
C
C           Locate the page on which the element is continued.
C
            CALL ZZEKGFWD ( HANDLE, DP, P, PTEMP )
            P = PTEMP

            CALL ZZEKPGBS ( DP,         P, BASE  )
 
            DATPTR  =  BASE   +  1
            START   =  START  +  NREAD
            NREAD   =  MIN ( REMAIN,  DPSIZE )
 
            CALL DASRDD ( HANDLE, DATPTR, DATPTR+NREAD-1, DVALS(START) )
 
            REMAIN  =  REMAIN  -  NREAD
 
         END DO
 
 
         FOUND =  .NOT. FAILED()
 
 
      ELSE IF ( DATPTR .EQ. NULL ) THEN
C
C        The value is null.
C
         ISNULL =  .TRUE.
         FOUND  =  .TRUE.
 
 
      ELSE IF ( DATPTR .EQ. UNINIT ) THEN
C
C        The data value is absent.  This is an error.
C
         RECNO  =  ZZEKRP2N ( HANDLE, SEGDSC(SNOIDX), RECPTR )
 
         CALL CHKIN  ( 'ZZEKRD05'                                    )
         CALL SETMSG ( 'Attempted to read uninitialized column '    //
     .                 'entry.  SEGNO = #; COLIDX = #; RECNO = #; ' //
     .                 'EK = #'                                      )
         CALL ERRINT ( '#',  SEGDSC(SNOIDX)                          )
         CALL ERRINT ( '#',  COLIDX                                  )
         CALL ERRINT ( '#',  RECNO                                   )
         CALL ERRHAN ( '#',  HANDLE                                  )
         CALL SIGERR ( 'SPICE(UNINITIALIZEDVALUE)'                   )
         CALL CHKOUT ( 'ZZEKRD05'                                    )
         RETURN
 
 
      ELSE
C
C        The data pointer is corrupted.
C
         RECNO  =  ZZEKRP2N ( HANDLE, SEGDSC(SNOIDX), RECPTR )
 
         CALL CHKIN  ( 'ZZEKRD05'                                )
         CALL SETMSG ( 'Data pointer is corrupted. SEGNO = #; '  //
     .                 'COLIDX =  #; RECNO = #; EK = #'          )
         CALL ERRINT ( '#',  SEGDSC(SNOIDX)                      )
         CALL ERRINT ( '#',  COLIDX                              )
         CALL ERRINT ( '#',  RECNO                               )
         CALL ERRHAN ( '#',  HANDLE                              )
         CALL SIGERR ( 'SPICE(BUG)'                              )
         CALL CHKOUT ( 'ZZEKRD05'                                )
         RETURN
 
      END IF
 
 
      RETURN
      END
