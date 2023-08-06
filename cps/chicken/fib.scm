(import micro-benchmark)
;(import format)

(define fib_cps1 (lambda (n k)
  (if (<= n 1) (k 1)
    (fib_cps1 (- n 1) (lambda (a)
    (fib_cps1 (- n 2) (lambda (b)
    (k (+ a b))))))
  )
))

(define fib_cps (lambda (n) (fib_cps1 n (lambda (x) x))))

(define return (lambda (x) (lambda (k) (k x))))
(define bind (lambda (x f) (lambda (k) (x (lambda (v) ((f v) k))))))
(define run_kont (lambda (f m) (m f)))

(define fibm1 (lambda (n)
  (if (<= n 1) (return 1)
    (bind (fibm1 (- n 2)) (lambda (a)
      (bind (fibm1 (- n 1)) (lambda (b)
        (return (+ a b)))))))
  ))
(define fibm (lambda (n) (run_kont (lambda (x) x) (fibm1 n))))

(print "(fib_cps 10) ==")
(print  (fib_cps 10))
(print "(fibm 10) ==")
(print  (fibm 10))

(print (benchmark-run 10 (fib_cps 10)))
(print (benchmark-run 10 (fibm 10)))
