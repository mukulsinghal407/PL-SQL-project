--This Cursor is used to print the details of all the books in the library
DECLARE
 CURSOR cBooks IS
 select * from book;
 xBooks cBooks%ROWTYPE; 
BEGIN 
    OPEN cBooks; 
    DBMS_OUTPUT.PUT_LINE('ISBN     ID     STATE     AVALABILITY     DEBY_COST     LOST_COST    LOCATION'); 
    DBMS_OUTPUT.PUT_LINE('-----------------------------------------------------------------------------'); 
    LOOP 
      FETCH cBooks 
      INTO xBooks; 
      EXIT WHEN cBooks%NOTFOUND; 
      DBMS_OUTPUT.PUT_LINE(xBooks.isbn || '     ' || xBooks.bookid || '     ' || xBooks.state || '     ' || xBooks.avalability || '     ' || xBooks.debycost || '     ' || xBooks.lostcost || '     ' || xBooks.address); 
    END LOOP; 
    CLOSE cBooks;
END;