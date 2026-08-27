-- File: q6.sql
-- Name: Ansh Makwana | Roll No: 16 | B.Sc. IT Sem 3
SET SERVEROUTPUT ON;

DECLARE
    v_food_total NUMBER := 380;
    v_distance_km NUMBER := 6.5;
    v_is_rain BOOLEAN := TRUE;
    v_is_late_night BOOLEAN := FALSE;
    v_is_festival BOOLEAN := FALSE;
    v_is_peak_hour BOOLEAN := TRUE;
    v_is_first_order BOOLEAN := FALSE;

    v_base_delivery NUMBER := 0;
    v_surcharge_pct NUMBER := 0;
    v_surcharge_amt NUMBER := 0;
    v_final_delivery NUMBER := 0;
    v_grand_total NUMBER := 0;
BEGIN
    -- Base delivery charge calculation[cite: 1]
    IF v_distance_km < 3 THEN
        v_base_delivery := 0;
    ELSIF v_distance_km <= 8 THEN
        v_base_delivery := 29;
    ELSIF v_distance_km <= 15 THEN
        v_base_delivery := 49;
    ELSE
        v_base_delivery := 79;
    END IF;

    -- Cumulative Surcharges using searched CASE[cite: 1]
    v_surcharge_pct := CASE WHEN v_is_rain THEN 20 ELSE 0 END
                     + CASE WHEN v_is_late_night THEN 15 ELSE 0 END
                     + CASE WHEN v_is_festival THEN 10 ELSE 0 END
                     + CASE WHEN v_is_peak_hour THEN 10 ELSE 0 END;

    v_surcharge_amt := ROUND(v_base_delivery * (v_surcharge_pct / 100.0));
    v_final_delivery := v_base_delivery + v_surcharge_amt;

    -- Discounts using IF[cite: 1]
    IF v_food_total > 499 THEN
        v_final_delivery := 0; -- Free delivery overrides everything[cite: 1]
    ELSIF v_is_first_order THEN
        v_final_delivery := ROUND(v_final_delivery * 0.5); -- 50% discount[cite: 1]
    END IF;

    v_grand_total := v_food_total + v_final_delivery;

    DBMS_OUTPUT.PUT_LINE('==============================================');
    DBMS_OUTPUT.PUT_LINE('           ZOMATO DELIVERY RECEIPT            ');
    DBMS_OUTPUT.PUT_LINE('==============================================');
    DBMS_OUTPUT.PUT_LINE('Food Subtotal        : Rs. ' || v_food_total);
    DBMS_OUTPUT.PUT_LINE('Delivery Distance    : ' || v_distance_km || ' km');
    DBMS_OUTPUT.PUT_LINE('Base Delivery Fee    : Rs. ' || v_base_delivery);
    DBMS_OUTPUT.PUT_LINE('Surcharge Percentage : ' || v_surcharge_pct || '% (Rs. ' || v_surcharge_amt || ')');
    DBMS_OUTPUT.PUT_LINE('Final Delivery Fee   : Rs. ' || v_final_delivery);
    DBMS_OUTPUT.PUT_LINE('----------------------------------------------');
    DBMS_OUTPUT.PUT_LINE('GRAND TOTAL PAYABLE  : Rs. ' || v_grand_total);
    DBMS_OUTPUT.PUT_LINE('==============================================');
END;
/