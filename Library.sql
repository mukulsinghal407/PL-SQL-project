-- Login for customer
DECLARE 
    PROCEDURE loginCustomer_library(user IN VARCHAR2, pass IN VARCHAR2) 
    IS 
      passAux customer.password%TYPE; 
      incorrect_password EXCEPTION; 
    BEGIN 
      SELECT password INTO passAux 
      FROM customer 
      WHERE username LIKE user; 
       
      IF passAux LIKE pass THEN 
        DBMS_OUTPUT.PUT_LINE('User ' || user || ' loging succesfull'); 
      ELSE 
        RAISE incorrect_password; 
      END IF; 
       
      EXCEPTION 
      WHEN no_data_found OR incorrect_password THEN  
           DBMS_OUTPUT.PUT_LINE('Incorrect username or password'); 
                                        
    END; 
BEGIN 
  loginCustomer_library('al1','alfred123'); 
END;


-- Login for Employee
DECLARE 
  PROCEDURE loginEmployee_library(user IN VARCHAR2, pass IN VARCHAR2) 
  IS 
    passAux employee.password%TYPE; 
   incorrect_password EXCEPTION; 
  BEGIN 
    SELECT password INTO passAux 
    FROM employee 
    WHERE username LIKE user; 
    IF passAux LIKE pass THEN 
     DBMS_OUTPUT.PUT_LINE('User ' || user || ' loging succesfull'); 
    ELSE 
    RAISE incorrect_password; 
    END IF; 
    EXCEPTION 
      WHEN no_data_found OR incorrect_password THEN  
           DBMS_OUTPUT.PUT_LINE('Incorrect username or password'); 
    END; 
BEGIN 
  loginEmployee_library('ro11','ross123'); 
END;


DECLARE 
  auxItemID VARCHAR2(10); 
    PROCEDURE viewItem_library(auxItemID IN VARCHAR2) 
    IS 
      auxISBN VARCHAR2(4); 
      auxState VARCHAR2(10); 
      auxDebyCost NUMBER(10,2); 
      auxLostCost NUMBER(10,2); 
      auxAddress VARCHAR2(50); 
      auxAbala VARCHAR2(1); 
      auxBook NUMBER; 
    BEGIN 
      SELECT COUNT(*) INTO auxBook 
      FROM book 
      WHERE bookid LIKE auxItemID; 
       
      IF auxBook > 0 THEN 
        SELECT isbn, state, avalability, debycost, lostcost, address 
        INTO auxISBN, auxState, auxAbala, auxDebyCost, auxLostCost, auxAddress 
        FROM book 
        WHERE bookid LIKE auxItemID; 
       
        DBMS_OUTPUT.PUT_LINE('BOOK ' || auxItemID || ' INFO'); 
        DBMS_OUTPUT.PUT_LINE('------------------------------------------'); 
        DBMS_OUTPUT.PUT_LINE('ISBN: ' || auxISBN); 
        DBMS_OUTPUT.PUT_LINE('STATE: ' || auxState); 
        DBMS_OUTPUT.PUT_LINE('AVALABILITY: ' || auxAbala); 
        DBMS_OUTPUT.PUT_LINE('DEBY COST: ' || auxDebyCost); 
        DBMS_OUTPUT.PUT_LINE('LOST COST: ' || auxLostCost); 
        DBMS_OUTPUT.PUT_LINE('ADDRESS: ' || auxAddress); 
        DBMS_OUTPUT.PUT_LINE('------------------------------------------'); 
      END IF; 
    END; 
BEGIN 
  auxItemID :='B1B234'; 
  viewItem_library(auxItemID); 
END;



--CUSTOMER-- 
DECLARE 
  custoID customer.customerid%TYPE; 
  PROCEDURE customerAccount_library(custoID IN customer.customerid%TYPE) 
    IS 
      auxCard NUMBER; 
      auxFines NUMBER; 
      auxItem VARCHAR(6); 
      rented number := 0; 
    BEGIN 
      SELECT cardnumber INTO auxCard 
      FROM customer 
      WHERE customerid LIKE custoID; 
       
      SELECT COUNT(*) INTO rented 
      FROM rent 
      WHERE rent.cardid LIKE auxcard; 
       
      DBMS_OUTPUT.PUT_LINE('The user card is ' || auxCard);   
      IF (rented > 0) THEN 
        SELECT rent.itemid INTO auxItem 
        FROM rent,card 
        WHERE card.cardid = rent.cardid 
        AND card.cardid LIKE auxCard;     
         
        DBMS_OUTPUT.PUT_LINE('The user has ' || auxItem || ' rented'); 
      ELSE     
        DBMS_OUTPUT.PUT_LINE('This user has no rents');  
      END IF; 
       
      SELECT fines INTO auxFines 
      FROM card 
      WHERE cardid LIKE auxcard; 
       
      DBMS_OUTPUT.PUT_LINE('The user fines are ' || auxFines); 
         
      EXCEPTION WHEN no_data_found THEN  
      DBMS_OUTPUT.PUT_LINE('NOT DATA FOUND'); 
    END; 
