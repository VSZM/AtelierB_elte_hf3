/* c_read
 * Author: Szegedi Gábor D071PO
 * Creation date: 2018-07-03
 */
MACHINE
    c_read
    
DEFINITIONS
    "definitions.def"
    
VARIABLES
    c_done, identifier, age, kids, gross_salary, holiday_after_age, holiday_after_kids, tax
    
INVARIANT
    c_done: BOOL
    & identifier : 1..employeeMax +-> 1..rangeMax 
    & age : 1..employeeMax +-> ageMin..ageMax 
    & kids : 1..employeeMax +-> kidsMin..kidsMax
    & gross_salary: 1..employeeMax +-> salaryMin..salaryMax
    & holiday_after_age: 1..employeeMax +-> holidayMin..holidayMax
    & holiday_after_kids: 1..employeeMax +-> holidayAfterKidsMin..holidayAfterKidsMax
    & tax: 1..employeeMax +-> salaryMin..salaryMax
	& dom(identifier) = 1..card(identifier)
	& dom(age) = 1..card(age)
	& dom(kids) = 1..card(kids)
	& dom(gross_salary) = 1..card(gross_salary)
	& dom(holiday_after_age) = 1..card(holiday_after_age)
	& dom(holiday_after_kids) = 1..card(holiday_after_kids)
	& dom(tax) = 1..card(tax)
    & (c_done = FALSE =>
            identifier = {}
        	& age = {}
        	& kids = {}
        	& gross_salary = {}
        	& holiday_after_age = {}
            & holiday_after_kids = {}
            & tax = {})
    & (c_done = TRUE =>
            dom(identifier) = 1..card(identifier)
        	& dom(age) = 1..card(age)
        	& dom(kids) = 1..card(kids)
        	& dom(gross_salary) = 1..card(gross_salary)
        	& dom(holiday_after_age) = 1..card(holiday_after_age)
        	& dom(holiday_after_kids) = 1..card(holiday_after_kids)
        	& dom(tax) = 1..card(tax))
            
    
INITIALISATION
	c_done := FALSE
	|| identifier := {}
    || age := {}
    || kids := {}
    || gross_salary := {}
    || holiday_after_age := {}
    || holiday_after_kids := {}
    || tax := {}
    
OPERATIONS
    
    c_init = 
    BEGIN
    	c_done := FALSE
    	|| identifier := {}
        || age := {}
        || kids := {}
        || gross_salary := {}
        || holiday_after_age := {}
        || holiday_after_kids := {}
        || tax := {}
 	END;
 	
 	
 	c_read_employees =
 	PRE
 	    c_done = FALSE
 	THEN
 	    ANY tmp_identifier, tmp_age, tmp_kids, tmp_gross_salary, tmp_holiday_after_age, tmp_holiday_after_kids, tmp_tax WHERE
 	       	tmp_identifier: 1..employeeMax +-> 1..rangeMax 
            & tmp_age : 1..employeeMax +-> ageMin..ageMax 
            & tmp_kids : 1..employeeMax +-> kidsMin..kidsMax
            & tmp_gross_salary: 1..employeeMax +-> salaryMin..salaryMax
            & tmp_holiday_after_age: 1..employeeMax +-> holidayMin..holidayMax
            & tmp_holiday_after_kids : 1..employeeMax +-> holidayAfterKidsMin..holidayAfterKidsMax
    		& tmp_tax: 1..employeeMax +-> salaryMin..salaryMax
    		& dom(tmp_identifier) = 1..card(tmp_identifier)
        	& dom(tmp_identifier) = dom(tmp_age)
        	& dom(tmp_identifier) = dom(tmp_kids)
        	& dom(tmp_identifier) = dom(tmp_gross_salary)
        	& dom(tmp_identifier) = dom(tmp_holiday_after_age)
        	& dom(tmp_identifier) = dom(tmp_holiday_after_kids)
        	& dom(tmp_identifier) = dom(tmp_tax)
			& dom(tmp_age) = 1..card(tmp_age)
			& dom(tmp_kids) = 1..card(tmp_kids)
			& dom(tmp_gross_salary) = 1..card(tmp_gross_salary)
			& dom(tmp_holiday_after_age) = 1..card(tmp_holiday_after_age)
			& dom(tmp_holiday_after_kids) = 1..card(tmp_holiday_after_kids)
			& dom(tmp_tax) = 1..card(tmp_tax)
        THEN
 	    	identifier := tmp_identifier
    		|| age := tmp_age
    		|| kids := tmp_kids
    		|| gross_salary := tmp_gross_salary
    		|| holiday_after_age := tmp_holiday_after_age
    		|| holiday_after_kids := tmp_holiday_after_kids
    		|| tax := tmp_tax
    		|| c_done := TRUE
		END
	END
END
