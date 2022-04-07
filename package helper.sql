CREATE OR REPLACE PACKAGE fundamentals_utils AS 

   TYPE t_array_type is table of varchar2(500);
   
   FUNCTION split_string(i_str     IN  VARCHAR2,
                        i_delim    IN  VARCHAR2 DEFAULT ',')
   RETURN t_array_type DETERMINISTIC;
   
END fundamentals_utils;
/
                          
                          
CREATE OR REPLACE PACKAGE BODY  fundamentals_utils AS

FUNCTION split_string(
    i_str    IN  VARCHAR2,
    i_delim  IN  VARCHAR2 DEFAULT ',')
    RETURN t_array_type DETERMINISTIC
  AS
    t_array_given t_array_type := t_array_type();
    p_start        NUMBER(5) := 1;
    p_end          NUMBER(5);
    c_len CONSTANT NUMBER(5) := LENGTH( i_str );
    c_ld  CONSTANT NUMBER(5) := LENGTH( i_delim );
  BEGIN
  
  t_array_given.DELETE;
  
    IF c_len > 0 THEN
      p_end := INSTR( i_str, i_delim, p_start );
      WHILE p_end > 0 LOOP
        t_array_given.EXTEND;
        t_array_given( t_array_given.COUNT ) := SUBSTR( i_str, p_start, p_end - p_start );
        p_start := p_end + c_ld;
        p_end := INSTR( i_str, i_delim, p_start );
      END LOOP;
      IF p_start <= c_len + 1 THEN
        t_array_given.EXTEND;
        t_array_given( t_array_given.COUNT ) := SUBSTR( i_str, p_start, c_len - p_start + 1 );
      END IF;
    END IF;
    RETURN t_array_given;
  END;
  END;
  