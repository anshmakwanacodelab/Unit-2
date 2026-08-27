-- File: q2.sql
-- Name: Ansh Makwana | Roll No: 16 | B.Sc. IT Sem 3
SET SERVEROUTPUT ON;

DECLARE
    v_gross_salary NUMBER := 1150000;
    v_std_deduction CONSTANT NUMBER := 75000;
    v_taxable_income NUMBER;
    v_total_tax NUMBER := 0;
    v_monthly_tds NUMBER(10,2);
    v_take_home_monthly NUMBER(10,2);
BEGIN
    v_taxable_income := GREATEST(0, v_gross_salary - v_std_deduction);

    -- Searched CASE for Progressive Tax Slabs (FY 2024-25)[cite: 1]
    CASE
        WHEN v_taxable_income <= 300000 THEN
            v_total_tax := 0;
        WHEN v_taxable_income <= 700000 THEN
            v_total_tax := (v_taxable_income - 300000) * 0.05;
        WHEN v_taxable_income <= 1000000 THEN
            v_total_tax := (400000 * 0.05) + (v_taxable_income - 700000) * 0.10;
        WHEN v_taxable_income <= 1200000 THEN
            v_total_tax := (400000 * 0.05) + (300000 * 0.10) + (v_taxable_income - 1000000) * 0.15;
        WHEN v_taxable_income <= 1500000 THEN
            v_total_tax := (400000 * 0.05) + (300000 * 0.10) + (200000 * 0.15) + (v_taxable_income - 1200000) * 0.20;
        ELSE
            v_total_tax := (400000 * 0.05) + (300000 * 0.10) + (200000 * 0.15) + (300000 * 0.20) + (v_taxable_income - 1500000) * 0.30;
    END CASE;

    v_monthly_tds := v_total_tax / 12.0;
    v_take_home_monthly := (v_gross_salary - v_total_tax) / 12.0;

    DBMS_OUTPUT.PUT_LINE('==============================================');
    DBMS_OUTPUT.PUT_LINE('      INCOME TAX CALCULATION (FY 2024-25)     ');
    DBMS_OUTPUT.PUT_LINE('==============================================');
    DBMS_OUTPUT.PUT_LINE('Gross Annual Salary : Rs. ' || TO_CHAR(v_gross_salary, '99,99,999'));
    DBMS_OUTPUT.PUT_LINE('Standard Deduction  : Rs. ' || TO_CHAR(v_std_deduction, '99,99,999'));
    DBMS_OUTPUT.PUT_LINE('Taxable Income      : Rs. ' || TO_CHAR(v_taxable_income, '99,99,999'));
    DBMS_OUTPUT.PUT_LINE('Total Annual Tax    : Rs. ' || TO_CHAR(v_total_tax, '99,99,999'));
    DBMS_OUTPUT.PUT_LINE('Monthly TDS         : Rs. ' || TO_CHAR(v_monthly_tds, '99,990.99'));
    DBMS_OUTPUT.PUT_LINE('Monthly Take-Home   : Rs. ' || TO_CHAR(v_take_home_monthly, '99,990.99'));
    
    IF v_total_tax = 0 THEN
        DBMS_OUTPUT.PUT_LINE('Note: No tax this year - save more with PPF/ELSS!');
    END IF;
    DBMS_OUTPUT.PUT_LINE('==============================================');
END;
/