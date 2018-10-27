(defglobal ?*nod-gen* = 0)
(deffacts sokoban (bord 8 5 obstacles  o 4 1 o 1 3 o 4 3 o 5 3 o 8 3 o 4 4 o 4 5 )  
	(robot 1 4 boxes b 6 2 b 3 4 b 2 2  stores s 7 1 false s 5 4 false s 5 5 false  lastmove 1 4 fact level 0))

(defrule right
	(bord ?bdx ?bdy obstacles $?obstacles) 
	?f <- (robot ?x ?y boxes $?boxes stores $?stores lastmove ?lx ?ly fact $?fact level ?level)
	(max-depth ?prof)

	(test (or (neq ?lx (+ ?x 1)) (neq ?ly ?y)));last move
	(test (neq ?x ?bdx)) ;border
	(test (not (member$ (create$ s (+ ?x 1) ?y) $?stores))) ;stores new
	
	(test (not (member$ (create$ b (+ ?x 1) ?y) $?boxes)));boxes new
	
	(test (not (member$ (create$ o (+ ?x 1) ?y) $?obstacles)));obstacles new
	
	(test (< ?level ?prof)) ;level
=>
	
	(assert (robot (+ ?x 1) ?y boxes $?boxes stores $?stores lastmove ?x ?y fact ?f level (+ ?level 1)))
	(bind ?*nod-gen* (+ ?*nod-gen* 1)))


(defrule up
	(bord ?bdx ?bdy obstacles $?obstacles) 
	?f <- (robot ?x ?y boxes $?boxes stores $?stores lastmove ?lx ?ly fact $?fact level ?level)
	(max-depth ?prof)

	(test (or (neq ?ly (+ ?y 1)) (neq ?lx ?x)));last move
	(test (neq ?y ?bdy)) ;border
	(test (not (member$ (create$ s ?x (+ ?y 1)) $?stores))) ;stores new
	(test (not (member$ (create$ b ?x (+ ?y 1)) $?boxes))) ;boxes new
	(test (not (member$ (create$ o ?x (+ ?y 1)) $?obstacles))) ;obstacles new
	(test (< ?level ?prof)) ;level
=>
	
	(assert (robot ?x (+ 1 ?y) boxes $?boxes stores $?stores lastmove ?x ?y fact ?f level (+ ?level 1)))
	(bind ?*nod-gen* (+ ?*nod-gen* 1)))


(defrule down
	(bord ?bdx ?bdy obstacles $?obstacles) 
	?f <- (robot ?x ?y boxes $?boxes stores $?stores lastmove ?lx ?ly fact $?fact level ?level)
	(max-depth ?prof)

	(test (or (neq ?ly (- ?y 1)) (neq ?lx ?x)));last move
	(test (neq ?y 1)) ;border
	(test (not (member$ (create$ s ?x (- ?y 1)) $?stores))) ;stores new
	(test (not (member$ (create$ b ?x (- ?y 1)) $?boxes))) ;boxes new
	(test (not (member$ (create$ o ?x (- ?y 1)) $?obstacles))) ;obstacles new
	(test (< ?level ?prof)) ;level
=>
	(assert (robot ?x (- ?y 1) boxes $?boxes stores $?stores lastmove ?x ?y fact ?f level (+ ?level 1)))
	(bind ?*nod-gen* (+ ?*nod-gen* 1)))




(defrule left
	(bord ?bdx ?bdy obstacles $?obstacles) 
	?f <- (robot ?x ?y boxes $?boxes stores $?stores lastmove ?lx ?ly fact $?fact level ?level)
	(max-depth ?prof)

	(test (or (neq ?lx (- ?x 1)) (neq ?ly ?y)));last move
	(test (neq ?x 1)) ;border
	(test (not (member$ (create$ s (- ?x 1) ?y) $?stores))) ;stores new
	(test (not (member$ (create$ b (- ?x 1) ?y) $?boxes)));boxes new
	(test (not (member$ (create$ o (- ?x 1) ?y) $?obstacles)));obstacles new
	(test (< ?level ?prof)) ;level
=>
	(assert (robot (- ?x 1) ?y boxes $?boxes stores $?stores lastmove ?x ?y fact ?f level (+ ?level 1)))
	(bind ?*nod-gen* (+ ?*nod-gen* 1)))




