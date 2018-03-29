( check is the last number in stack is even number )
: isEvenNum 
	dup 2 % not 
;

( check is number is prime )
: isPrimeNum 
	dup 2 < if
		0 
	else 
		dup 2 = if 
			1 
		else 
			dup dup 2 / 2 do 
				r@ % 0 = if 
					0 
					r> drop r@ >r
				then
			loop
			drop 1
		then
	then 
;

( Add Memory Cell )
: AMC
	cell% allot dup rot swap ! 
;	

( copy one part of the string )
: mstr
	dup count ( address len ) 
	swap 1 - swap ( address-1 len)
	1 + ( address-1 len+1)
	0 do ( i = 0; max = len+1 )
		1 + 
		over over 
		c@ swap r@ + c!
	loop heap-free 
;

( Concatenation of Strings str1 str2 - str1+str2 )
: cstr
	over over count swap count dup >r + ( count1_str + count2_str = sumlen_str )
	1 + heap-alloc
	rot ( str2 buf str1 )
	mstr 
	dup r> +
	rot mstr drop 
;


( str - num )
: string-hash
	0 >r ( init accumulator )
	repeat
		dup c@ ( stacks: str char, acc )
		dup if ( not end of the line )
			r> 13 * + 65537 % ( iteration of hash computations )
			>r 1 + 0
		else ( end of line )
			drop drop r> 1
		then
	until
;

( return modulus of the number )
: abs dup 2 * - ;
	
( variant 1 m" Баранец" primarity | num - bool_answer )
: isPrimarityNum 
	dup 0 < if 
		abs 
	then 
	dup 2 < if 
		drop 0
	then
	dup 2 = if 
		drop 1
	else
		2 repeat
			over over
			dup * % if 
				1 + over over dup * < if 
					1 1 
				else 
					0 
				then 
    		else 
        		0 1 
    		then 
		until
		rot rot drop drop
	then
;