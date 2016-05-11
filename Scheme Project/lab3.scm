;
;Anthony Skinner
;4/11/2016
;Scheme Lab 3
;

(define (f list)
	
	;lf;aksj;flakjsd;
	(if(null? list)
		;;lkajsdlfkas;;
		'()
		; alfkjsd;
		(cons( + 1 (car list)) (f (cdr list)))))

(define ( member? e list)	
	(cond 
	((null? list) #f); check if the first element is null;
	((eq? e (car list)) #t) ; if e is equal to the first element in the list;
	(else (member? e (cdr list)))); else recurse on everything else;
)

(define (set? list)	
	(cond
	((null? list) #t) ;if the list is empty we know its a set
	((member? (car list) (cdr list)) #f); if matches any other elements in the list it is not a set
	(else (set? (cdr list)))); recursively go through every element in the list
)

(define (union list1 list2);
	(helper '() (append list1 list2))
)

(define (helper list1 list2)
	(cond
		((null? list2) list1); check if the list is null and return the list
		((member? (car list2) (cdr list2))(helper list1 (cdr list2)));check to see if the element is repeated remove it if it is
		(else (helper (append list1(list (car list2))) (cdr list2)))); add non repeated element to the set
)

(define (intersect list1 list2)
	(iHelper '() (append list1 list2))	
)

(define (iHelper list1 list2)
	(cond 
		( (null? list2) list1)
		((member? (car list2) (cdr list2)) (iHelper (append list1(list (car list2))) (cdr list2))); check if the element is repeated, it it is remove it
	(else (iHelper list1 (cdr list2)))); add the non repeated element to the set
)
;(display (f '( 2 7 8 1 3 9)))
;(display (member? 4 '( 1 2 3 4)))
;(display (set? '( 1 2 2 3 4 5)))
;(display (member? 'one '(1 2 3 4 5)))
(display (member? d '(a b c d c b a)))
;(display (set? '( a b c d c b a)))
;(display (set? '(it was the best of times, it was the worst of times)))
;(display (union '(blue eggs and cheese) '(ham and sandwich)))
;(display (intersect '(blue eggs and cheese) '( ham and sandwich)))
