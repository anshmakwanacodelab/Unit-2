-- File: q8.sql
-- Name: Ansh Makwana | Roll No: 16 | B.Sc. IT Sem 3
SET SERVEROUTPUT ON;

DECLARE
    v_monthly_salary NUMBER := 60000;
    v_existing_emi NUMBER := 5000;
    v_loan_amount NUMBER := 1800000;
    v_annual_rate NUMBER := 8.5; -- 8.5% p.a.
    v_tenure_months NUMBER := 120; -- 10 Years

    v_monthly_rate NUMBER;
    v_emi NUMBER;
    v_foir_limit NUMBER;
    v_max_allowed_loan NUMBER;
    v_approved_loan NUMBER;
    v_decision VARCHAR2(20);
BEGIN
    v_foir_limit := v_monthly_salary * 0.40; -- 40% FOIR limit[cite: 1]
    v_max_allowed_loan := v_monthly_salary * 60; -- Max 60x salary[cite: 1]
    v_monthly_rate := (v_annual_rate / 12.0) / 100.0;

    -- Calculate initial requested EMI: P * r * (1+r)^n / ((1+r)^n - 1)[cite: 1]
    v_emi := v_loan_amount * v_monthly_rate * POWER(1 + v_monthly_rate, v_tenure_months) 
             / (POWER(1 + v_monthly_rate, v_tenure_months) - 1);

    v_approved_loan := LEAST(v_loan_amount, v_max_allowed_loan);

    -- Reduce requested loan in steps of 10,000 if EMI exceeds available FOIR[cite: 1]
    IF v_monthly_salary < 25000 THEN
        v_decision := 'REJECTED';
        v_approved_loan := 0;
        v_emi := 0;
    ELSE
        WHILE (v_emi + v_existing_emi) > v_foir_limit AND v_approved_loan > 0 LOOP
            v_approved_loan := v_approved_loan - 10000;
            IF v_approved_loan <= 0 THEN
                v_approved_loan := 0;
                v_emi := 0;
                EXIT;
            END IF;
            v_emi := v_approved_loan * v_monthly_rate * POWER(1 + v_monthly_rate, v_tenure_months) 
                     / (POWER(1 + v_monthly_rate, v_tenure_months) - 1);
        END LOOP;

        -- Decision using CASE[cite: 1]
        v_decision := CASE
            WHEN v_approved_loan = v_loan_amount THEN 'APPROVED'
            WHEN v_approved_loan > 0 THEN 'CONDITIONAL'
            ELSE 'REJECTED'
        END;
    END IF;

    DBMS_OUTPUT.PUT_LINE('==============================================');
    DBMS_OUTPUT.PUT_LINE('          LOAN AFFORDABILITY PORTAL           ');
    DBMS_OUTPUT.PUT_LINE('==============================================');
    DBMS_OUTPUT.PUT_LINE('Monthly Salary   : Rs. ' || v_monthly_salary);
    DBMS_OUTPUT.PUT_LINE('Existing EMI     : Rs. ' || v_existing_emi);
    DBMS_OUTPUT.PUT_LINE('FOIR Limit (40%) : Rs. ' || v_foir_limit);
    DBMS_OUTPUT.PUT_LINE('Requested Loan   : Rs. ' || v_loan_amount);
    DBMS_OUTPUT.PUT_LINE('Approved Loan    : Rs. ' || v_approved_loan);
    DBMS_OUTPUT.PUT_LINE('Sanctioned EMI   : Rs. ' || ROUND(v_emi, 2));
    DBMS_OUTPUT.PUT_LINE('Application Status: ' || v_decision);
    DBMS_OUTPUT.PUT_LINE('==============================================');
END;
/