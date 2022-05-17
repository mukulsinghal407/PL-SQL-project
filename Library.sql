-- This function is used to handle the return of items and modify the status of the given item in all the tables 
--affected by it.
DECLARE 
  auxItemID VARCHAR(10); 
  PROCEDURE handleReturns_library(auxItemID IN VARCHAR) 
    IS 
      auxRented NUMBER; 
      auxBook NUMBER; 
    BEGIN 
      SELECT COUNT(*) INTO auxRented 
      FROM rent 
      WHERE itemid LIKE auxItemID; 
      
      SELECT COUNT(*) INTO auxBook 
      FROM book 
      WHERE bookid LIKE auxItemID; 
      
      IF auxRented > 0 THEN 
        DELETE FROM rent 
        WHERE itemid = auxItemID; 
        IF auxBook > 0 THEN 
          UPDATE book 
          SET avalability = 'A' 
          WHERE bookid LIKE auxItemID; 
          DBMS_OUTPUT.PUT_LINE('The book ' || auxItemID || ' is now avaible.'); 
        END IF; 
      ELSE 
        DBMS_OUTPUT.PUT_LINE('This item is not rented at the moment'); 
      END IF; 
      EXCEPTION WHEN no_data_found THEN  
      DBMS_OUTPUT.PUT_LINE('Item ID incorrect');     
    END; 
BEGIN 
  auxItemID := 'B1A123'; 
  handleReturns_library(auxItemID); 
END; 