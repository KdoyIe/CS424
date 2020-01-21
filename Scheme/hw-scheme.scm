#lang racket
(define (poly-eval p x)
  (cond
    ((= (length p) 0) 0)
    ((= (length p) 1) (car p))
    (else
     (+ (car p) (* x (poly-eval (cdr p) x))))))

(define (poly-add p1 p2)
  (cond ((null? p1)
         p2)
        ((null? p2)
         p1)
        (else
         (cons (+ (car p1)
                  (car p2))
               (poly-add (cdr p1)
                         (cdr p2))))))

(define (poly-mul p1 p2)
  (let loop ((p p1)
             (e identity))
    (if (null? p)
        null
        (poly-add (e (map (curry * (car p)) p2))
                  (loop (cdr p)
                        (compose (curry cons 0) e))))))

(define (poly-diff p)
  (let loop ((e 0)(s p))
    (cond ((null? s)
           null)
          (else (cons (* (car s) e)
                      (loop (+ e 1) (cdr s)))))))

(define (poly-int p)
  (let loop ((e 1) (s p))
    (cond ((null? s)
           null)
          (else (cons (/ (car s) e)
                      (loop (+ e 1)
                            (cdr s)))))))

;(define (grovel-poly-eval s x))

;(define (poly-shift p s))