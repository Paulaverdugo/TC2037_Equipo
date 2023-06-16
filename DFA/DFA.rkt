#lang racket

(require racket/trace)

(provide (all-defined-out))

; Declare the structure that describes a DFA
(struct dfa (func initial accept))


;This function allows the evaluation of the automata using the chosen transition function.
(define (evaluate-dfa dfa-to-evaluate strng)
  "This function will verify if a string is acceptable by a DFA"
  (let loop
    ; Convert the string into a list of characters
    ([chars (string->list strng)]
     ; Get the initial state of the DFA
     [state (dfa-initial dfa-to-evaluate)]
     ; The return list with the type of tokens found
     [tokens '()]
     ; List with the value of the tokens found
     [chosentoken '()])
    (cond
      ; When the list of chars is over, check if the final state is acceptable
      [(empty? chars)
       (if (member state (dfa-accept dfa-to-evaluate))
           ; This prints each value of the token with the token type.
           (reverse (cons (cons state (list->string (reverse chosentoken))) tokens))
           'invalid)]
      [else
       (let-values
           ; Call the transition function and get the new state and whether or not a token was found
           ([(new-state found) ((dfa-func dfa-to-evaluate) state (car chars))])
         (loop (cdr chars)
               new-state
               ; The new list of tokens
               (cond
                 [found (cons (cons found (list->string (reverse chosentoken))) tokens)]
                 [else tokens])
               (cond
                 [found '()]
                 [else (cons (car chars) chosentoken)])))])))


;This function defines all of the operators
(define (char-operator? char)
  "Identify characters that represent arithmetic operators"
  (member char '(#\+ #\- #\* #\/ #\= #\^))) ;#\;

;This is the transition function that will determine if it is a valid state.
(define (delta-arithmetic state char)
  "Transition function to validate numbers
   Initial state: start
   Accept states: int float exp"
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
            [(or (char-alphabetic? char) (eq? char #\_)) (values 'inv #f)]
            [else (values 'inv #f)])]
    ['dot (cond
            [(char-numeric? char) (values 'float #f)]
            [else (values 'inv #f)])]
    ['float (cond
              [(char-numeric? char) (values 'float #f)]
              [(or (eq? char #\e) (eq? char #\E)) (values 'e #f)]
              [(char-operator? char) (values 'op 'float)]
              [(eq? char #\space) (values 'spa 'float)]
              [(eq? char #\( ) (values 'op_par 'float)]
              [(eq? char #\) ) (values 'close_par 'float)]
              [(eq? char #\; ) (values 'comm 'float)]
              [(or (char-alphabetic? char) (eq? char #\_)) (values 'inv #f)]
              [else (values 'inv #f)])]
    ['e (cond
          [(char-numeric? char) (values 'exp #f)]
          [(or (eq? char #\+) (eq? char #\-)) (values 'exp_sign #f)]
          [else (values 'inv #f)])]
    ['exp_sign (cond
                 [(char-numeric? char) (values 'exp #f)]
                 [else (values 'inv #f)])]
    ['exp (cond
            [(char-numeric? char) (values 'exp #f)]
            [(char-operator? char) (values 'op 'exp)]
            [(eq? char #\space) (values 'spa 'exp)]
            [(eq? char #\( ) (values 'op_par 'exp)]
            [(eq? char #\) ) (values 'close_par 'exp)]
            [(eq? char #\; ) (values 'comm 'exp)]
            [(or (char-alphabetic? char) (eq? char #\_)) (values 'inv #f)]
            [else (values 'inv #f)])]
    [else (values 'inv #f)]))


; DFA for arithmetic operations
(define arithmetic-dfa (dfa delta-arithmetic 'start '(int float e exp sign dot var op_par close_par op comm spa inv)))


; Test the DFA with some inputs
(evaluate-dfa arithmetic-dfa "12345")
(evaluate-dfa arithmetic-dfa "12.345")
(evaluate-dfa arithmetic-dfa "12.345e-6")
(evaluate-dfa arithmetic-dfa "12.345e-6+7.89")
