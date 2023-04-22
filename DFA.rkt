#|
This file determines whether a DFA (deterministic Finite Automat) is in an acceptable state.
to do this 3 functions are used. The transition function that works for a predefined automat, the
evaluation function and another function that indicats which transition function will be used. In this case 
it's the arithmetic-lexer function. 
The following examples are how the code can be tested:
   (arithmetic-lexer "95.3 - +34 * lu ")
   (arithmetic-lexer "9")
Lucía Barrenechea
Paula Verdugo
21-04-2021
|#

#lang racket

(require racket/trace)

(provide (all-defined-out))

; Declare the structure that describes a DFA
(struct dfa (func initial accept))


;This function allows the evaluation of the automata using the chosen transition function.
(define (evaluate-dfa dfa-to-evaluate strng)
  " This function will verify if a string is acceptable by a DFA "
  (let loop
    ; Convert the string into a list of characters
    ([chars (string->list strng)]
     ; Get the initial state of the DFA
     [state (dfa-initial dfa-to-evaluate)]
     ;The return list with the type of tokens found
     [tokens '()]
     ;List with the value of the tokens found
     [chosentoken '()])
    (cond
      ; When the list of chars if over, check if the final state is acceptable
      [(empty? chars) 
      (if(member state (dfa-accept dfa-to-evaluate))
      ;This prints each value of the token with the token type.
      (reverse (cons (cons state (list->string ( reverse chosentoken))) tokens))
      'invalid)]
      [else 
      (let-values
       ;Call transition function and get the new sate and whether or not a token was found
      ([(new-state found) ((dfa-func dfa-to-evaluate) state (car chars))])
      (loop (cdr chars)
        new-state
         ;The new list of tokens
         ;(if found (cons found tokens) tokens)))])))
        (cond
                 [found (cons (cons found (list->string (reverse chosentoken))) tokens)]
                 [else tokens])
               (cond
                 [found '()]
                 [else (cons (car chars) chosentoken)])))])))

      
