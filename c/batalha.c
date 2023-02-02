/**
 * batalha.c -- Um simulador de batalha por turnos
 * Copyright (C) 2023 Victor Rafael Pereira Alves
 *
 * This program is free software: you can redistribute it and/or modify
 * it under the terms of the GNU General Public License as published by
 * the Free Software Foundation, either version 3 of the License, or
 * (at your option) any later version.
 * 
 * This program is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 * GNU General Public License for more details.
 *
 * You should have received a copy of the GNU General Public License
 * along with this program.  If not, see <https://www.gnu.org/licenses/>.
*/

#include <time.h>
#include <stdio.h>
#include <stdlib.h>
#include <stdbool.h>

typedef struct {
  char nome[10];
  int vida;
  int ataque;
  bool auto_piloto;
} ator_t;

int menu(void);
void intro(void);

int dano(ator_t *a);
void atacar(ator_t *a, ator_t *b);
void mostrar(ator_t *a);

void turno(ator_t *a, ator_t *b);

int main(void)
{
  ator_t jogador = {"Você", 100, 10, false};
  ator_t inimigo = {"Goblin", 60, 6, true};
                                                                         ator_t *a = &jogador, *b = &inimigo, *temp = NULL;

  srand(time(NULL));

  intro();
  
  while (a->vida > 0 && b->vida > 0) {
    turno(a, b);
    temp = a;
    a = b;
    b = temp;
  }
  printf("%s é o vencedor!\n", b->nome);

  return EXIT_SUCCESS;
}

int menu(void)
{
  int escolha;

  puts("Você vê um goblin.");
  puts("1) atacar");
  puts("2) analizar");
  scanf("%i", &escolha);

  return escolha;
}

void intro(void)
{
  puts("#==============#");
  puts("# BATALHA  RPG #");
  puts("#==============#");
}

int dano(ator_t *a) 
{
  int extra = rand() % a->ataque;

  return a->ataque + extra;
}

void atacar(ator_t *a, ator_t *b)
{
  int d;
  d = dano(a);
  printf("%s ataca %s, causando %i de dano.\n", a->nome, b->nome, d);
  b->vida -= d;
}

void mostrar(ator_t *a) {
  printf("----------------\n");
  printf("%s\n", a->nome);
  printf("----------------\n");
  printf(" vida:\t%6i\n", a->vida);
  printf("----------------\n");
}

void turno(ator_t *a, ator_t *b) 
{
  if (a->auto_piloto) {
    atacar(a, b);
  } else {
    mostrar(a);
    int escolha = menu();

    switch (escolha) {
      case 1:
        atacar(a, b);
        break;
      case 2:
        mostrar(b);
        break;
    }
  }
}
