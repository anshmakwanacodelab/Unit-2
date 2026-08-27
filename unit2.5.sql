-- File: q5.sql
-- Name: Ansh Makwana | Roll No: 16 | B.Sc. IT Sem 3
SET SERVEROUTPUT ON;

DECLARE
    v_roll_no CONSTANT NUMBER := 16;
    v_n CONSTANT NUMBER := 5 + MOD(v_roll_no, 8); -- 5 + 0 = 5[cite: 1]
    
    a NUMBER := 0;
    b NUMBER := 1;
    c NUMBER;
    v_nth_fib NUMBER;
    
    -- Prime checking vars[cite: 1]
    i NUMBER;
    v_is_prime BOOLEAN;
    v_prime_count NUMBER := 0;
    
    -- GCD vars[cite: 1]
    g_a NUMBER := 48;
    g_b NUMBER := 18;
    orig_a NUMBER := 48;
    orig_b NUMBER := 18;
    r NUMBER;
    
    -- Perfect number vars[cite: 1]
    v_perf_target NUMBER := 28;
    v_div_sum NUMBER := 0;
    d NUMBER;
BEGIN
    -- Part A: First N Fibonacci numbers[cite: 1]
    DBMS_OUTPUT.PUT_LINE('=== Part A: First ' || v_n || ' Fibonacci Numbers ===');
    FOR idx IN 1..v_n LOOP
        IF idx = 1 THEN
            c := 0;
        ELSIF idx = 2 THEN
            c := 1;
        ELSE
            c := a + b;
            a := b;
            b := c;
        END IF;
        DBMS_OUTPUT.PUT(c || ' ');
        v_nth_fib := c;
    END LOOP;
    DBMS_OUTPUT.NEW_LINE;

    -- Part B: Check if Nth Fibonacci is prime[cite: 1]
    DBMS_OUTPUT.PUT_LINE(CHR(10) || '=== Part B: Check Nth Fibonacci (' || v_nth_fib || ') ===');
    IF v_nth_fib < 2 THEN
        DBMS_OUTPUT.PUT_LINE(v_nth_fib || ' is NOT Prime.');
    ELSE
        v_is_prime := TRUE;
        i := 2;
        WHILE (i * i) <= v_nth_fib LOOP
            IF MOD(v_nth_fib, i) = 0 THEN
                v_is_prime := FALSE;
                EXIT;
            END IF;
            i := i + 1;
        END LOOP;
        IF v_is_prime THEN
            DBMS_OUTPUT.PUT_LINE(v_nth_fib || ' is PRIME.');
        ELSE
            DBMS_OUTPUT.PUT_LINE(v_nth_fib || ' is NOT Prime.');
        END IF;
    END IF;

    -- Part C: Primes between 1 and 100[cite: 1]
    DBMS_OUTPUT.PUT_LINE(CHR(10) || '=== Part C: Primes Between 1 and 100 ===');
    FOR num IN 2..100 LOOP
        v_is_prime := TRUE;
        i := 2;
        WHILE (i * i) <= num LOOP
            IF MOD(num, i) = 0 THEN
                v_is_prime := FALSE;
                EXIT;
            END IF;
            i := i + 1;
        END LOOP;
        IF v_is_prime THEN
            DBMS_OUTPUT.PUT(num || ' ');
            v_prime_count := v_prime_count + 1;
        END IF;
    END LOOP;
    DBMS_OUTPUT.NEW_LINE;
    DBMS_OUTPUT.PUT_LINE('Total Primes Count: ' || v_prime_count);

    -- Part D: GCD of two numbers[cite: 1]
    DBMS_OUTPUT.PUT_LINE(CHR(10) || '=== Part D: GCD Calculation ===');
    WHILE g_b != 0 LOOP
        r := MOD(g_a, g_b);
        g_a := g_b;
        g_b := r;
    END LOOP;
    DBMS_OUTPUT.PUT_LINE('GCD of ' || orig_a || ' and ' || orig_b || ' is: ' || g_a);

    -- Part E: Perfect number check[cite: 1]
    DBMS_OUTPUT.PUT_LINE(CHR(10) || '=== Part E: Perfect Number Check ===');
    d := 1;
    WHILE d < v_perf_target LOOP
        IF MOD(v_perf_target, d) = 0 THEN
            v_div_sum := v_div_sum + d;
        END IF;
        d := d + 1;
    END LOOP;
    IF v_div_sum = v_perf_target THEN
        DBMS_OUTPUT.PUT_LINE(v_perf_target || ' is a PERFECT number.');
    ELSE
        DBMS_OUTPUT.PUT_LINE(v_perf_target || ' is NOT a perfect number.');
    END IF;
END;
/