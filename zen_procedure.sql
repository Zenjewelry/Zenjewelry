-- product
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




-- member
CREATE OR REPLACE PROCEDURE getMember_zen(
    p_id IN members.id%TYPE, 
    p_curvar OUT SYS_REFCURSOR
)
IS
BEGIN
    OPEN p_curvar FOR SELECT * FROM members WHERE id=p_id;
END;

-- order
CREATE OR REPLACE PROCEDURE listOrderByIdIng_zen(
   p_id IN orderss.id%TYPE,
   p_curvar OUT SYS_REFCURSOR
)
IS
BEGIN
    OPEN p_curvar FOR 
    SELECT distinct oseq FROM order_views WHERE id=p_id and result='1' order by oseq desc;
    -- ?ï¿½ï¿½?ï¿½ï¿½ ?ï¿½ï¿½ì¹ì?ï¿½ï¿½ ì»¤ì?ï¿½ï¿½ ?ï¿½ï¿½?ï¿½ï¿½?ï¿½ï¿½ fetch ?ï¿½ï¿½ï¿?? ?ï¿½ï¿½?ï¿½ï¿½?ï¿½ï¿½ ë°ë³µ?ï¿½ï¿½?ï¿½ï¿½?ï¿½ï¿½ fetch?ï¿½ï¿½ ?ï¿½ï¿½ï¿?? ?ï¿½ï¿½?ï¿½ï¿½?ï¿½ï¿½?ï¿½ï¿½. 
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
    -- ?ï¿½ï¿½?ï¿½ï¿½ ?ï¿½ï¿½ì¹ì?ï¿½ï¿½ ì»¤ì?ï¿½ï¿½ ?ï¿½ï¿½?ï¿½ï¿½?ï¿½ï¿½ fetch ?ï¿½ï¿½ï¿?? ?ï¿½ï¿½?ï¿½ï¿½?ï¿½ï¿½ ë°ë³µ?ï¿½ï¿½?ï¿½ï¿½?ï¿½ï¿½ fetch?ï¿½ï¿½ ?ï¿½ï¿½ï¿?? ?ï¿½ï¿½?ï¿½ï¿½?ï¿½ï¿½?ï¿½ï¿½. 
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
      
        insert into orderss(oseq, id) values(orders_seq.nextVal, p_id);
       
        select MAX(oseq) into v_oseq from orderss;
    
        OPEN temp_cur FOR select cseq, pseq, quantity from carts where id=p_id AND result='1';
       
        LOOP 
            FETCH temp_cur INTO v_cseq, v_pseq, v_quantity;  
            EXIT WHEN temp_cur%NOTFOUND; 
            INSERT INTO orders_details ( odseq, oseq, pseq, quantity) 
            VALUES( orders_details_seq.nextVal, v_oseq, v_pseq, v_quantity );  
            DELETE FROM CARTS WHERE cseq = v_cseq;
        END LOOP;
        COMMIT;
    
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

-- cart

CREATE OR REPLACE PROCEDURE listCart_zen(
   p_id IN carts.id%TYPE,
   p_curvar OUT SYS_REFCURSOR
)
IS
BEGIN
    OPEN p_curvar FOR SELECT * FROM cart_views WHERE id=p_id;
   
END;

-- board

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




create or replace procedure plusCount_zen(
    p_num in boards.num%type
)
is
begin
    update boards set readcount = readcount + 1 where num = p_num;
    commit;
end;





-- admin

CREATE OR REPLACE PROCEDURE getAdminMember_zen(
    p_id IN workers.id%TYPE, 
    p_rc OUT SYS_REFCURSOR
)
IS
BEGIN
    OPEN p_rc FOR SELECT * FROM workers WHERE id=p_id;
END;

-- 3/30 

-- member
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

-- board 
create or replace procedure deleteBoard_zen(
    p_num in boards.num%type
)
is
begin
    delete from boards where num = p_num;
    commit;
end;



create or replace procedure insertBoard_zen(
    p_userid in boards.userid%type,
    p_title in boards.title%type,
    p_content in boards.content%type,
    p_pictureurl in boards.pictureurl%type
)
is
begin
    insert into boards(num, userid, title, content, pictureurl)
    values(boards_seq.nextVal, p_userid, p_title, p_content, p_pictureurl);
    commit;
end;




create or replace procedure editBoard_zen(
    p_num in boards.num%type,
    p_title in boards.title%type,
    p_content in boards.content%type,
    p_pictureurl in boards.pictureurl%type
)
is
begin
    update boards set title = p_title, content = p_content, pictureurl = p_pictureurl where num = p_num;
    commit;
end;


-- delivery

CREATE OR REPLACE PROCEDURE updateAddress_zen(
   p_oseq IN orders_details.oseq%TYPE,
    p_zip_num IN orders_details.zip_num%TYPE,
    p_address IN orders_details.address%TYPE,
    p_address2 IN orders_details.address2%TYPE
    )
IS
BEGIN
    update orders_details set zip_num=p_zip_num, address=p_address, address2=p_address2
    where oseq=p_oseq;
    commit;
END;


CREATE OR REPLACE PROCEDURE deliveryList_zen(
   p_oseq IN orderss.oseq%TYPE,
   p_curvar OUT SYS_REFCURSOR
)
IS
BEGIN
    OPEN p_curvar FOR SELECT * FROM order_views WHERE oseq=p_oseq;
END;


----------------- 3/31
----------------  admin

CREATE OR REPLACE PROCEDURE insertProduct_zen(
    p_name IN products.name%TYPE,
    p_kind  IN products.kind%TYPE,
    p_price1  IN products.price1%TYPE,
    p_price2  IN products.price2%TYPE,
    p_content IN products.content%TYPE,
    p_image IN products.image%TYPE,
    p_newyn IN products.newyn%TYPE,
    p_bestyn IN products.bestyn%TYPE,
    p_indate IN products.indate%TYPE
IS
BEGIN
    insert into products(name, kind, price1, price2, content, image, newyn, bestyn, indate) 
    values( p_name, p_kind, p_price1, p_price2, p_content, p_image, p_newyn, p_bestyn, p_indate );
    commit;    
END;


CREATE OR REPLACE PROCEDURE getAllCountProduct_zen (  
    p_key IN products.name%TYPE,
    p_cnt  OUT NUMBER  )
IS
    v_cnt NUMBER;
BEGIN
    SELECT count(*) as cnt into v_cnt FROM PRODUCTS WHERE name like '%'||p_key||'%';
    p_cnt := v_cnt;
END;

CREATE OR REPLACE PROCEDURE getProductList (
    p_startNum NUMBER,
    p_endNum NUMBER,
    p_key PRODUCTS.NAME%TYPE,
    p_rc   OUT     SYS_REFCURSOR )
IS
BEGIN
    OPEN p_rc FOR
        select * from (
        select * from (
        select rownum as rn, p.* from((select * from products where name like '%'||p_key||'%' order by pseq desc) p)
        ) where rn>=p_startNum
        ) where rn<=p_endNum;
END;






-- 3/31
-- board

create or replace procedure insertReply_zen(
    p_userid in board_replys.userid%type,
    p_boardnum in board_replys.boardnum%type,
    p_content in board_replys.content%type
)
is
begin
    insert into board_replys(reply_num, boardnum, userid, content)
    values(board_replys_seq.nextVal, p_boardnum, p_userid, p_content);
    
    commit;
end;


create or replace procedure deleteReply_zen(
    p_reply_num in board_replys.reply_num%type
)
is
begin
    delete from board_replys where reply_num = p_reply_num;
    
    commit;
end;
































