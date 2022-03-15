CREATE TABLE PROGRAM_INPUT(
plunder_days NUMBER,
daily_plunder NUMBER,
target_plunder NUMBER
);

INSERT INTO PROGRAM_INPUT(plunder_days,daily_plunder,target_plunder)
   VALUES(5, 40 , 100);
   
INSERT INTO PROGRAM_INPUT(plunder_days, daily_plunder,target_plunder)
   VALUES (10, 20, 380);
   
   

create or replace procedure solve_black_flag is

--selecting the data from the PROGRAM_INPUT table
   cursor c_program_input is
       select
             plunder_days
            ,daily_plunder
            ,target_plunder
       from 
         program_input;
      
   l_total_count NUMBER;
   l_perentage_left NUMBER(4,2);
   
   
begin
   
   for r_program_input in c_program_input
   loop
   
      l_total_count := 0;
      
      for curr_day in 1..r_program_input.plunder_days
      loop
         
--adding daily plunder to the count
         l_total_count := l_total_count + r_program_input.daily_plunder;
      
--check if number is divisible with remainer for 3 and 5 because 15 is for both 
         if mod(curr_day,3) = 0 then
         null;
            l_total_count := l_total_count + (r_program_input.daily_plunder * (1 - (50/100)));
         end if;
      
         if mod(curr_day,5) = 0 then
            l_total_count := l_total_count * (1 - (30/100));
         end if;
             
      end loop;

--check if the total counter is above the target or equal to it and print the message it needs to print
      if l_total_count >= r_program_input.target_plunder then
         sys.dbms_output.put_line('Ahoy! ' || l_total_count || ' plunder gained');
         
      else
         l_perentage_left := (l_total_count*100)/r_program_input.target_plunder;
         sys.dbms_output.put_line('Collected only ' || l_perentage_left || ' of the plunder');
         
      end if;
      
   end loop;
     
end;
/

begin
solve_black_flag;
end;
/



