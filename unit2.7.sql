-- File: q7.sql
-- Name: Ansh Makwana | Roll No: 16 | B.Sc. IT Sem 3
SET SERVEROUTPUT ON;

DECLARE
    v_att_pct NUMBER := 82;
    v_theory NUMBER := 54;       -- Out of 70[cite: 1]
    v_practical NUMBER := 24;    -- Out of 30[cite: 1]
    v_assignment NUMBER := 18;   -- Out of 20 (Max 10 counted)[cite: 1]

    v_counted_assign NUMBER;
    v_total NUMBER;
    v_pct NUMBER(5,2);
    v_grade VARCHAR2(5);
    v_result VARCHAR2(50);
    v_remark VARCHAR2(100);
BEGIN
    v_counted_assign := LEAST(v_assignment, 10);

    -- Attendance & Passing Criteria Rules[cite: 1]
    IF v_att_pct < 40 THEN
        v_result := 'DETAINED';
        v_grade := 'F';
        v_total := v_theory + v_practical + v_counted_assign;
        v_pct := (v_total / 110.0) * 100.0;
        v_remark := 'Detained due to critically low attendance (' || v_att_pct || '%).';
    ELSIF v_theory < 28 THEN
        v_result := 'FAIL';
        v_grade := 'F';
        v_total := v_theory + v_practical + v_counted_assign;
        v_pct := (v_total / 110.0) * 100.0;
        v_remark := 'Failed in Theory component (< 28 / 70).';
    ELSIF v_practical < 12 THEN
        v_result := 'FAIL';
        v_grade := 'F';
        v_total := v_theory + v_practical + v_counted_assign;
        v_pct := (v_total / 110.0) * 100.0;
        v_remark := 'Failed in Practical component (< 12 / 30).';
    ELSE
        v_total := v_theory + v_practical + v_counted_assign; -- Max 110[cite: 1]
        v_pct := (v_total / 110.0) * 100.0;
        v_result := 'PASS';
        
        -- Grade Assignment using CASE[cite: 1]
        v_grade := CASE
            WHEN v_pct >= 85 THEN 'A+'
            WHEN v_pct >= 75 THEN 'A'
            WHEN v_pct >= 65 THEN 'B'
            WHEN v_pct >= 50 THEN 'C'
            ELSE 'D'
        END;
        v_remark := 'Congratulations! Successfully passed the semester examination.';
    END IF;

    DBMS_OUTPUT.PUT_LINE('==============================================');
    DBMS_OUTPUT.PUT_LINE('       LJICA SEMESTER RESULT MARKSHEET        ');
    DBMS_OUTPUT.PUT_LINE('==============================================');
    DBMS_OUTPUT.PUT_LINE('Student Name   : Ansh Makwana (Roll No: 16)');
    DBMS_OUTPUT.PUT_LINE('Attendance     : ' || v_att_pct || '%');
    DBMS_OUTPUT.PUT_LINE('Theory Marks   : ' || v_theory || ' / 70');
    DBMS_OUTPUT.PUT_LINE('Practical Marks: ' || v_practical || ' / 30');
    DBMS_OUTPUT.PUT_LINE('Assignment     : ' || v_counted_assign || ' / 10 (Raw: ' || v_assignment || '/20)');
    DBMS_OUTPUT.PUT_LINE('Total Marks    : ' || v_total || ' / 110');
    DBMS_OUTPUT.PUT_LINE('Percentage     : ' || TO_CHAR(v_pct, '990.99') || '%');
    DBMS_OUTPUT.PUT_LINE('Grade Awarded  : ' || v_grade);
    DBMS_OUTPUT.PUT_LINE('Final Result   : ' || v_result);
    DBMS_OUTPUT.PUT_LINE('Remark         : ' || v_remark);
    DBMS_OUTPUT.PUT_LINE('==============================================');
END;
/