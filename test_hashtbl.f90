! Test program for module hashtbl implementing an OO hash table (dictionary) 
! in Fortran 2003. Compiles and runs with accompanying test program under 
! the Intel Fortran Compiler, version 11.1.046

! Copyright (c) Izaak Beekman 2010

    ! This program is free software: you can redistribute it and/or modify
    ! it under the terms of the GNU Lesser General Public License as published by
    ! the Free Software Foundation, either version 3 of the License, or
    ! (at your option) any later version.

    ! This program is distributed in the hope that it will be useful,
    ! but WITHOUT ANY WARRANTY; without even the implied warranty of
    ! MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
    ! GNU Lesser General Public License for more details.

    ! You should have received a copy of the GNU Lesser General Public License
    ! along with this program.  If not, see <http://www.gnu.org/licenses/>.

PROGRAM test_hashtbl
  USE hashtbl
  IMPLICIT NONE
  TYPE(hash_tbl_sll)            :: table
  CHARACTER(len=:), ALLOCATABLE :: out
  INTEGER, parameter :: tbl_length = 100
  INTEGER            :: sum, i, rand_int1, rand_int2 ! 4 byte integer, hopefully
  REAL               :: rand
  CHARACTER(len=4)   :: rand_str1, rand_str2 ! each char should be 1 byte

  PRINT*, ' '
  PRINT*, 'This program is free software: you can redistribute it and/or &
       &modify it under the terms of the GNU Lesser General Public License&
       & as published by the Free Software Foundation, either version 3 of&
       & the License, or (at your option) any later version.'
  PRINT*, ' '
  PRINT*, 'This program is distributed in the hope that it will be useful,&
       & but WITHOUT ANY WARRANTY; without even the implied warranty of&
       & MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the &
       &GNU Lesser General Public License for more details.'
  PRINT*, ' '
  PRINT*, 'You should have received a copy of the GNU Lesser General Public &
       &License along with this program.  If not, see &
       &<http://www.gnu.org/licenses/>.'
  PRINT*, ' '

  CALL table%init(tbl_length)
  CALL table%put(key='first_name', val='John')
  PRINT*, 'Hash: ', MOD(sum_string('first_name'),tbl_length)
  CALL table%put(key='last_name', val='Smith')
  PRINT*, 'Hash: ', MOD(sum_string('last_name'),tbl_length)
  CALL table%put(key='birthday', val='July 30, 1964')
  PRINT*, 'Hash: ', MOD(sum_string('birthday'),tbl_length)
  CALL table%put(key='hair_color', val='brown')
  PRINT*, 'Hash: ', MOD(sum_string('hair_color'),tbl_length)
  CALL table%put(key='eye_color', val='brown')
  PRINT*, 'Hash: ', MOD(sum_string('eye_color'),tbl_length)
  CALL table%put(key='weight', val='213 lbs')
  PRINT*, 'Hash: ', MOD(sum_string('weight'),tbl_length)
  CALL table%put(key='height', val='6''3"')
  PRINT*, 'Hash: ', MOD(sum_string('height'),tbl_length)

  PRINT*, ' ' 

  CALL table%get(key='first_name',val=out)
  PRINT*, out
  CALL table%get('last_name',out)
  PRINT*, out
  CALL table%get('birthday',out)
  PRINT*, out
  CALL table%get('hair_color',out)
  PRINT*, out
  CALL table%get('eye_color',out)
  PRINT*, out
  CALL table%get('weight',out)
  PRINT*, out
  CALL table%get('height',out)
  PRINT*, out

  ! INCLUDE 'stress_test.f90'

  PRINT*, ' '

  sum = 0
  PRINT*, 'Indices of the hash table with content:'
  DO i = LBOUND(table%vec,dim=1), UBOUND(table%vec,dim=1)
     IF (ALLOCATED(table%vec(i)%key)) THEN 
        PRINT*, i
        sum = sum + 1
     END IF
  END DO
  PRINT*, 'Total used elements:', sum
  CALL table%free
  PRINT*, ' '
  STOP 0
END PROGRAM test_hashtbl