;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(defrule pushright
	(declare (salience 20))
	(bord ?bdx ?bdy obstacles $?obstacles) 
	?f <- (robot ?x ?y boxes $?boxes stores $?stores lastmove ?lx ?ly fact $?fact level ?level)
	(max-depth ?prof)
	;;;;;add check for second box
	(test (or (neq ?lx (+ ?x 1)) (neq ?ly ?y)));last move
	(test (neq ?x ?bdx)) ;border
	(test (neq (+ ?x 1) ?bdx));border box 
	(test (not (member$ (create$ s (+ ?x 1) ?y) $?stores))) ;stores new
	(test (not (member$ (create$ s (+ ?x 2) ?y) $?stores))) ;stores new
	(test (not (member$ (create$ b (+ ?x 2) ?y) $?boxes)));boxes new
	(test (member$ (create$ b (+ ?x 1) ?y) $?boxes));boxes new
	(test (not (member$ (create$ o (+ ?x 2) ?y) $?obstacles)));obstacles new
	
	(test (< ?level ?prof)) ;level
=>
	(bind $?box b (+ ?x 1) ?y)
	(bind $?boxPos (member$ $?box $?boxes))
	(bind $?boxes (replace$ $?boxes (nth$ 1 $?boxPos)(nth$ 2 $?boxPos)(create$ b (+ ?x 2) ?y)))
	(assert (robot (+ ?x 1) ?y boxes $?boxes stores $?stores lastmove ?x ?y fact ?f level (+ ?level 1)))
	(bind ?*nod-gen* (+ ?*nod-gen* 1)))
(defrule pushup
	(declare (salience 20))
	(bord ?bdx ?bdy obstacles $?obstacles) 
	?f <- (robot ?x ?y boxes $?boxes stores $?stores lastmove ?lx ?ly fact $?fact level ?level)
	(max-depth ?prof)

	(test (or (neq ?ly (+ ?y 1)) (neq ?lx ?x)));last move
	(test (neq ?y ?bdy)) ;border
	(test (neq (+ ?y  1) ?bdy)) ;border box
	(test (not (member$ (create$ s ?x (+ ?y 1)) $?stores))) ;stores new
	(test (not (member$ (create$ s  ?x (+ 2 ?y)) $?stores))) ;stores new
	(test (not (member$ (create$ b  ?x (+ 2 ?y)) $?boxes)));boxes new
	(test (member$ (create$ b  ?x (+ ?y 1)) $?boxes));boxes new
	(test (not (member$ (create$ o ?x (+ 2 ?y)) $?obstacles)));obstacles new
	
	(test (< ?level ?prof)) ;level
=>
	(bind $?box b  ?x (+ 1 ?y))
	(bind $?boxPos (member$ $?box $?boxes))
	(bind $?boxes (replace$ $?boxes (nth$ 1 $?boxPos)(nth$ 2 $?boxPos)(create$ b  ?x (+ 2 ?y))))
	(assert (robot  ?x (+ 1 ?y) boxes $?boxes stores $?stores lastmove ?x ?y fact ?f level (+ ?level 1)))
	(bind ?*nod-gen* (+ ?*nod-gen* 1)))

(defrule pushleft
	(declare (salience 20))
	(bord ?bdx ?bdy obstacles $?obstacles) 
	?f <- (robot ?x ?y boxes $?boxes stores $?stores lastmove ?lx ?ly fact $?fact level ?level)
	(max-depth ?prof)

	(test (or (neq ?lx (- ?x 1)) (neq ?ly ?y)));last move
	(test (neq ?x 1)) ;border
	(test (neq (- ?x 1) 1));border box 
	(test (not (member$ (create$ s (- ?x 1) ?y) $?stores))) ;stores new
	(test (not (member$ (create$ s (- ?x 2) ?y) $?stores))) ;stores new
	(test (not (member$ (create$ b (- ?x 2) ?y) $?boxes)));boxes new
	(test (member$ (create$ b (- ?x 1) ?y) $?boxes));boxes new
	(test (not (member$ (create$ o (- ?x 2) ?y) $?obstacles)));obstacles new
	(test (< ?level ?prof)) ;level
=>
	(bind $?box b (- ?x 1) ?y)
	(bind $?boxPos (member$ $?box $?boxes))
	(bind $?boxes (replace$ $?boxes (nth$ 1 $?boxPos)(nth$ 2 $?boxPos)(create$ b (- ?x 2) ?y)))
	(assert (robot (- ?x 1) ?y boxes $?boxes stores $?stores lastmove ?x ?y fact ?f level (+ ?level 1)))
	(bind ?*nod-gen* (+ ?*nod-gen* 1)))


