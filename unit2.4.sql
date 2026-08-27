-- File: q4.sql
-- Name: Ansh Makwana | Roll No: 16 | B.Sc. IT Sem 3
SET SERVEROUTPUT ON;

DECLARE
    v_roll_no CONSTANT NUMBER := 16;
    v_table_num NUMBER := MOD(v_roll_no, 9) + 2; -- 16 MOD 9 + 2 = 7 + 2 = 9[cite: 1]
    v_star_height NUMBER := 5 + MOD(v_roll_no, 5); -- 5 + 16 MOD 5 = 5 + 1 = 6[cite: 1]
    v_line VARCHAR2(200);
BEGIN
    -- Part A[cite: 1]
    DBMS_OUTPUT.PUT_LINE('=== Part A: Table of ' || v_table_num || ' ===');
    FOR i IN 1..20 LOOP
        DBMS_OUTPUT.PUT_LINE(v_table_num || ' x ' || LPAD(i, 2, ' ') || ' = ' || (v_table_num * i));
    END LOOP;

    -- Part B[cite: 1]
    DBMS_OUTPUT.PUT_LINE(CHR(10) || '=== Part B: Tables (2 to 5) Nested Loops ===');
    FOR i IN 1..10 LOOP
        v_line := '';
        FOR t IN 2..5 LOOP
            v_line := v_line || LPAD(t || 'x' || i || '=' || (t * i), 12, ' ');
        END LOOP;
        DBMS_OUTPUT.PUT_LINE(v_line);
    END LOOP;

    -- Part C[cite: 1]
    DBMS_OUTPUT.PUT_LINE(CHR(10) || '=== Part C: Star Triangle (Height ' || v_star_height || ') ===');
    FOR i IN 1..v_star_height LOOP
        DBMS_OUTPUT.PUT_LINE(RPAD('*', i, '*'));
    END LOOP;

    -- Part D[cite: 1]
    DBMS_OUTPUT.PUT_LINE(CHR(10) || '=== Part D: Number Pyramid (6 Rows) ===');
    FOR i IN 1..6 LOOP
        v_line := '';
        FOR j IN 1..i LOOP
            v_line := v_line || j;
        END LOOP;
        DBMS_OUTPUT.PUT_LINE(v_line);
    END LOOP;

    -- Part E[cite: 1]
    DBMS_OUTPUT.PUT_LINE(CHR(10) || '=== Part E: Reverse Triangle ===');
    FOR i IN REVERSE 1..v_star_height LOOP
        DBMS_OUTPUT.PUT_LINE(RPAD('*', i, '*'));
    END LOOP;
END;
/