;This function defines all of the operators
(define (char-operator? char)
  " Identify caracters that represent arithmetic operators "
  (member char '(#\+ #\- #\* #\/ #\= #\^ ))) ;#\;

;This is the transition function that will determine if it is a valid state.
(define (delta-arithmetic state char)
  " Transition function to validate numbers
  Initial state: start
  Accept states: int float exp "
  (case state
    ['start (cond
       [(char-numeric? char) (values 'int #f)]
       [(or (eq? char #\+) (eq? char #\-)) (values 'sign #f)]
       [(char-alphabetic? char) (values 'var #f)]
       [(eq? char #\_) (values 'var #f)]
       [(eq? char #\( ) (values 'op_par #f)]
       [(eq? char #\) ) (values 'close_par #f)]
       [(eq? char #\; ) (values 'comm #f)]
       [else (values 'inv #f)])]
    ['sign (cond
       [(char-numeric? char) (values 'int #f)]
       [else (values 'inv #f)])]
    ['int (cond
       [(char-numeric? char) (values 'int #f)]
       [(eq? char #\.) (values 'dot #f)]
       [(or (eq? char #\e) (eq? char #\E)) (values 'e #f)]
       [(char-operator? char) (values 'op 'int)]
       [(eq? char #\space) (values 'spa 'int)]
       [(eq? char #\( ) (values 'op_par 'int)]
       [(eq? char #\) ) (values 'close_par 'int)]
       [(eq? char #\; ) (values 'comm 'int)]
       [else (values 'inv #f)])]
    ['dot (cond
       [(char-numeric? char) (values 'float #f)]
       [else (values 'inv #f)])]
    ['float (cond
       [(char-numeric? char) (values 'float #f)]
       [(or (eq? char #\e) (eq? char #\E)) (values 'e #f)]
       [(char-operator? char) (values 'op 'float)]
       [(eq? char #\space) (values 'spa 'float)]
       [(eq? char #\) ) (values 'close_par 'float)]
       [(eq? char #\( ) (values 'op_par 'float)]
       [(eq? char #\; ) (values 'comm 'float)]
       [else (values 'inv #f)])]
    ['e (cond
       [(char-numeric? char) (values 'exp #f)]
       [(or (eq? char #\+) (eq? char #\-)) (values 'e_sign #f)]
       [else (values 'inv #f)])]
    ['e_sign (cond
       [(char-numeric? char) (values 'exp #f)]
       [else (values 'inv #f)])]
    ['exp (cond
       [(char-numeric? char) (values 'exp #f)]
       [(char-operator? char) (values 'op 'exp)]
       [(eq? char #\space) (values 'spa 'exp)]
       [(eq? char #\) ) (values 'close_par 'exp)]
       [(eq? char #\( ) (values 'op_par 'exp)]
       [(eq? char #\; ) (values 'comm 'exp)]
       [else (values 'inv #f)])]
    ['var (cond
       [(char-alphabetic? char) (values 'var #f)]
       [(char-numeric? char) (values 'var #f)]
       [(eq? char #\_) (values 'var #f)]
       [(char-operator? char) (values 'op 'var)]
       [(eq? char #\space) (values 'spa 'var)]
       [(eq? char #\) ) (values 'close_par 'var)]
       [(eq? char #\( ) (values 'op_par 'var)]
       [(eq? char #\; ) (values 'comm 'var)]
       [else (values 'inv #f)])]
    ['op (cond
       [(char-numeric? char) (values 'int 'op)]
       [(or (eq? char #\+) (eq? char #\-)) (values 'sign 'op)]
       [(char-alphabetic? char) (values 'var 'op)]
       [(eq? char #\_) (values 'var 'op)]
       [(eq? char #\space) (values 'op_spa 'op)]
       [(eq? char #\) ) (values 'close_par 'op)]
       [(eq? char #\( ) (values 'op_par 'op)]
       [(eq? char #\; ) (values 'comm 'op)]
       [else (values 'inv #f)])]
     ['spa (cond
       [(char-operator? char) (values 'op #f)]
       [(eq? char #\space) (values 'spa #f)]
       [else (values 'inv #f)])]
      ['new_line (cond
       [(char-operator? char) (values 'op #f)]
       [(eq? char #\newline) (values 'new_line #f)]
       [else (values 'inv #f)])]
     ['op_spa (cond
       [(char-numeric? char) (values 'int #f)]
       [(or (eq? char #\+) (eq? char #\-)) (values 'sign #f)]
       [(char-alphabetic? char) (values 'var #f)]
       [(eq? char #\_) (values 'var #f)]
       [(eq? char #\space) (values 'op_spa #f)]
       [else (values 'inv #f)])]
    ['op_par (cond
       [(char-numeric? char) (values 'int 'op_par)]
       [(or (eq? char #\+) (eq? char #\-)) (values 'sign 'op_par)]
       [(char-alphabetic? char) (values 'var 'op_par)]
       [(eq? char #\_) (values 'var 'op_par)]
       [(eq? char #\space) (values 'op_spa 'op_par)]
       [(eq? char #\( ) (values 'op_par 'op_par)]
       [(eq? char #\) ) (values 'close_par 'op_par)]
       [(eq? char #\; ) (values 'comm 'op_par)]
       [else (values 'inv #f)])]
    ['close_par (cond
      [(char-numeric? char) (values 'int 'close_par)]
      [(or (eq? char #\+) (eq? char #\-)) (values 'sign 'close_par)]
      [(char-alphabetic? char) (values 'var 'close_par)]
      [(eq? char #\_) (values 'var 'close_par)]
      [(eq? char #\space) (values 'op_spa 'close_par)]
      [(eq? char #\( ) (values 'op_par 'close_par)]
      [(eq? char #\) ) (values 'close_par 'close_par)]
      [(eq? char #\; ) (values 'comm 'close_par)]
      [else (values 'inv #f)])]
    ['comm (cond
      [(char-numeric? char) (values 'int #f)]
      [(or (eq? char #\+) (eq? char #\-)) (values 'sign #f)]
      [(char-alphabetic? char) (values 'var #f)]
      [(eq? char #\_) (values 'var #f)]
      [(eq? char #\space) (values 'op_spa #f)]
      [(eq? char #\( ) (values 'op_par #f)]
      [(eq? char #\) ) (values 'close_par #f)]
      ;[(eq? char #\newline ) (values 'new_line 'comm)]
      [else (values 'inv #f)])]
      
      ;;; ['comm (cond
      ;;; [(char-numeric? char) (values 'int 'comm)]
      ;;; [(or (eq? char #\+) (eq? char #\-)) (values 'sign 'comm)]
      ;;; [(char-alphabetic? char) (values 'var 'comm)]
      ;;; [(eq? char #\_) (values 'var 'comm)]
      ;;; [(eq? char #\space) (values 'op_spa 'comm)]
      ;;; [(eq? char #\( ) (values 'op_par 'comm)]
      ;;; [(eq? char #\) ) (values 'close_par 'comm)]
      ;;; ;[(eq? char #\newline ) (values 'new_line 'comm)]
      ;;; [else (values 'inv #f)])]
      ))

;This function is the the chosen transition function.
(define (arithmetic-lexer strng)
  " Call the function to validate using a specific DFA "
  (evaluate-dfa (dfa delta-arithmetic 'start '(int float exp var spa close_par op_par comm)) strng))
    

