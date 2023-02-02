#
# batalha.py -- Um simulador de batalha por turnos
# Copyright (C) 2023 Victor Rafael Pereira Alves
#
# This program is free software: you can redistribute it and/or modify
# it under the terms of the GNU General Public License as published by
# the Free Software Foundation, either version 3 of the License, or
# (at your option) any later version.
#
# This program is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU General Public License for more details.
#
# You should have received a copy of the GNU General Public License
# along with this program.  If not, see <https://www.gnu.org/licenses/>.
#

import random

class Ator:
    def __init__(self, nome, vida, ataque, auto):
        self.nome = nome
        self.vida = vida
        self.ataque = ataque
        self.auto = auto

    def dano(self):
        return self.ataque + random.randrange(0, self.ataque)

    def _toma_hit(self, dano):
        self.vida -= dano

    def atacar(self, oponente):
        dano = self.dano()
        print(f"{self.nome} atacou {oponente.nome}, causando {dano} de dano.")
        oponente._toma_hit(dano)


    def mostrar(self):
        print("-" * 16)
        print(self.nome)
        print("-" * 16)
        print(f" vida: {self.vida}")
        print("-" * 16)


def intro():
    print("#==============#")
    print("# BATALHA  RPG #")
    print("#==============#")

def menu():
    print("Você vê um goblin")
    print("1) atacar")
    print("2) analizar")
    return int(input("? "))

def turno(a, b):
    if a.auto:
        a.atacar(b)
    else:
        a.mostrar()
        opcao = menu()
        if opcao == 1:
            a.atacar(b)
        elif opcao == 2:
            b.mostrar()

def batalha(jogador, inimigo):
    a, b = jogador, inimigo
    while a.vida > 0 and b.vida > 0:
        turno(a, b)
        a, b = b, a
    print(f"{b.nome} é o vencedor.")

def main():
    jogador = Ator("Você", 100, 10, False)
    inimigo = Ator("Goblin", 60, 6, True)
    intro()
    batalha(jogador, inimigo)

if __name__ == "__main__":
    main()