(defrule pushdown
	(declare (salience 20))
	(bord ?bdx ?bdy obstacles $?obstacles) 
	?f <- (robot ?x ?y boxes $?boxes stores $?stores lastmove ?lx ?ly fact $?fact level ?level)
	(max-depth ?prof)

	(test (or (neq ?ly (- ?y 1)) (neq ?lx ?x)));last move
	(test (member$ (create$ b  ?x (- ?y 1)) $?boxes));boxes new
	(test (neq ?y 1)) ;border
	(test (neq ?y 2)) ;border box
	(test (not (member$ (create$ s ?x (- ?y 1)) $?stores))) ;stores new
	(test (not (member$ (create$ s  ?x (- ?y 2)) $?stores))) ;stores new
	(test (not (member$ (create$ b  ?x (- ?y 2)) $?boxes)));boxes new
	(test (not (member$ (create$ o ?x (- ?y 2)) $?obstacles)));obstacles new

	(test (< ?level ?prof)) ;level
=>
	(bind $?box b  ?x (- ?y 1))
	(bind $?boxPos (member$ $?box $?boxes))
	(bind $?boxes (replace$ $?boxes (nth$ 1 $?boxPos)(nth$ 2 $?boxPos)(create$ b  ?x (- ?y 2))))
	(assert (robot  ?x (- ?y 1) boxes $?boxes stores $?stores lastmove ?x ?y fact ?f level (+ ?level 1)))
	(bind ?*nod-gen* (+ ?*nod-gen* 1)))
;;;;;;;;;;;;;;;;;;;
(defrule putright
	(declare (salience 50))
	(bord ?bdx ?bdy obstacles $?obstacles) 
	?f <- (robot ?x ?y boxes $?boxes stores $?stores lastmove ?lx ?ly fact $?fact level ?level)
	(max-depth ?prof)

	(test (or (neq ?lx (+ ?x 1)) (neq ?ly ?y)));last move
	(test (member$ (create$ b (+ ?x 1) ?y) $?boxes));boxes new
	(test (member$ (create$ s (+ ?x 2) ?y false) $?stores)) ;stores new
	(test (neq ?x ?bdx)) ;border
	(test (neq (+ ?x 1) ?bdx));border box 
	(test (not (member$ (create$ s (+ ?x 1) ?y) $?stores))) ;stores new
	(test (not (member$ (create$ b (+ ?x 2) ?y) $?boxes)));boxes new
	(test (not (member$ (create$ o (+ ?x 2) ?y) $?obstacles)));obstacles new
	
	(test (< ?level ?prof)) ;level
=>
	(bind $?box b (+ ?x 1) ?y)
	(bind $?boxPos (member$ $?box $?boxes))
	(bind $?boxes (replace$ $?boxes (nth$ 1 $?boxPos)(nth$ 2 $?boxPos)(create$ b (+ ?x 2) ?y)))
	(bind $?store s (+ ?x 2) ?y false)
	(bind $?storePos (member$ $?store $?stores))
	(bind $?stores (replace$ $?stores (nth$ 1 $?storePos)(nth$ 2 $?storePos) (create$ s (+ ?x 2) ?y true) ))
	(assert (robot (+ ?x 1) ?y boxes $?boxes stores $?stores lastmove ?x ?y fact ?f level (+ ?level 1)))
	(bind ?*nod-gen* (+ ?*nod-gen* 1)))


(defrule putleft
	(declare (salience 50))
	(bord ?bdx ?bdy obstacles $?obstacles) 
	?f <- (robot ?x ?y boxes $?boxes stores $?stores lastmove ?lx ?ly fact $?fact level ?level)
	(max-depth ?prof)

	(test (or (neq ?lx (- ?x 1)) (neq ?ly ?y)));last move
	(test (member$ (create$ b (- ?x 1) ?y) $?boxes));boxes new
	(test (member$ (create$ s (- ?x 2) ?y) $?stores)) ;stores new
	(test (neq ?x 1)) ;border
	(test (neq (- ?x 1) 1));border box 
	(test (not (member$ (create$ s (- ?x 1) ?y) $?stores))) ;stores new
	(test (not (member$ (create$ b (- ?x 2) ?y) $?boxes)));boxes new
	(test (not (member$ (create$ o (- ?x 2) ?y) $?obstacles)));obstacles new
	(test (< ?level ?prof)) ;level
=>
	(bind $?box b (- ?x 1) ?y)
	(bind $?boxPos (member$ $?box $?boxes))
	(bind $?boxes (replace$ $?boxes (nth$ 1 $?boxPos)(nth$ 2 $?boxPos)(create$ b (- ?x 2) ?y)))
	(bind $?store s (- ?x 2) ?y false)
	(bind $?storePos (member$ $?store $?stores))
	(bind $?stores (replace$ $?stores (nth$ 1 $?storePos)(nth$ 2 $?storePos) (create$ s (- ?x 2) ?y true) ))
	(assert (robot (- ?x 1) ?y boxes $?boxes stores $?stores lastmove ?x ?y fact ?f level (+ ?level 1)))
	(bind ?*nod-gen* (+ ?*nod-gen* 1)))


