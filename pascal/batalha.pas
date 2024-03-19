PROGRAM batalha;

TYPE
  TAtor = RECORD
    nome: String;
    vida: Integer;
    ataque: Integer;
    autopiloto: Boolean;
END;

VAR
  jogador: TAtor;
  inimigo: TAtor;
  a: TAtor;
  b: TAtor;
  temp: TAtor;
  
FUNCTION Menu(): Integer;
BEGIN
  WriteLn('Você vê um goblin.');
  WriteLn('1) Atacar');
  WriteLn('2) Analizar');
  ReadLn(Menu);
END;

PROCEDURE Intro();
BEGIN
  WriteLn('#=============#');
  WriteLn('# BATALHA RPG #');
  WriteLn('#=============#');
END;

FUNCTION Dano(a: TAtor): Integer;
VAR
  extra: Integer;
BEGIN
  extra := Random(a.ataque);
  Dano := a.ataque + extra;
END;

PROCEDURE Atacar();
VAR
  d: Integer;
BEGIN
  d := Dano(a);
  WriteLn(a.nome, ' ataca ', b.nome, ', causando ', d, ' de dano.');
  b.vida := b.vida - d;
END;

PROCEDURE Mostrar(a: TAtor);
BEGIN
  WriteLn('----------------');
  WriteLn(a.nome);
  WriteLn('----------------');
  WriteLn('vida: ', #9, a.vida);
  WriteLn('----------------');
END;

PROCEDURE Turno();
BEGIN
  IF a.autopiloto THEN
    Atacar()
  ELSE
  BEGIN
    Mostrar(a);
    CASE Menu OF
      1: Atacar();
      2: Mostrar(b);
    END;
  END;
END;

BEGIN
  WITH jogador DO
  BEGIN
    nome := 'Você';
    vida := 100;
    ataque := 10;
    autopiloto := false;
  END;
  
  WITH inimigo DO
  BEGIN
    nome := 'Goblin';
    vida := 60;
    ataque := 6;
    autopiloto := true;
  END;
  
  a := jogador;
  b := inimigo;
  
  RANDOMIZE;
  
  Intro;
  
  WHILE (a.vida > 0) AND (b.vida > 0) DO
  BEGIN
    Turno();
    temp := a;
    a := b;
    b := temp;
  END;
  
  WriteLn(b.nome, ' é o vencedor!');
  
END.
