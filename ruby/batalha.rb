#
# batalha.py -- Um simulador de batalha por turnos                     # Copyright (C) 2023 Victor Rafael Pereira Alves
#
# This program is free software: you can redistribute it and/or modify
# it under the terms of the GNU General Public License as published by
# the Free Software Foundation, either version 3 of the License, or
# (at your option) any later version.
#
# This program is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU General Public License for more details.                         #
# You should have received a copy of the GNU General Public License
# along with this program.  If not, see <https://www.gnu.org/licenses/>.
#

class Ator
  attr_accessor :vida
  attr_accessor :nome
  attr_accessor :auto

  def initialize(nome, vida, ataque, auto)
    @nome = nome
    @vida = vida
    @ataque = ataque
    @auto = auto
  end
  def dano
    return @ataque + rand(@ataque)
  end
  def toma_hit(d)
    @vida -= d
  end
  def atacar(outro)
    d = dano
    puts "#{@nome} ataca #{outro.nome}, causando #{d} de dano."
    outro.toma_hit(d)
  end
  def mostrar()
    puts "----------------"
    puts @nome
    puts "----------------"
    puts " vida: #{@vida}"
    puts "----------------"
  end
end

def intro
  puts "#==============#"
  puts "# BATALHA  RPG #"
  puts "#==============#"
end

def menu
  puts "Você vê um goblin"
  puts "1) atacar"
  puts "2) analizar"
  return gets.chomp.to_i
end

def turno(a, b)
  if a.auto
    a.atacar b
  else
    a.mostrar
    opcao = menu
    case opcao
    when 1
      a.atacar b
    when 2
      b.mostrar
    end
  end
end

def batalha(jogador, inimigo)
  a = jogador
  b = inimigo
  while a.vida > 0
    turno(a, b)
    temp = a
    a = b
    b = temp
  end
  puts "#{b.nome} é o vencedor."
end

if __FILE__ == $0
  jogador = Ator.new("Você", 100, 10, false)
  inimigo = Ator.new("Goblin", 60, 6, true)
  
  intro
  batalha(jogador, inimigo)
end

