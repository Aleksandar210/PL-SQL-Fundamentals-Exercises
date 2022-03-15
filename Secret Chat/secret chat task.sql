---------------------
--reverse string
create or replace function reverse_string(string_to_reverse in varchar2)
   return varchar2 is
len pls_integer;
i pls_integer;
reversed_string VARCHAR2(1000) := '';
begin
   len:=length(string_to_reverse);
   for i in reverse 1..len
   loop
   reversed_string := reversed_string || substr(string_to_reverse,i,1);
   end loop;

   return reversed_string;
end;
/





--CHANGE ALL FUNCTION
create or replace function changeAll(to_change in varchar2,
                                     to_change_with in varchar2,
                                     string_to_be_changed in out varchar2) 
                  return varchar2 deterministic is
begin
   return regexp_replace(string_to_be_changed, to_change, to_change_with);
end;
/

--REVERSE 
create or replace function reverse_substr(current_string in out varchar2
                                          ,substr_to_reverse in varchar2 )
                  return varchar2 deterministic is
   substring varchar2(2000) := substr_to_reverse;
begin
   if instr(current_string, substring) > 0 
   then
      
      return (replace(current_string, substr_to_reverse, '') || reverse_string(substring) );
   else
      return current_string;
   end if;
end;
/

--Insert Space
create or replace function insertSpace(current_string in out varchar2, index_to_insert in pls_integer)
                  return varchar2 deterministic
is
   curr_string_last_indx pls_integer := length(current_string);
   curr_string_first_indx constant pls_integer := 1;
   
begin
   if index_to_insert < curr_string_last_indx and index_to_insert > curr_string_first_indx
   then
      current_string := substr(current_string, 1, index_to_insert) || chr(10) || substr(current_string, index_to_insert + 1);
   elsif index_to_insert = curr_string_first_indx or index_to_insert = 0
   then
      current_string := chr(10) || substr(current_string, 1);
   else
      current_string := substr(current_string, 1, curr_string_last_indx - 1) || chr(10);
   end if;
   
   return current_string;
end;
/
-----------------






-----------------
--solve secret chat
declare
--decalring the array that will hold the instruction parts
   t_instructions fundamentals_utils.t_array_type := fundamentals_utils.t_array_type();
   
--declaring an array that will hold the encrypted words from the chat
   type t_concealed_messages_type is table of program_input.concealed_message%type
      index by pls_integer;
      
   t_concealed_messages t_concealed_messages_type;
   
--cursor to read the concealed messages 
   cursor c_messages is
      select 
            message_id
           ,concealed_message
      from program_input;
      
--cursor to iterate trough the commands 
   cursor c_commands is
      select 
            instruction
            ,message_id
         from program_input_instructions;
           
   
begin

--insert messages 
   for r_message in c_messages
   loop
      t_concealed_messages(r_message.message_id) := r_message.concealed_message;
   end loop;
   
--iterate trough commands and execute each command;
   for r_command in c_commands
   loop
      t_instructions := fundamentals_utils.split_string(r_command.instruction,':|:',t_instructions);
      case 
         when t_instructions(1) = 'ChangeAll' then
         t_concealed_messages(r_command.message_id) := changeAll(t_instructions(2), t_instructions(3),t_concealed_messages(r_command.message_id));
                                                 
         when t_instructions(1) = 'Reverse' then
               t_concealed_messages(r_command.message_id) := reverse_substr(t_concealed_messages(r_command.message_id),t_instructions(2));
                           
         when t_instructions(1) = 'InsertSpace' then 
                     t_concealed_messages(r_command.message_id) := insertSpace(t_concealed_messages(r_command.message_id),t_instructions(2));
         when t_instructions(1) = 'Reveal' then sys.dbms_output.put_line(t_concealed_messages(r_command.message_id));
         else null;
      end case;
      
   end loop;
end;
/
