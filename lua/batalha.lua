-- [[
--
-- batalha.lua -- Um simulador de batalha por turnos
-- Copyright (C) 2023 Victor Rafael Pereira Alves
--
-- This program is free software: you can redistribute it and/or modify
-- it under the terms of the GNU General Public License as published by
-- the Free Software Foundation, either version 3 of the License, or
-- (at your option) any later version.
--
-- This program is distributed in the hope that it will be useful,
-- but WITHOUT ANY WARRANTY; without even the implied warranty of
-- MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
-- GNU General Public License for more details.
--
-- You should have received a copy of the GNU General Public License
-- along with this program.  If not, see <https://www.gnu.org/licenses/>.
--
-- ]]

local Ator = {}

function Ator:new(nome, vida, ataque, auto)
  local result = {
    nome = nome,
    vida = vida,
    ataque = ataque,
    auto = auto
  }

  setmetatable(result, self)
  self.__index = self

  return result
end

function Ator:dano()
  return self.ataque + math.random(0, self.ataque - 1)
end

function Ator:_tomaHit(dano)
  self.vida = self.vida - dano
end

function Ator:atacar(outro)
  local dano = self:dano()
  print(self.nome .. " atacou " .. outro.nome .. ", causando " .. dano .. " de dano.")
  outro:_tomaHit(dano)
end

function Ator:mostrar()
  print("----------------")
  print(self.nome)
  print("----------------")
  print(" vida:", self.vida)
  print("----------------")
end

function intro()
  print("#==============#")
  print("# BATALHA  RPG #")
  print("#==============#")
end

function menu()
  print("Você vê um goblin")
  print("1) atacar")
  print("2) analizar")
  return io.read("*n")
end

function turno(a, b)
  if a.auto then
    a:atacar(b)
  else
    a:mostrar()
    local opcao = menu()
    if opcao == 1 then
      a:atacar(b)
    elseif opcao == 2 then
      b:mostrar()
    end
  end
end

function batalha(jogador, inimigo)
  local a, b = jogador, inimigo
  while a.vida > 0 do
    turno(a, b)
    a, b = b, a
  end
  print(b.nome, "é o vencendor.")
end

function main()
  local jogador = Ator:new("Você", 100, 10, false)
  local inimigo = Ator:new("Goblin", 60, 6, true)

  intro()
  batalha(jogador, inimigo)
end

main()

