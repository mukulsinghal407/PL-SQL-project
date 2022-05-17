-- This is used to update the information of the customers if required
DECLARE 
  auxCustomer customer.customerid%TYPE; 
  pNumber NUMBER; 
  address VARCHAR(20); 
  newPass VARCHAR(20); 
  PROCEDURE updateInfoCusto_library(auxCustomer IN customer.customerid%TYPE, pNumber NUMBER, address VARCHAR2, newPass VARCHAR2) 
    IS 
    BEGIN 
      UPDATE customer 
      SET phone = pNumber, customeraddress = address, password = newPass 
      WHERE customerid = auxCustomer;
      DBMS_OUTPUT.PUT_LINE('Successfully Updated customer table');
    END; 
BEGIN 
  auxCustomer := 4; 
  pNumber := 623623623; 
  address := 'WASHINGTON DC.'; 
  newPass := 'tom123'; 
  updateInfoCusto_library(auxCustomer,pNumber,address,newPass); 
END; 

-- This is used to update the information of the employee if required
DECLARE 
  auxEmployee employee.employeeid%TYPE; 
  pNumber NUMBER; 
  address VARCHAR(45); 
  newPass VARCHAR(45); 
  newPayCheck NUMBER; 
  newBranch VARCHAR(45); 
  PROCEDURE updateInfoEmp_library(auxEmployee IN employee.employeeid%TYPE, pNumber NUMBER, address VARCHAR2, newPass VARCHAR2, newPayCheck NUMBER, newBranch VARCHAR2) 
    IS 
    BEGIN 
      UPDATE employee 
      SET phone = pNumber, EMPLOYEEADDRESS = address, password = newPass, paycheck = auxEmployee, branchname = newBranch 
      WHERE employeeid = auxEmployee;
      DBMS_OUTPUT.PUT_LINE('Successfully Updated employee table');
END; 
BEGIN 
  auxEmployee := 211; 
  pNumber := 623623623; 
  address := 'HIS HOUSE'; 
  newPass := 'ross123'; 
  newPayCheck := 1300; 
  newBranch := 'COMPUTING'; 
  updateInfoEmp_library(auxEmployee,pNumber,address,newPass,newPayCheck,newBranch); 
END; 