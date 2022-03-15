--This is the input data for the task Black Flag

--creating the table that holds the inputs
CREATE TABLE PROGRAM_INPUT(
plunder_days NUMBER,
daily_plunder NUMBER,
target_plunder NUMBER
);
--inserting the data into the table
INSERT INTO PROGRAM_INPUT(plunder_days,daily_plunder,target_plunder)
   VALUES(5, 40 , 100);
   
INSERT INTO PROGRAM_INPUT(plunder_days, daily_plunder,target_plunder)
   VALUES (10, 20, 380);