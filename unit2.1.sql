-- File: q1.sql
-- Name: Ansh Makwana | Roll No: 16 | B.Sc. IT Sem 3
SET SERVEROUTPUT ON;

DECLARE
    v_sub1 NUMBER := 78;
    v_sub2 NUMBER := 65;
    v_sub3 NUMBER := 82;
    v_sub4 NUMBER := 58;
    v_sub5 NUMBER := 74;
    
    v_total NUMBER;
    v_pct NUMBER(5,2);
    v_grade VARCHAR2(10);
    v_class VARCHAR2(30);
    v_detained BOOLEAN := FALSE;
    v_failed_subs VARCHAR2(100) := '';
BEGIN
    -- Check individual subject pass criteria (Min 35)[cite: 1]
    IF v_sub1 < 35 THEN v_detained := TRUE; v_failed_subs := v_failed_subs || 'Sub1 '; END IF;
    IF v_sub2 < 35 THEN v_detained := TRUE; v_failed_subs := v_failed_subs || 'Sub2 '; END IF;
    IF v_sub3 < 35 THEN v_detained := TRUE; v_failed_subs := v_failed_subs || 'Sub3 '; END IF;
    IF v_sub4 < 35 THEN v_detained := TRUE; v_failed_subs := v_failed_subs || 'Sub4 '; END IF;
    IF v_sub5 < 35 THEN v_detained := TRUE; v_failed_subs := v_failed_subs || 'Sub5 '; END IF;

    v_total := v_sub1 + v_sub2 + v_sub3 + v_sub4 + v_sub5;
    v_pct := v_total / 5.0;

    -- Grade Calculation[cite: 1]
    IF v_pct >= 90 THEN
        v_grade := 'A+';
    ELSIF v_pct >= 80 THEN
        v_grade := 'A';
    ELSIF v_pct >= 70 THEN
        v_grade := 'B';
    ELSIF v_pct >= 60 THEN
        v_grade := 'C';
    ELSIF v_pct >= 50 THEN
        v_grade := 'D';
    ELSE
        v_grade := 'FAIL';
    END IF;

    DBMS_OUTPUT.PUT_LINE('==============================================');
    DBMS_OUTPUT.PUT_LINE('             STUDENT REPORT CARD              ');
    DBMS_OUTPUT.PUT_LINE('==============================================');
    DBMS_OUTPUT.PUT_LINE('Name: Ansh Makwana      Roll No: 16');
    DBMS_OUTPUT.PUT_LINE('Marks: ' || v_sub1 || ', ' || v_sub2 || ', ' || v_sub3 || ', ' || v_sub4 || ', ' || v_sub5);
    DBMS_OUTPUT.PUT_LINE('Total Marks : ' || v_total || ' / 500');
    DBMS_OUTPUT.PUT_LINE('Percentage  : ' || TO_CHAR(v_pct, '990.99') || '%');
    DBMS_OUTPUT.PUT_LINE('Grade       : ' || v_grade);

    -- Result Status and Class Rank[cite: 1]
    IF v_detained THEN
        DBMS_OUTPUT.PUT_LINE('Result      : DETAINED');
        DBMS_OUTPUT.PUT_LINE('Failed In   : ' || v_failed_subs);
    ELSE
        IF v_pct >= 75 THEN
            v_class := 'Distinction';
        ELSIF v_pct >= 60 THEN
            v_class := 'First Class';
        ELSIF v_pct >= 50 THEN
            v_class := 'Second Class';
        ELSE
            v_class := 'Pass Class';
        END IF;
        DBMS_OUTPUT.PUT_LINE('Result      : PASS');
        DBMS_OUTPUT.PUT_LINE('Class Rank  : ' || v_class);
    END IF;
    DBMS_OUTPUT.PUT_LINE('==============================================');
END;
/