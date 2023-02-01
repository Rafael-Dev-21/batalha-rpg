! batalha.f95 -- Um simulador de batalha por turnos
! Copyright (C) 2023 Victor Rafael Pereira Alves

! This program is free software: you can redistribute it and/or modify
! it under the terms of the GNU General Public License as published by
! the Free Software Foundation, either version 3 of the License, or
! (at your option) any later version.
!
! This program is distributed in the hope that it will be useful,
! but WITHOUT ANY WARRANTY; without even the implied warranty of
! MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
!  GNU General Public License for more details.
!
! You should have received a copy of the GNU General Public License
!  along with this program.  If not, see <https://www.gnu.org/licenses/>.

module m_ator

  implicit none
  private

  type, public::t_ator
    character(10)::nome
    integer::vida, ataque
    logical::auto
  contains
    procedure::dano, toma_hit, atacar, mostrar
  end type

contains

  integer function dano(self) result(res)
    class(t_ator)::self
    real::critico

    call random_number(critico)

    res = int(real(self%ataque) * (1.0 + critico))
  end function

  subroutine toma_hit(self, x)
    class(t_ator)::self
    integer::x

    self%vida = self%vida - x
  end subroutine

  subroutine atacar(self, inimigo)
    class(t_ator)::self, inimigo
    integer::x

    x = self%dano()
    print '(1x,a," ataca ",1x,a,", causando ",i2," de dano.")', self%nome, inimigo%nome, x
    call inimigo%toma_hit(x)
  end subroutine

  subroutine mostrar(self)
    class(t_ator)::self

    print "(1x,a)", "----------------"
    print "(1x,a)", self%nome
    print "(1x,a)", "----------------"
    print '(" vida: ",i3)', self%vida
    print "(1x,a)", "----------------"
  end subroutine

end module m_ator

program rpg
  use m_ator
  implicit none

  integer::menu, opcao

  type(t_ator)::jogador, inimigo

  jogador = t_ator("Você", 100, 10, .false.)
  inimigo = t_ator("Goblin", 60, 6, .true.)

  call intro

  gameloop: do while ((jogador%vida .gt. 0) .and. (inimigo%vida .gt. 0))

  call jogador%mostrar()

  opcao = menu()

  select case (opcao)
  case (1)
    call jogador%atacar(inimigo)
  
  case (2)
    call inimigo%mostrar()

  end select

  if (inimigo%vida .gt. 0) then
    call inimigo%atacar(jogador)
  end if

  end do gameloop

  if (jogador%vida .gt. 0) then
    print *, "Você ganhou."
  else
    print *, "Você perdeu."
  end if

end program rpg

integer function menu() result(res)
  implicit none
  integer::input

  input = 0

  do while ((input .lt. 1) .or. (input .gt. 2))

  write(*,*) "Você vê um goblin armado"
  write(*,*) "1) um soco só"
  write(*,*) "2) analizar goblin"
  read "(i1)", input
  end do

  res = input
end function

subroutine intro()
  write(*,*) "#==============#"
  write(*,*) "# Batalha  RPG #"
  write(*,*) "#==============#"
end subroutine

