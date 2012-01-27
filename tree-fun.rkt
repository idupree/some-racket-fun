#lang slideshow

; (treeize lst) turns lst into a balanced binary tree
; with the data as single-element-list leaf nodes,
; and the branch nodes as two-element-lists
; containing child tree nodes.
;
; An empty list is turned into '().

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


; hv-layout-shapes takes a binary tree (of the
; above format).  It splits the first level vertically,
; each of the second-level nodes horizontally, then vertically,
; etc, alternating.  You specify whether the first level
; is horizontal or vertical:
; (hv-layout-shapes tree vc-append)  ; vertical
; (hv-layout-shapes tree hc-append)  ; horizontal

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