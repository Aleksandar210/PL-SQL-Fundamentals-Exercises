
drop table program_input;

--creating the table that will hold concealed strings
CREATE TABLE PROGRAM_INPUT(
message_id NUMBER,
concealed_message VARCHAR2(1000),

constraint program_input_pk primary key(message_id)
);

insert into program_input(message_id, concealed_message)
   values (1,'heVVodar!gniV');
   
insert into program_input(message_id, concealed_message)
   values (2,'Hiware?uiy');


---------------------------------------------------------------------------------
alter table program_input_instructions
drop constraint prog_inp_instr_prog_input_fk;
drop table program_input_instructions;

--creating the table that will hold instructions to manipulate concealed strings
CREATE TABLE PROGRAM_INPUT_INSTRUCTIONS(
   instruction VARCHAR2(100),
   message_id NUMBER,
   
   constraint prog_inp_instr_prog_input_fk foreign key (message_id) references program_input(message_id)
);

-- (-)1 for REVEAL does nothing

insert into program_input_instructions(instruction, message_id) values('ChangeAll:|:V:|:l',1);
insert into program_input_instructions(instruction, message_id) values('Reverse:|:!gnil',1);
insert into program_input_instructions(instruction, message_id) values('InsertSpace:|:5',1);
insert into program_input_instructions(instruction, message_id) values('Reveal:|:-1',1);

insert into program_input_instructions(instruction, message_id) values('ChangeAll:|:i:|:o',2);
insert into program_input_instructions(instruction, message_id) values('Reverse:|:?uoy',2);
insert into program_input_instructions(instruction, message_id) values('Reverse:|:jd',2);
insert into program_input_instructions(instruction, message_id) values('InsertSpace:|:3',2);
insert into program_input_instructions(instruction, message_id) values('InsertSpace:|:7',2);
insert into program_input_instructions(instruction, message_id) values('Reveal:|:-1',2);

--example table relations
SELECT
   instruction,' ->' as apply_for,concealed_message
FROM
   program_input pin 
   join program_input_instructions pis on
      pin.message_id = pis.message_id;
      
     
