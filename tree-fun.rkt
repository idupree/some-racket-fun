#lang slideshow

(define (treeize-impl lst len)
  (cond
    [(= len 0) '()]
    [(= len 1) lst]
    [else (let-values
              ([(first last) (split-at lst (floor (/ len 2)))])
            (list (treeize-impl first (floor (/ len 2)))
                  (treeize-impl last (ceiling (/ len 2)))))]))

(define (treeize lst)
  (treeize-impl lst (length lst)))

(define (hv-layout-shapes tree initial)
  (let ([this-layout initial]
        [next-layout (if (eq? initial hc-append)
                         vc-append hc-append)])
    (case (length tree)
      [(0) (blank)]
      [(1) (text (format "~a" (first tree)))]
      [(2) (frame (this-layout
            (hv-layout-shapes (first tree) next-layout)
            (hv-layout-shapes (second tree) next-layout)))])))

;; TODO: what's a good way to convert string -> list in Scheme?
(define qbf
  '("T" "h" "e" " " "q" "u" "i" "c" "k" " " "b" "r" "o" "w" "n" " " "f" "o" "x" " " "j" "u" "m" "p" "s" " " "o" "v" "e" "r" " " "t" "h" "e" " " "l" "a" "z" "y" " " "d" "o" "g"))

(define (fun lst) (hv-layout-shapes (treeize lst) vc-append))