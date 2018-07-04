/* a_net
 * Author: Szegedi Gábor D071PO
 * Creation date: 2018-07-03
 */
MACHINE
    b_holiday
    
USES
    c_read
    
DEFINITIONS
    "definitions.def"

VARIABLES
    b_done, holiday
    
INVARIANT
    b_done : BOOL
    & holiday : 1..employeeMax +-> NAT  
    & dom(holiday) = 1..card(holiday) 
    & (b_done = FALSE => holiday : 1..employeeMax +-> NAT )
    & (b_done = TRUE =>
        dom(holiday) = dom(identifier)
        & !ii.(ii : dom(holiday) => holiday(ii) = holiday_after_age(ii) + holiday_after_kids(ii) ) ) 
 
INITIALISATION
    b_done := FALSE
    || holiday := {}
OPERATIONS
    
    b_init =
    BEGIN
        b_done := FALSE
        || holiday := {}
	END;
	

   /* // TODO: Move this to c_read as a partial function
	daysCalculated <-- holiday_after_age(age) = 
	PRE 
	    age : NAT
	THEN
	    ANY days WHERE
	        days : NAT
	        & (age >= 0 & age < 25) => days = 20
	        & (age >= 25 & age < 28) => days = 21
	        & (age >= 28 & age < 31) => days = 22
	        & (age >= 31 & age < 33) => days = 23
	        & (age >= 33 & age < 35) => days = 24
	        & (age >= 35 & age < 37) => days = 25
	        & (age >= 37 & age < 39) => days = 26
	        & (age >= 39 & age < 40) => days = 27
	        & (age >= 40 & age < 43) => days = 28
	        & (age >= 43 & age < 45) => days = 29
	        & age >= 45 => days = 30
	    THEN
	        daysCalculated := days
	    END
	END;
		
	// TODO: Move this to c_read as a partial function
	daysCalculated <-- holiday_after_kids(kids) = 
	PRE 
	    kids : NAT
	THEN
	    ANY days WHERE
	        days : NAT
	        & (kids = 0) => days = 0
	        & (kids = 1) => days = 2
	        & (kids = 2) => days = 4
	        & (kids > 2) => days = 7	        
	    THEN
	        daysCalculated := days
	    END
	END;*/
	
	
	b_calc_holiday =
    PRE
        b_done = FALSE
        & c_done = TRUE
    THEN
        ANY tmp_holiday WHERE
    		tmp_holiday : 1..employeeMax +-> NAT
    		& dom(tmp_holiday) = 1..card(tmp_holiday)
			& dom(tmp_holiday) = dom(identifier)
        	& !ii.(ii : dom(tmp_holiday) => tmp_holiday(ii) = holiday_after_age(ii) + holiday_after_kids(ii))
        THEN
            holiday := tmp_holiday
            || b_done := TRUE
        END
    END
END
