/* a_net
 * Author: Szegedi Gábor D071PO
 * Creation date: 2018-07-03
 */
MACHINE
    a_net
    
USES
    c_read
 
DEFINITIONS
    "definitions.def"
    
VARIABLES
    a_done, net
    
INVARIANT
    a_done : BOOL
    & net : 1..employeeMax +-> MININT..MAXINT // The net salary of the employees
    & dom(net) = 1..card(net) 
    & (a_done = FALSE => net : 1..employeeMax +-> MININT..MAXINT)
    & (a_done = TRUE =>
        dom(net) = dom(identifier)
        & !ii.(ii : dom(net) => net(ii) = gross_salary(ii) - tax(ii))) 
INITIALISATION
    a_done := FALSE
    || net := {}
    
OPERATIONS

    a_init =
    BEGIN
       a_done := FALSE
   	   || net := {} 
	END;
	
	a_calc_net =
	PRE
	    a_done = FALSE
	    & c_done = TRUE
	THEN
	    ANY tmp_net WHERE
	        tmp_net : 1..employeeMax +-> MININT..MAXINT
	        & dom(tmp_net) = 1..card(tmp_net)
	        & dom(tmp_net) = dom(identifier)
	        & !ii.(ii : dom(tmp_net) => tmp_net(ii) = gross_salary(ii) - tax(ii))
	    THEN
	        net := tmp_net
	        || a_done := TRUE
	    END
	END
END
