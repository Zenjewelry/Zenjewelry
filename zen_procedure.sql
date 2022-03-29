create or replace procedure getBestNewProduct_zen(
    p_cur1 out sys_refcursor,
    p_cur2 out sys_refcursor
)
is
begin
    open p_cur1 for
        select * from products where bestyn='y';
    open p_cur2 for
        select * from products where newyn='y';
end;



select * from products

drop table products


CREATE OR REPLACE PROCEDURE getBestNewProduct_zen(
    p_cur1 OUT SYS_REFCURSOR, 
    p_cur2 OUT SYS_REFCURSOR   )
IS
BEGIN
    OPEN p_cur1 FOR  
        SELECT * FROM products where newyn = 'y';
    OPEN p_cur2 FOR  
        SELECT * FROM products where bestyn= 'y';
END;

CREATE OR REPLACE PROCEDURE getMember_zen(
    p_id IN members.id%TYPE, 
    p_curvar OUT SYS_REFCURSOR
)
IS
BEGIN
    OPEN p_curvar FOR SELECT * FROM member WHERE userid=p_id;
END;


CREATE OR REPLACE PROCEDURE getMember_zen(
    p_id IN members.id%TYPE, 
    p_curvar OUT SYS_REFCURSOR
)
IS
BEGIN
    OPEN p_curvar FOR SELECT * FROM members WHERE id=p_id;
END;


CREATE OR REPLACE PROCEDURE listOrderByIdIng_zen(
   p_id IN orderss.id%TYPE,
   p_curvar OUT SYS_REFCURSOR
)
IS
BEGIN
    OPEN p_curvar FOR 
    SELECT distinct oseq FROM order_views WHERE id=p_id and result='1' order by oseq desc;
    -- 현재 위치에서 커서의 내용을 fetch 할게 아니라 반복실행도 fetch도 쓰지 않습니다. 
END;

select * from orderss;
select * from order_views;



CREATE OR REPLACE PROCEDURE listOrderByOseq_zen(
   p_oseq IN orderss.oseq%TYPE,
   p_curvar OUT SYS_REFCURSOR
)
IS
BEGIN
    OPEN p_curvar FOR SELECT * FROM order_views WHERE oseq=p_oseq;
    -- 현재 위치에서 커서의 내용을 fetch 할게 아니라 반복실행도 fetch도 쓰지 않습니다. 
END;

select * from boards;

select * from orders_details;

CREATE OR REPLACE PROCEDURE insertOrder_zen(
    p_id IN orderss.id%TYPE,
    p_oseq out orderss.oseq%TYPE)
IS  
      v_oseq ORDERSS.oseq%TYPE;
      temp_cur SYS_REFCURSOR;
      v_cseq carts.cseq%TYPE;
      v_pseq carts.pseq%TYPE;
      v_quantity carts.quantity%TYPE;
BEGIN
        -- orders 테이블에 레코드 추가 
        insert into orderss(oseq, id) values(orders_seq.nextVal, p_id);
        -- orders 테이블에서 가장 큰 oseq 조회 
        select MAX(oseq) into v_oseq from orderss;
        -- cart 테이블에서 id 로 목록조회 
        OPEN temp_cur FOR select cseq, pseq, quantity from carts where id=p_id AND result='1';
        -- 목록과 oseq 로 order_detail 테이블에 레코드 추가
        LOOP 
            FETCH temp_cur INTO v_cseq, v_pseq, v_quantity;  -- 조회한 카트의 목록에서 하나씩 꺼내서 처리 
            EXIT WHEN temp_cur%NOTFOUND;  -- 조회한 카트의 목록이 모두 소진할때까지 
            INSERT INTO orders_details ( odseq, oseq, pseq, quantity) 
            VALUES( orders_details_seq.nextVal, v_oseq, v_pseq, v_quantity );  -- order_detail 테이블에 레코드 추가 
            DELETE FROM CARTS WHERE cseq = v_cseq;
        END LOOP;
        COMMIT;
        -- oseq 값을 out 변수에 저장
        p_oseq := v_oseq;
END;


CREATE OR REPLACE PROCEDURE listOrderByIdAll_zen (
    p_id IN   ORDERSS.id%TYPE,
    p_rc   OUT     SYS_REFCURSOR )
IS
BEGIN
    OPEN p_rc FOR
        SELECT DISTINCT oseq FROM (SELECT oseq, id FROM ORDER_VIEWS ORDER BY result, oseq desc) WHERE id=p_id;
END;

select * from order_views;


CREATE OR REPLACE PROCEDURE insertOrderOne_zen(
   p_id IN orderss.id%TYPE,
   p_pseq IN orders_details.pseq %TYPE,
   p_quantity IN orders_details.quantity %TYPE,
   p_oseq OUT orderss.oseq%TYPE
)
IS  
      v_oseq ORDERSS.oseq%TYPE;
BEGIN
        insert into orderss(oseq, id) values(orders_seq.nextVal, p_id);
        select MAX(oseq) into v_oseq from orderss;
        insert into orders_details(odseq, oseq, pseq, quantity)
        values( orders_details_seq.nextVal, v_oseq, p_pseq, p_quantity);
        COMMIT;
        p_oseq := v_oseq;
END;

select * from cart;
select * from cart_views;


CREATE OR REPLACE PROCEDURE listCart_zen(
   p_id IN carts.id%TYPE,
   p_curvar OUT SYS_REFCURSOR
)
IS
BEGIN
    OPEN p_curvar FOR SELECT * FROM cart_views WHERE id=p_id;
    -- 현재 위치에서 커서의 내용을 fetch 할게 아니라 반복실행도 fetch도 쓰지 않습니다. 
END;

