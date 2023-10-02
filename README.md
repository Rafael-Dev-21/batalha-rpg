# Batalha RPG
> Em várias linguagens diferentes

Um jogo de batalha rpg implementado em várias linguagens diferentes, um bom desafio para práticar.

[Linguagens usadas/planejadas](linguagens.md)

## Algoritmo

1. imprime uma mensagem de introdução (opcional)
2. enquanto o jogador e o advensário tem a vida acima de 0:
    1. obter escolha do jogador de uma função que imprime o menu.
    2. selecione a escolha do jogador:
        1. caso 1: jogador dá um ataque normal no oponente.
        2. caso 2: jogador analiza oponente.
    3. caso a vida do oponente esteja acima de 0, ele age.
3. imprime uma mensagem dizendo se você ganhou ou perdeu

O jogador e o oponente podem ser representados pela mesma case | estrutura | tipo algébrico.

## Opcionais

1. uma lista de itens como inventário, (sugestão: armazene a quantidade no item para evitar duplicação na lista).
2. adicione suporte a mais personagens e inimigos.
    1. você pode armazenar todos numa lista, sortear ela por velocidade no inicio de cada turno e iterar sobre ela.
3. adicionar suporte a mais de um tipo de jogador ou inimigo.
