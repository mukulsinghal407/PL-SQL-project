-- This trigger has been made to maintain refential integrity of the tables when there is any deletion in the rent table 
CREATE OR REPLACE TRIGGER modifyFines_library 
AFTER DELETE 
ON rent 
FOR EACH ROW 
DECLARE 
  auxCardID NUMBER; 
  auxItemID VARCHAR(6); 
  auxBook NUMBER; 
  auxDeby NUMBER; 
  PRAGMA AUTONOMOUS_TRANSACTION;
BEGIN   
  SELECT cardid, itemid INTO auxCardID, auxItemID FROM rent WHERE cardid LIKE :old.cardid; 
   
  SELECT COUNT(*) INTO auxBook FROM book WHERE bookid LIKE auxItemID; 
   
  IF sysdate > :old.returndate THEN 
    IF auxBook > 0 THEN 
      SELECT debyCost INTO auxDeby 
      FROM book 
      WHERE bookid LIKE auxItemID; 
    END IF; 
    UPDATE card 
    SET status = 'B', fines = (fines + auxDeby) 
    WHERE cardid LIKE auxCardID; 
    DBMS_OUTPUT.PUT_LINE('The item has been return after deadline'); 
  ELSE 
    DBMS_OUTPUT.PUT_LINE('The item has been return before deadline'); 
  END IF; 
  COMMIT;
END; 