BEGIN 
  custoID := 4;  
  customerAccount_library(custoID); 
END;



--EMPLOYEE-- 
DECLARE 
  emploID employee.employeeid%TYPE; 
 PROCEDURE employeeAccount_library(emploID IN employee.employeeid%TYPE) 
    IS 
      auxCard NUMBER; 
      auxFines NUMBER; 
      auxItem VARCHAR(6); 
      rented number := 0; 
    BEGIN 
      SELECT cardnumber INTO auxCard 
      FROM employee 
      WHERE employeeid LIKE emploID; 
       
      SELECT COUNT(*) INTO rented 
      FROM rent 
      WHERE rent.cardid LIKE auxcard; 
       
      DBMS_OUTPUT.PUT_LINE('The user card is ' || auxCard);   
      IF (rented > 0) THEN 
        SELECT rent.itemid INTO auxItem 
        FROM rent,card 
        WHERE card.cardid = rent.cardid 
        AND card.cardid LIKE auxCard;     
         
        DBMS_OUTPUT.PUT_LINE('The user has ' || auxItem || ' rented'); 
      ELSE     
        DBMS_OUTPUT.PUT_LINE('This user has no rents');  
      END IF; 
       
      SELECT fines INTO auxFines 
      FROM card 
      WHERE cardid LIKE auxcard; 
       
      DBMS_OUTPUT.PUT_LINE('The user fines are ' || auxFines); 
         
      EXCEPTION WHEN no_data_found THEN  
      DBMS_OUTPUT.PUT_LINE('NOT DATA FOUND'); 
    END; 
BEGIN 
  emploID := 211; 
  employeeAccount_library(emploID); 
END;


--4-- 
DECLARE 
  auxCard NUMBER; 
  auxItemID VARCHAR2(10); 
  auxDate DATE; 
  PROCEDURE rentItem_library(auxCard IN NUMBER, auxItemID IN VARCHAR2, auxDate IN DATE) 
  IS 
   statusAux VARCHAR2(1); 
   itemStatus VARCHAR2(1); 
  BEGIN 
    SELECT status INTO statusAux 
    FROM card 
    WHERE cardid LIKE auxCard; 
    IF statusAux LIKE 'A' THEN 
     SELECT avalability INTO itemStatus 
     FROM book 
     WHERE bookid LIKE auxItemID; 
     IF itemStatus LIKE 'A' THEN 
       UPDATE book 
       SET avalability = 'O' 
       WHERE bookid LIKE auxItemID; 
       INSERT INTO rent VALUES (auxCard,auxItemID,sysdate,auxDate); 
       DBMS_OUTPUT.PUT_LINE('Item ' || auxItemID || ' rented'); 
     ELSE 
        DBMS_OUTPUT.PUT_LINE('The item is already rented'); 
     END IF; 
    ELSE 
     DBMS_OUTPUT.PUT_LINE('The user is blocked'); 
    END IF;     
  END; 
BEGIN 
  auxCard := 101;
  auxItemID := 'B2A123';
  auxDate := '20-May-2018';
  rentItem_library(auxCard,auxItemID,auxDate); 
END;

--5-- 
DECLARE 
  auxCard card.cardid%TYPE; 
  money NUMBER; 
  PROCEDURE payFines_library(auxCard IN card.cardid%TYPE, money IN NUMBER) 
    IS 
      finesAmount NUMBER; 
      total NUMBER; 
    BEGIN 
      SELECT fines INTO finesAmount 
      FROM card 
      WHERE cardid LIKE auxCard; 
       
      IF finesAmount < money THEN 
        total := money - finesAmount; 
        DBMS_OUTPUT.PUT_LINE('YOU HAVE PAYED ALL YOUR FINES AND YOU HAVE ' || total || ' MONEY BACK'); 
        UPDATE card 
        SET status = 'A', fines = 0 
        WHERE cardid = auxCard; 
      ELSIF finesAmount = money THEN 
        total := money - finesAmount; 
        DBMS_OUTPUT.PUT_LINE('YOU PAY ALL YOUR FINES'); 
        UPDATE card 
        SET status = 'A', fines = 0 
        WHERE cardid = auxCard; 
      ELSE 
        total := finesAmount - money; 
        DBMS_OUTPUT.PUT_LINE('YOU WILL NEED TO PAY ' || total || ' MORE DOLLARS TO UNLOCK YOUR CARD'); 
        UPDATE card 
        SET fines = total 
        WHERE cardid = auxCard; 
      END IF; 
    END; 
BEGIN 
  auxCard := 101; 
  money := 100;
  payFines_library(auxCard,money); 
END; 



