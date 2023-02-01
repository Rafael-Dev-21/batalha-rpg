#|
batalha.lisp -- Um simulador de batalha por turnos
Copyright (C) 2023 Victor Rafael Pereira Alves

This program is free software: you can redistribute it and/or modify
it under the terms of the GNU General Public License as published by
the Free Software Foundation, either version 3 of the License, or
(at your option) any later version.

This program is distributed in the hope that it will be useful,
but WITHOUT ANY WARRANTY; without even the implied warranty of
MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
GNU General Public License for more details.

You should have received a copy of the GNU General Public License
along with this program.  If not, see <https://www.gnu.org/licenses/>.
|#

(defstruct ator nome vida ataque auto)

(defun ator-dano (ator)
  (+ (ator-ataque ator) (random (ator-ataque ator))))

(defun ator-toma-hit (a dano)
    (setf (ator-vida a) (- (ator-vida a) dano)))

(defun ator-atacar (a b)
  (let ((dano (ator-dano a)))
    (ator-toma-hit b dano)
    (format nil "~a ataca ~a, causando ~a de dano.~%" (ator-nome a) (ator-nome b) dano)))

(defun ator-mostrar (a)
  (concatenate 'string 
               (format nil "----------~%")
               (format nil "~a~%" (ator-nome a))
               (format nil "----------~%")
               (format nil "  vida: ~a~%" (ator-vida a))
               (format nil "----------~%")))

(defun menu ()
  (progn 
    (format t "1) atacar~%")
    (format t "2) analizar~%")
    (read)))

(defun ator-turno (a b)
  (if (ator-auto a)
      (ator-atacar a b)
      (let ((opcao (menu)))
        (princ (ator-mostrar a))
        (case opcao
          (1 (ator-atacar a b))
          (2 (ator-mostrar b))))))

(defun intro ()
  (format t "#==============#~%")
  (format t "# BATALHA  RPG #~%")
  (format t "#==============#~%"))

(defun luta ()
  (let ((jogador (make-ator :nome "Você" :vida 100 :ataque 10 :auto nil))
        (inimigo (make-ator :nome "Goblin" :vida 60 :ataque 6 :auto t)))
    (labels ((luta-turno (a b) (progn
                                 (princ (ator-turno a b))
                                 (if (< (ator-vida b) 0)
                                     (format nil "~a é o vencedor.~%" (ator-nome a))
                                     (luta-turno b a)))))
      (intro)
      (princ (luta-turno jogador inimigo)))))

