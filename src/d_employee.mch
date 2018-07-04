/* d_employee
 * Author: Szegedi Gábor D071PO
 * Creation date: 2018-07-03
 */
MACHINE
    d_employee
    
INCLUDES
    a_net, b_holiday, c_read
    
DEFINITIONS
    "definitions.def"
    
SETS
    D_STATUS_T = {INIT_D, READ_C, CALC_NET_A, CALC_HOLIDAY_B, DONE_D}
    
ABSTRACT_VARIABLES
    d_status
    
INVARIANT
    d_status : D_STATUS_T
    & (d_status = INIT_D => c_done = FALSE & a_done = FALSE & b_done = FALSE)
    & (d_status = READ_C => c_done = TRUE & a_done = FALSE & b_done = FALSE)
    & (d_status = CALC_NET_A => c_done = TRUE & a_done = TRUE & b_done = FALSE)
    & (d_status = CALC_HOLIDAY_B => c_done = TRUE & a_done = TRUE & b_done = TRUE)
 
INITIALISATION
    a_init
    || b_init
    || c_init
    || d_status := INIT_D
OPERATIONS
    
    d_init =
    BEGIN
    	a_init
    	|| b_init
    	|| c_init
    	|| d_status := INIT_D
    END;
 	
 	read_employees =
    PRE
        c_done = FALSE
        & a_done = FALSE
        & b_done = FALSE
        & d_status = INIT_D
    THEN
        c_read_employees
        || d_status := READ_C
    END;
    
    calc_profit = 
    PRE
        c_done = TRUE
        & a_done = FALSE
        & b_done = FALSE
        & d_status = READ_C
    THEN
        a_calc_net
        || d_status := CALC_NET_A
    END;
    
    calc_returning =
    PRE
        c_done = TRUE
        & a_done = TRUE
        & b_done = FALSE
        & d_status = CALC_NET_A
    THEN
        b_calc_holiday
        || d_status := CALC_HOLIDAY_B
    END;
    
    
    write_result =
    PRE
        c_done = TRUE
        & a_done = TRUE
        & b_done = TRUE
        & d_status = CALC_HOLIDAY_B
    THEN
        d_status := DONE_D
    END
END