(defrule putup
	(declare (salience 50))
	(bord ?bdx ?bdy obstacles $?obstacles) 
	?f <- (robot ?x ?y boxes $?boxes stores $?stores lastmove ?lx ?ly fact $?fact level ?level)
	(max-depth ?prof)

	(test (or (neq ?ly (+ ?y 1)) (neq ?lx ?x)));last move
	(test (member$ (create$ b  ?x (+ ?y 1)) $?boxes));boxes new
	(test (member$ (create$ s  ?x (+ 2 ?y)) $?stores)) ;stores new
	(test (neq ?y ?bdy)) ;border
	(test (neq (+ ?y  1) ?bdy)) ;border box
	(test (not (member$ (create$ s ?x (+ ?y 1)) $?stores))) ;stores new
	(test (member$ (create$ s  ?x (+ 2 ?y)) $?stores)) ;stores new
	(test (not (member$ (create$ b  ?x (+ 2 ?y)) $?boxes)));boxes new

	(test (not (member$ (create$ o ?x (+ 2 ?y)) $?obstacles)));obstacles new
	
	(test (< ?level ?prof)) ;level
=>
	(bind $?box b  ?x (+ 1 ?y))
	(bind $?boxPos (member$ $?box $?boxes))
	(bind $?boxes (replace$ $?boxes (nth$ 1 $?boxPos)(nth$ 2 $?boxPos)(create$ b  ?x (+ 2 ?y))))
	(bind $?store s  ?x (+ 2 ?y) false)
	(bind $?storePos (member$ $?store $?stores))
	(bind $?stores (replace$ $?stores (nth$ 1 $?storePos)(nth$ 2 $?storePos) (create$ s  ?x (+ 2 ?y) true) ))
	(assert (robot  ?x (+ 1 ?y) boxes $?boxes stores $?stores lastmove ?x ?y fact ?f level (+ ?level 1)))
	(bind ?*nod-gen* (+ ?*nod-gen* 1)))


(defrule putdown
	(declare (salience 50))
	(bord ?bdx ?bdy obstacles $?obstacles) 
	?f <- (robot ?x ?y boxes $?boxes stores $?stores lastmove ?lx ?ly fact $?fact level ?level)
	(max-depth ?prof)

	(test (or (neq ?ly (- ?y 1)) (neq ?lx ?x)));last move
	(test (member$ (create$ b  ?x (- ?y 1)) $?boxes));boxes new
	(test (member$ (create$ s  ?x (- ?y 2)) $?stores)) ;stores new
	(test (neq ?y 1)) ;border
	(test (neq ?y 2)) ;border box
	(test (not (member$ (create$ s ?x (- ?y 1)) $?stores))) ;stores new
	(test (not (member$ (create$ b  ?x (- ?y 2)) $?boxes)));boxes new
	(test (not (member$ (create$ o ?x (- ?y 2)) $?obstacles)));obstacles new

	(test (< ?level ?prof)) ;level
=>
	(bind $?box b  ?x (- ?y 1 ))
	(bind $?boxPos (member$ $?box $?boxes))
	(bind $?boxes (replace$ $?boxes (nth$ 1 $?boxPos)(nth$ 2 $?boxPos)(create$ b  ?x (- ?y 2))))
	(bind $?store s  ?x (- ?y 2) false)
	(bind $?storePos (member$ $?store $?stores))
	(bind $?stores (replace$ $?stores (nth$ 1 $?storePos)(nth$ 2 $?storePos) (create$ s  ?x (- ?y 2) true) ))
	(assert (robot  ?x (- ?y 1) boxes $?boxes stores $?stores lastmove ?x ?y fact ?f level (+ ?level 1)))
	(bind ?*nod-gen* (+ ?*nod-gen* 1)))


(defrule end 
	(declare (salience 100))
	(bord ?bdx ?bdy obstacles $?obstacles) 
	?f <- (robot ?x ?y boxes $?boxes stores $?stores lastmove ?lx ?ly fact $?fact level ?level)
	(test (not (member$ false $?stores)))
=> 
	(printout t "SOLUTION FOUND AT LEVEL " ?level crlf)
	(printout t "GOAL FACT " ?f crlf)
	(printout t "NUMBER OF EXPANDED NODES OR TRIGGERED RULES " ?*nod-gen* crlf)
	(halt))

(defrule no_solution
	(declare (salience -99))
    
=>
	(printout t "SOLUTION NOT FOUND" crlf)
	(printout t "NUMBER OF EXPANDED NODES OR TRIGGERED RULES " ?*nod-gen* crlf)
	(halt))		


(deffunction start ()
        (reset)
	(printout t "Maximum depth:= " )
	(bind ?prof (read))
	(printout t "Search strategy " crlf "    1.- Breadth" crlf "    2.- Depth" crlf )
	(bind ?a (read))
	(if (= ?a 1)
	       then    (set-strategy breadth)
	       else   (set-strategy depth))
        (printout t " Execute run to start the program " crlf)
	(assert (max-depth ?prof))	
)


