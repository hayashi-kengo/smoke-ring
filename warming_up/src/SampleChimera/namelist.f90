!-----------------------------------------------------------------------------
! 200708_LesHouches/src/SampleChimera
!                                       Akira Kageyama
!                                       kage@jamstec.go.jp
!                                       Earth Simulator Center, JAMSTEC, Japan
!-----------------------------------------------------------------------------
! namelist.f90
!              2007.07.22: Created by Akira Kageyama
!-----------------------------------------------------------------------------
module namelist
  use constants
  use ut
  implicit none
  private
  public :: & !< routines >!
            namelist__double,   &
            namelist__integer,  &
            namelist__read,     &
            namelist__string

  logical, save :: Read_done = .false.

  integer            :: Nx_left, Nx_right
  real(DP)           :: Cfl_factor, Diffusion_coeff
  character(len=100) :: Filename

  namelist /data00/ Nx_left, Nx_right
  namelist /data01/ Cfl_factor, Diffusion_coeff
  namelist /data02/ Filename


contains


!________________________________________________________________public__
!                                                                        !
  function namelist__double(variable)                                    !
    character(len=*), intent(in) :: variable                             !
    real(DP) :: namelist__double                                         !
!________________________________________________________________________!
!
    if ( .not.Read_done ) then
       call ut__fatal('<namelist__double> Read namelist file first.')
    end if

    select case (variable)
    case                ('Cfl_factor')
       namelist__double = Cfl_factor
    case                ('Diffusion_coeff')
       namelist__double = Diffusion_coeff
    case default
       call ut__message('? arg = ', variable)
       call ut__fatal('<namelist__double> not in the namelist?')
    end select

  end function namelist__double


!________________________________________________________________public__
!                                                                        !
  function namelist__integer(variable)                                   !
    character(len=*), intent(in) :: variable                             !
    integer :: namelist__integer                                         !
!________________________________________________________________________!
!
    if ( .not.Read_done ) then
       call ut__fatal('<namelist__integer> Read namelist file first.')
    end if

    select case (variable)
    case                 ('Nx_left')
       namelist__integer = Nx_left
    case                 ('Nx_right')
       namelist__integer = Nx_right
    case default
       call ut__message('? arg = ', variable)
       call ut__fatal('<namelist__integer> not in the namelist?')
    end select

  end function namelist__integer


!________________________________________________________________public__
!                                                                        !
  subroutine namelist__read                                              !
!________________________________________________________________________!
!

    read(FILE_NAMELIST,nml=data00)
    read(FILE_NAMELIST,nml=data01)
    read(FILE_NAMELIST,nml=data02)

    write(FILE_STANDARD_OUT,nml=data00)
    write(FILE_STANDARD_OUT,nml=data01)
    write(FILE_STANDARD_OUT,nml=data02)

    Read_done = .true.

  end subroutine namelist__read


!________________________________________________________________public__
!                                                                        !
  function namelist__string(variable)                                    !
    character(len=*), intent(in) :: variable                             !
    character(len=100) :: namelist__string                               !
!________________________________________________________________________!
!
    if ( .not.Read_done ) then
       call ut__fatal('<namelist__string> Read namelist file first.')
    end if

    select case         (variable)
    case                ('Filename')
       namelist__string = Filename
    case default
       call ut__message('? arg = ', variable)
       call ut__fatal('<namelist__string> not in the namelist?')
    end select

  end function namelist__string

end module namelist
