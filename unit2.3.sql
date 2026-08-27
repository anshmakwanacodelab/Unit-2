-- File: q3.sql
-- Name: Ansh Makwana | Roll No: 16 | B.Sc. IT Sem 3
SET SERVEROUTPUT ON;

DECLARE
    v_roll_no CONSTANT NUMBER := 16;
    v_balance NUMBER := (v_roll_no * 500) + 5000; -- 16 * 500 + 5000 = 13,000[cite: 1]
    v_choice NUMBER;
    v_withdraw_amt NUMBER;
    v_successful_txns NUMBER := 0;
    v_total_withdrawn NUMBER := 0;
    v_step NUMBER := 1;
BEGIN
    DBMS_OUTPUT.PUT_LINE('=== INITIAL BALANCE: Rs. ' || v_balance || ' ===');

    LOOP
        -- Simulated Inputs across 4 iterations[cite: 1]
        IF v_step = 1 THEN
            v_choice := 1; v_withdraw_amt := 2000;
        ELSIF v_step = 2 THEN
            v_choice := 1; v_withdraw_amt := 150; -- Invalid (not multiple of 100)[cite: 1]
        ELSIF v_step = 3 THEN
            v_choice := 1; v_withdraw_amt := 5000;
        ELSIF v_step = 4 THEN
            v_choice := 3; -- Exit choice[cite: 1]
        END IF;

        IF v_choice = 1 THEN
            DBMS_OUTPUT.PUT_LINE('--- Processing Txn Request: Rs. ' || v_withdraw_amt || ' ---');
            IF v_withdraw_amt <= 0 THEN
                DBMS_OUTPUT.PUT_LINE('Error: Withdrawal amount must be greater than 0.');
            ELSIF MOD(v_withdraw_amt, 100) != 0 THEN
                DBMS_OUTPUT.PUT_LINE('Error: Amount must be a multiple of 100.');
            ELSIF v_withdraw_amt > 10000 THEN
                DBMS_OUTPUT.PUT_LINE('Error: Max withdrawal limit is Rs. 10,000 per txn.');
            ELSIF v_withdraw_amt > v_balance THEN
                DBMS_OUTPUT.PUT_LINE('Error: Insufficient account balance.');
            ELSE
                v_balance := v_balance - v_withdraw_amt;
                v_total_withdrawn := v_total_withdrawn + v_withdraw_amt;
                v_successful_txns := v_successful_txns + 1;
                DBMS_OUTPUT.PUT_LINE('Txn Success! Dispensed: Rs. ' || v_withdraw_amt || ' | Remaining Balance: Rs. ' || v_balance);
            END IF;
        END IF;

        EXIT WHEN v_choice = 3 OR v_balance = 0;
        v_step := v_step + 1;
    END LOOP;

    DBMS_OUTPUT.PUT_LINE('==============================================');
    DBMS_OUTPUT.PUT_LINE('             ATM FINAL SUMMARY                ');
    DBMS_OUTPUT.PUT_LINE('==============================================');
    DBMS_OUTPUT.PUT_LINE('Successful Transactions : ' || v_successful_txns);
    DBMS_OUTPUT.PUT_LINE('Total Amount Withdrawn  : Rs. ' || v_total_withdrawn);
    DBMS_OUTPUT.PUT_LINE('Closing Balance         : Rs. ' || v_balance);
    DBMS_OUTPUT.PUT_LINE('==============================================');
END;
/