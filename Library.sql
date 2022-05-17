--this procedure is used to add new books in the library database-- 
DECLARE 
  auxISBN VARCHAR2(4); 
  auxItemID VARCHAR2(6); 
  auxState VARCHAR2(10); 
  auxDebyCost NUMBER(10,2); 
  auxLostCost NUMBER(10,2); 
  auxAddress VARCHAR2(50); 
    PROCEDURE addBook_library(auxISBN IN VARCHAR2, auxBookID IN VARCHAR2, auxState IN VARCHAR2, auxDebyCost IN NUMBER, 
    auxLostCost IN NUMBER, auxAddress IN VARCHAR2) 
    IS 
    BEGIN 
      INSERT INTO book 
      VALUES(auxISBN,auxBookID,auxState,'A',auxDebyCost,auxLostCost,auxAddress); 
      DBMS_OUTPUT.PUT_LINE('Book inserted correctly'); 
    END; 
BEGIN 
    auxISBN := 'D123'; 
    auxItemID := 'B2B234'; 
    auxState := 'NEW'; 
    auxDebyCost := 5; 
    auxLostCost := 15; 
    auxAddress := 'CHEMISTRY ROAD'; 
    addBook_library(auxISBN, auxItemID, auxState, auxDebyCost, auxLostCost, auxAddress); 
END; 
