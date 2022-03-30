
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
    -- ?��?�� ?��치에?�� 커서?�� ?��?��?�� fetch ?���? ?��?��?�� 반복?��?��?�� fetch?�� ?���? ?��?��?��?��. 
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
    -- ?��?�� ?��치에?�� 커서?�� ?��?��?�� fetch ?���? ?��?��?�� 반복?��?��?�� fetch?�� ?���? ?��?��?��?��. 
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
        -- orders ?��?��블에 ?��코드 추�? 
        insert into orderss(oseq, id) values(orders_seq.nextVal, p_id);
        -- orders ?��?��블에?�� �??�� ?�� oseq 조회 
        select MAX(oseq) into v_oseq from orderss;
        -- cart ?��?��블에?�� id �? 목록조회 
        OPEN temp_cur FOR select cseq, pseq, quantity from carts where id=p_id AND result='1';
        -- 목록�? oseq �? order_detail ?��?��블에 ?��코드 추�?
        LOOP 
            FETCH temp_cur INTO v_cseq, v_pseq, v_quantity;  -- 조회?�� 카트?�� 목록?��?�� ?��?��?�� 꺼내?�� 처리 
            EXIT WHEN temp_cur%NOTFOUND;  -- 조회?�� 카트?�� 목록?�� 모두 ?��진할?��까�? 
            INSERT INTO orders_details ( odseq, oseq, pseq, quantity) 
            VALUES( orders_details_seq.nextVal, v_oseq, v_pseq, v_quantity );  -- order_detail ?��?��블에 ?��코드 추�? 
            DELETE FROM CARTS WHERE cseq = v_cseq;
        END LOOP;
        COMMIT;
        -- oseq 값을 out �??��?�� ???��
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
    -- ?��?�� ?��치에?�� 커서?�� ?��?��?�� fetch ?���? ?��?��?�� 반복?��?��?�� fetch?�� ?���? ?��?��?��?��. 
END;

create or replace procedure getAllCount_zen(
    p_key in varchar2,
    p_cnt out number
)
is
    v_cnt number;
begin
    select count(*) into v_cnt from boards where title like '%'||p_key||'%';
    p_cnt := v_cnt;
end;




create or replace procedure getBoardList_zen(
    p_key in varchar2,
    p_startNum in number,
    p_endNum in number,
    p_cur out sys_refcursor
)
is
begin
    open p_cur for
        select * from (
            select * from (
                select rownum as rn, b.* from
                   ((select * from boards where title like '%'||p_key||'%' order by num desc) b)
            ) where rn>=p_startNum
        ) where rn<=p_endNum;
end;




create or replace procedure getReplyCnt_zen(
    p_boardnum in number,
    p_replycnt out number
)
is
    v_replycnt number;
begin
    select count(*) into v_replycnt from board_replys where boardnum = p_boardnum;
        
    p_replycnt := v_replycnt;
end;




create or replace procedure getBoard_zen(
    p_num in boards.num%type,
    p_cur1 out sys_refcursor,
    p_cur2 out sys_refcursor
)
is
begin
    open p_cur1 for
        select * from boards where num = p_num;
    open p_cur2 for
        select * from board_replys where boardnum = p_num;
end;


select * from board_replys







CREATE OR REPLACE PROCEDURE getAdminMember_zen(
    p_id IN workers.id%TYPE, 
    p_rc OUT SYS_REFCURSOR
)
IS
BEGIN
    OPEN p_rc FOR SELECT * FROM workers WHERE id=p_id;
END;


CREATE OR REPLACE PROCEDURE getMember_zen(
    p_id IN members.id%TYPE, 
    p_curvar OUT SYS_REFCURSOR
)
IS
BEGIN
    OPEN p_curvar FOR SELECT * FROM members WHERE id=p_id;
END;

CREATE OR REPLACE PROCEDURE selectAddressByDong_zen(
    p_dong IN member.address%TYPE, 
    p_curvar OUT SYS_REFCURSOR
)
IS
BEGIN
    OPEN p_curvar FOR SELECT * FROM address WHERE dong LIKE '%'||p_dong||'%';
END;

CREATE OR REPLACE PROCEDURE insertMember_zen(
    p_id IN members.id%TYPE,
    p_pwd  IN members.pwd%TYPE,
    p_name  IN members.name%TYPE,
    p_email  IN members.email%TYPE,
    p_phone  IN members.phone%TYPE,
    p_zip_num IN members.zip_num%TYPE,
    p_address IN members.address%TYPE)
IS
BEGIN
    insert into members(id, pwd, name, email, phone, zip_num, address)
    values( p_id, p_pwd, p_name, p_email, p_phone, p_zip_num, p_address );
    commit;    
END;


create or replace procedure deleteBoard_zen(
    p_num in boards.num%type
)
is
begin
    delete from boards where num = p_num;
    commit;
end;































