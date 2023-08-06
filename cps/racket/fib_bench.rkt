#lang racket

(require benchmark plot/pict racket/match racket/vector racket/list pretty-format)
(require math/statistics)

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

(pretty-printf "(fib_cps 10) == ~a\n" (fib_cps 10))
(pretty-printf "(fibm 10) == ~a\n" (fibm 10))

(define results
    (run-benchmarks
     ; operations (whats)
     (list 'fib_cps  'fib_monadic)
     ; list of options (hows)
     (list
      ; sizes (and their indices) in the sizes list
      '(10)
      )
     ; to run each benchmark
     (lambda (op idx)
       (let ([fn
              (match op
                ['fib_cps fib_cps]
                ['fib_monadic fibm]
                )]
             )
         (fn idx)))
     ; don't extract time, instead time (run ...)
     #:extract-time 'delta-time
     #:num-trials 10))

(println results)

(for ([i results])
  (pretty-printf "~a: ~a\n"
    (benchmark-result-name i)
    (mean (benchmark-result-trial-times i)))
)

#|
(parameterize ([plot-x-ticks no-ticks])
    (plot-pict
     #:title "vectors vs lists"
     #:x-label #f
     #:y-label "normalized time"
     (render-benchmark-alts
      ; default options
      (list 10)
      results
      ; format options so we can omit the index in the size list
      #:format-opts (lambda (opts)
                      (let ([index/size (car opts)]
                            [impl (cadr opts)])
                        (format "size: ~a, ~a" (cdr index/size) impl))))))
|#
