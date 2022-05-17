-- To maintain the referential integrity of the tables we need this trigger to make a card after there has been insertion 
-- in the employee table
CREATE OR REPLACE TRIGGER addCardEmp_library 
AFTER INSERT 
ON employee 
FOR EACH ROW 
DECLARE 
BEGIN 
  INSERT INTO card 
  VALUES (:new.cardnumber,'A',0); 
  DBMS_OUTPUT.PUT_LINE('Card created'); 
END; 