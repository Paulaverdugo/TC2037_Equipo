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
26-05-2023
|#
#lang racket

(require racket/trace)

(provide (all-defined-out))

; Declare the structure that describes a DFA
(struct dfa (func initial accept))

(define (arithmetic-lexer strng)
  " Call the function to validate using a specific DFA "
  (evaluate-dfa (dfa delta-arithmetic 'start '(int float exp var spa par_open par_close)) strng))

;This function allows the evaluation of the automata using the chosen transition function.

(define (evaluate-dfa dfa-to-evaluate string)
    (let loop 
    ; Convert the string into a list of characters
    ([chars (string->list string)] 
    ; Get the initial state of the DFA
    [state (dfa-initial dfa-to-evaluate)] 
    ; The return list with all the tokens found
    [tokens '()] 
    ; The current token being constructed
    [chosenToken '()])
        (cond
            ; if the chars are empty return if the state is valid
            [(empty? chars)
                (if (member state (dfa-accept dfa-to-evaluate))
                    (if (eq? state 'spa)
                        (reverse tokens)
                        (reverse (cons (list  (list->string (reverse chosenToken)) state) tokens))
                    )
                    'invalid)]
            ; the next state is defined by the transition function
            [else
                (let-values ([(newState found) ((dfa-func dfa-to-evaluate) state (car chars))])
                    (if found 
                        ;If a token is found it 
                        (loop (cdr chars) 
                            newState 
                            (cons (list found (list->string (reverse chosenToken))) tokens)
                            ;if it is a space it doesn't store it as space and it empties list.
                            (if (eq? #\space (car chars))
                                '()
                                ;else, the token is stored.
                                (list (car chars))
                            ) 
                        )
                        ;In case that a sapace is found as the current token it stores it and adds it to currenttoekn
                        (loop (cdr chars) 
                            newState 
                            tokens
                            (if (eq? #\space (car chars))
                                chosenToken
                                ;THis part adds it to the chosentoken list
                                (cons (car chars) chosenToken)
                            ))))])))

;This function declares the operators that can be found in the function.
(define (char-operator? char)
  " Identify characters that represent arithmetic operators "
  (member char '(#\+ #\- #\* #\/ #\= #\^)))

;It
(define (delta-arithmetic state char)
  " Transition function to validate numbers
  This function now returns two values:
   - The new state in the automaton
   - The token that has been found. Generally false, until we are sure to have found a token
  Initial state: start
  Accept states: int float exp par_open par_close"
  (case state
    ['start (cond
             [(eq? char #\() (values 'par_open #f)]
             [(char-numeric? char) (values 'int #f)]
             [(or (eq? char #\+) (eq? char #\-)) (values 'sign #f)]
             [(char-alphabetic? char) (values 'var #f)]
             [(eq? char #\_) (values 'var #f)]
             [else (values 'inv #f)])]
    ['sign (cond
             [(char-numeric? char) (values 'int #f)]
             [else (values 'inv #f)])]
    ['int (cond
             [(eq? char #\)) (values 'par_close 'int)]
             [(char-numeric? char) (values 'int #f)]
             [(eq? char #\.) (values 'dot #f)]
             [(or (eq? char #\e) (eq? char #\E)) (values 'e #f)]
             [(char-operator? char) (values 'op 'int)]
             [(eq? char #\space) (values 'spa 'int)]
             [else (values 'inv #f)])]
    ['dot (cond
             [(char-numeric? char) (values 'float #f)]
             [else (values 'inv #f)])]
    ['float (cond
               [(eq? char #\)) (values 'par_close 'float)]
               [(char-numeric? char) (values 'float #f)]
               [(or (eq? char #\e) (eq? char #\E)) (values 'e #f)]
               [(char-operator? char) (values 'op 'float)]
               [(eq? char #\space) (values 'spa 'float)]
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
             [(eq? char #\)) (values 'par_close 'exp)]
             [(char-operator? char) (values 'op 'exp)]
             [(eq? char #\space) (values 'spa 'exp)]
             [else (values 'inv #f)])]
    ['var (cond
             [(char-alphabetic? char) (values 'var #f)]
             [(char-numeric? char) (values 'var #f)]
             [(eq? char #\_) (values 'var #f)]
             [(eq? char #\)) (values 'par_close 'var)]
             [(char-operator? char) (values 'op 'var)]
             [(eq? char #\space) (values 'spa 'var)]
             [else (values 'inv #f)])]
    ['op (cond
             [(char-numeric? char) (values 'int 'op)]
             [(eq? char #\() (values 'par_open 'op)]
             [(eq? char #\)) (values 'par_close 'op)]
             [(or (eq? char #\+) (eq? char #\-)) (values 'sign 'op)]
             [(char-alphabetic? char) (values 'var 'op)]
             [(eq? char #\_) (values 'var 'op)]
             [(eq? char #\space) (values 'op_spa 'op)]
             [else (values 'inv #f)])]
    ['spa (cond
         [(char-operator? char) (values 'op #f)]
         [(eq? char #\space) (values 'spa #f)]
         [(eq? char #\)) (values 'par_close 'spa)]
         [(char-numeric? char) (values 'int #f)]
         [(char-alphabetic? char) (values 'var #f)]
         [else (values 'inv #f)])]

    ['op_spa (cond
             [(char-numeric? char) (values 'int #f)]
             [(or (eq? char #\+) (eq? char #\-)) (values 'sign #f)]
             [(char-alphabetic? char) (values 'var #f)]
             [(eq? char #\_) (values 'var #f)]
             [(eq? char #\space) (values 'op_spa #f)]
             [(eq? char #\() (values 'par_open 'op_spa)]
             [(eq? char #\)) (values 'par_close 'op_spa)]
             [(char-operator? char) (values 'op 'op_spa)]
             [else (values 'inv #f)])]

    ['par_open (cond
                   [(char-numeric? char) (values 'int 'par_open)]
                   [(char-alphabetic? char) (values 'var 'par_open)]
                   [(eq? char #\() (values 'par_open 'par_open)]
                   [(eq? char #\space) (values 'spa 'par_open)]
                   [(or (eq? char #\+) (eq? char #\-)) (values 'sign 'par_open)]
                   [else (values 'inv #f)])]
    ['par_close (cond
                    [(eq? char #\space) (values 'spa 'par_close)]
                    [(char-operator? char) (values 'op 'par_close)]
                    [else (values 'inv #f)])]
    [else (values 'inv #f)]))

;Examples to be tested.
     (arithmetic-lexer "(8 * 54) * (98 - 0) + 8 ")
     (arithmetic-lexer "lucia + (34 + 8)/ 2")
     (arithmetic-lexer "(8 * 54) * (9978 - 0+lu) + 8 ")
