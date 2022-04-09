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
    -- ?Ã¯Â¿Â½Ã¯Â¿Â½?Ã¯Â¿Â½Ã¯Â¿Â½ ?Ã¯Â¿Â½Ã¯Â¿Â½Ã¬Â¹ÂÃ¬ÂÂ?Ã¯Â¿Â½Ã¯Â¿Â½ Ã¬Â»Â¤Ã¬ÂÂ?Ã¯Â¿Â½Ã¯Â¿Â½ ?Ã¯Â¿Â½Ã¯Â¿Â½?Ã¯Â¿Â½Ã¯Â¿Â½?Ã¯Â¿Â½Ã¯Â¿Â½ fetch ?Ã¯Â¿Â½Ã¯Â¿Â½Ã¯Â¿?? ?Ã¯Â¿Â½Ã¯Â¿Â½?Ã¯Â¿Â½Ã¯Â¿Â½?Ã¯Â¿Â½Ã¯Â¿Â½ Ã«Â°ÂÃ«Â³Âµ?Ã¯Â¿Â½Ã¯Â¿Â½?Ã¯Â¿Â½Ã¯Â¿Â½?Ã¯Â¿Â½Ã¯Â¿Â½ fetch?Ã¯Â¿Â½Ã¯Â¿Â½ ?Ã¯Â¿Â½Ã¯Â¿Â½Ã¯Â¿?? ?Ã¯Â¿Â½Ã¯Â¿Â½?Ã¯Â¿Â½Ã¯Â¿Â½?Ã¯Â¿Â½Ã¯Â¿Â½?Ã¯Â¿Â½Ã¯Â¿Â½. 
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
    -- ?Ã¯Â¿Â½Ã¯Â¿Â½?Ã¯Â¿Â½Ã¯Â¿Â½ ?Ã¯Â¿Â½Ã¯Â¿Â½Ã¬Â¹ÂÃ¬ÂÂ?Ã¯Â¿Â½Ã¯Â¿Â½ Ã¬Â»Â¤Ã¬ÂÂ?Ã¯Â¿Â½Ã¯Â¿Â½ ?Ã¯Â¿Â½Ã¯Â¿Â½?Ã¯Â¿Â½Ã¯Â¿Â½?Ã¯Â¿Â½Ã¯Â¿Â½ fetch ?Ã¯Â¿Â½Ã¯Â¿Â½Ã¯Â¿?? ?Ã¯Â¿Â½Ã¯Â¿Â½?Ã¯Â¿Â½Ã¯Â¿Â½?Ã¯Â¿Â½Ã¯Â¿Â½ Ã«Â°ÂÃ«Â³Âµ?Ã¯Â¿Â½Ã¯Â¿Â½?Ã¯Â¿Â½Ã¯Â¿Â½?Ã¯Â¿Â½Ã¯Â¿Â½ fetch?Ã¯Â¿Â½Ã¯Â¿Â½ ?Ã¯Â¿Â½Ã¯Â¿Â½Ã¯Â¿?? ?Ã¯Â¿Â½Ã¯Â¿Â½?Ã¯Â¿Â½Ã¯Â¿Â½?Ã¯Â¿Â½Ã¯Â¿Â½?Ã¯Â¿Â½Ã¯Â¿Â½. 
END;


select * from order_views;




CREATE OR REPLACE PROCEDURE listOrderByIdAll_zen (
    p_id IN   ORDERSS.id%TYPE,
    p_rc   OUT     SYS_REFCURSOR )
IS
BEGIN
    OPEN p_rc FOR
        SELECT DISTINCT oseq FROM (SELECT oseq, id FROM ORDER_VIEWS ORDER BY result, oseq desc) WHERE id=p_id;
END;

select * from order_views;


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



select * from products;
CREATE OR REPLACE PROCEDURE getAllCountAdminProduct_zen (  
    p_key IN products.name%TYPE,
    p_cnt  OUT NUMBER  )
IS
    v_cnt NUMBER;
BEGIN
    SELECT count(*) as cnt into v_cnt FROM PRODUCTS WHERE name like '%'||p_key||'%';
    p_cnt := v_cnt;
END;

CREATE OR REPLACE PROCEDURE getAdminProductList_zen (
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


-- cart


create or replace PROCEDURE deleteCart_zen(
    p_cseq IN carts.cseq%TYPE )
IS
BEGIN
   Delete From carts where cseq = p_cseq;
    commit;
END;

-- product

create or replace procedure getProductList_zen(
    p_comm in number,
    p_startNum in number,
    p_endNum in number,
    p_cur out sys_refcursor
)
is
begin
    open p_cur for
        select * from (
            select * from (
                select rownum as rn, p.* from
                    ((select * from products where kind like p_comm) p)
            ) where rn>=p_startNum
        ) where rn<=p_endNum;
end;






create or replace procedure getBestProductList_zen(
    p_startNum in number,
    p_endNum in number,
    p_cur out sys_refcursor
)
is
begin
    open p_cur for
        select * from (
            select * from (
                select rownum as rn, p.* from
                    ((select * from products where bestyn = 'y') p)
            ) where rn>=p_startNum
        ) where rn<=p_endNum;
end;



create or replace procedure getAllCountProduct_zen(
    p_comm in number,
    p_cnt out number
)
is
    v_cnt number;
begin
    select count(*) into v_cnt from products where kind like p_comm;
    p_cnt := v_cnt;
end;

select count(*) from products where kind = p_comm;
create or replace procedure getAllCountBestProduct_zen(
    p_cnt out number
)
is
    v_cnt number;
begin
    select count(*) into v_cnt from products where bestyn = 'y';
    p_cnt := v_cnt;
end;



create or replace procedure getProduct_zen(
    p_pseq in products.pseq%type,
    p_cur1 out sys_refcursor,
    p_cur2 out sys_refcursor
)
is
begin
    open p_cur1 for
        select * from products where pseq = p_pseq;
    
    open p_cur2 for
        select * from product_qna where pseq = p_pseq;
end;



create or replace procedure insertProductQna_zen(
    p_id in product_qna.id%type,
    p_pwd in product_qna.pwd%type,
    p_pseq in product_qna.pseq%type,
    p_subject in product_qna.subject%type,
    p_content in product_qna.content%type
)
is
begin
    insert into product_qna(qna_num, id, pwd, pseq, subject, content)
        values(qna_num_seq.nextVal, p_id, p_pwd, p_pseq, p_subject, p_content);
    commit;
end;



create or replace procedure getProductQna_zen(
    p_qnum in product_qna.qna_num%type,
    p_cur out sys_refcursor
)
is
begin
    open p_cur for
        select * from product_qna where qna_num = p_qnum;
end;






-- 04/01

-- product
create or replace procedure deleteProductQna_zen(
    p_qnum in product_qna.qna_num%type
)
is
begin
    delete from product_qna where qna_num = p_qnum;
    commit;
end;



-- admin
create or replace procedure getAllCountAdminQna_zen(
    p_key in varchar2,
    p_count out number
)
is
    v_count number;
begin
    select count(*) into v_count from qnas where subject like '%'||p_key||'%' or content like '%'||p_key||'%';
    p_count := v_count;
end;


create or replace procedure getAdminQnaList_zen(
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
                select rownum as rn, q.* from
                   ((select * from qnas where subject like '%'||p_key||'%' or content like '%'||p_key||'%' order by qseq) q)
            ) where rn >= p_startNum
        ) where rn <= p_endNum;
end;




CREATE OR REPLACE PROCEDURE getAllCountAdminProduct_zen (  
    p_key IN products.name%TYPE,
    p_cnt  OUT NUMBER  )
IS
    v_cnt NUMBER;
BEGIN
    SELECT count(*) as cnt into v_cnt FROM PRODUCTS WHERE name like '%'||p_key||'%';
    p_cnt := v_cnt;
END;

CREATE OR REPLACE PROCEDURE getAdminProductList_zen (
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



create or replace procedure getAdminQna_zen(
    p_qseq in qnas.qseq%type,
    p_cur out sys_refcursor
)
is
begin
    open p_cur for
        select * from qnas where qseq = p_qseq;
end;


create or replace procedure insertQnaReply_zen(
    p_qseq in number,
    p_reply in varchar2
)
is
begin
    update qnas set reply = p_reply, rep=2 where qseq = p_qseq;
    commit;
end;

-- order





-- 04/02
-- adminProduct



CREATE OR REPLACE PROCEDURE updateProduct_zen(
    p_pseq IN products.pseq%TYPE,
    p_name IN products.name%TYPE,
    p_kind  IN products.kind%TYPE,
    p_price1  IN products.price1%TYPE,
    p_price2  IN products.price2%TYPE,
    p_content IN products.content%TYPE,
    p_image IN products.image%TYPE,
    p_detail_image IN products.detail_image%TYPE,
    p_newyn IN products.newyn%TYPE,
    p_bestyn IN products.bestyn%TYPE
)
IS
BEGIN
    update products set name=p_name, kind=p_kind, price1=p_price1, price2=p_price2, content=p_content, image=p_image, detail_image=p_detail_image, newyn=p_newyn, bestyn=p_bestyn 
    where pseq=p_pseq;
    commit;    
END;




-- 04/03
-- admin

create or replace procedure getAllCountAdminProductQna_zen(
    p_key in varchar2,
    p_count out number
)
is
    v_count number;
begin
    select count(*) into v_count from product_qna where subject like '%'||p_key||'%' or content like '%'||p_key||'%';
    p_count := v_count;
end;



create or replace procedure getProductQnaList_zen(
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
                select rownum as rn, q.* from
                   ((select * from product_qna where subject like '%'||p_key||'%' or content like '%'||p_key||'%' order by qna_num desc) q)
            ) where rn >= p_startNum
        ) where rn <= p_endNum;
end;




create or replace procedure getProductQnaDetail_zen(
    p_qnum in product_qna.qna_num%type,
    p_cur1 out sys_refcursor,
    p_cur2 out sys_refcursor
)
is
    v_pseq number;
begin
    select pseq into v_pseq from product_qna where qna_num = p_qnum;
    
    open p_cur1 for
        select * from products where pseq = v_pseq;
    
    open p_cur2 for
        select * from product_qna where qna_num = p_qnum;
end;



create or replace procedure adminProductQnaReplySave_zen(
    p_qnum in product_qna.qna_num%type,
    p_reply in varchar2
)
is
begin
    update product_qna set reply = p_reply, rep=2 where qna_num = p_qnum;
    commit;
end;


create or replace procedure deleteProductQna_zen(
    p_qnum in product_qna.qna_num%type
)
is
begin
    delete from product_qna where qna_num = p_qnum;
    commit;
end;


create or replace procedure deleteProduct_zen(
    p_pseq in product.pseq%type
)
is
begin
    delete from products where pseq = p_pseq;
    commit;
end;


create or replace procedure getAllCountMember_zen(
    p_key in varchar2,
    p_cnt out number
)
IS
    v_cnt NUMBER;
BEGIN
    SELECT count(*) into v_cnt FROM members where name like '%'||p_key||'%';
    p_cnt:=v_cnt;
END;



create or replace procedure getMemberList_zen(
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
                select rownum as rn, q.* from
                   ((select * from members where name like '%'||p_key||'%' order by id desc) q)
            ) where rn >= p_startNum
        ) where rn <= p_endNum;
end;



create or replace procedure getAllCountOrder_zen(
    p_key in varchar2,
    p_cnt out number
)
IS
    v_cnt NUMBER;
BEGIN
    select count(*) into v_cnt FROM order_views where mname like '%'||p_key||'%';
    p_cnt:=v_cnt;
END;




create or replace procedure getOrderList_zen(
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
                select rownum as rn, q.* from
                   ((select * from order_views where mname like '%'||p_key||'%' order by result, oseq desc) q)
            ) where rn >= p_startNum
        ) where rn <= p_endNum;
end;



create or replace procedure saveOrder_zen(
    p_odseq in number
)
is
begin
    update orders_details set result = 2 where odseq = p_odseq;
    commit;
end;





-- qna
create or replace procedure getQnaList_zen(
    p_id in qnas.id%type,
    p_startNum in number,
    p_endNum in number,
    p_cur out sys_refcursor
)
is
begin
    open p_cur for
        select * from (
            select * from (
                select rownum as rn, q.* from
                   ((select * from qnas where id = p_id order by qseq desc) q)
            ) where rn>=p_startNum
        ) where rn<=p_endNum;
end;



create or replace procedure getAllCountQna_zen(
    p_id in varchar2,
    p_cnt out number
)
is
    v_cnt number;
begin
    select count(*) into v_cnt from qnas where id = p_id;
    p_cnt := v_cnt;
end;




create or replace procedure getQnaDetail_zen(
    p_qseq in qnas.qseq%type,
    p_cur out sys_refcursor
)
is
begin
    open p_cur for
        select * from qnas where qseq = p_qseq;
end;


-- order


CREATE OR REPLACE PROCEDURE insertOrderOne_zen(
   p_id IN orderss.id%TYPE,
   p_address IN orders_details.address%TYPE,
   p_zip_num IN orders_details.zip_num%TYPE,
   p_address2 IN orders_details.address2%TYPE,
   p_pseq IN orders_details.pseq %TYPE,
   p_quantity IN orders_details.quantity %TYPE,
   p_oseq OUT orderss.oseq%TYPE
)
IS  
      v_oseq ORDERSS.oseq%TYPE;
BEGIN
        insert into orderss(oseq, id) values(orders_seq.nextVal, p_id);
        select MAX(oseq) into v_oseq from orderss;
        insert into orders_details(odseq, oseq, pseq, quantity,address,zip_num,address2)
        values( orders_details_seq.nextVal, v_oseq, p_pseq, p_quantity,p_address,p_zip_num,p_address2);
        COMMIT;
        p_oseq := v_oseq;
END;

create or replace procedure insertQna_zen(
    p_id in qnas.id%type,
    p_subject in qnas.subject%type,
    p_content in qnas.content%type
)
is
begin
    insert into qnas(qseq, subject, content, id)
    values(qna_seq.nextVal, p_subject, p_content, p_id);
    commit;
end;







create or replace procedure deleteOrder_zen(
    p_oseq in orderss.oseq%type
)
is
begin
    delete from orders_details where oseq = p_oseq;
    delete from orderss where oseq = p_oseq;
end;




-- 4/4
-- order




--admin
create or replace procedure deleteMember_zen(
    p_id in members.id%type
)
is
begin
    delete from members where id = p_id;
    commit;
end;




--member
CREATE OR REPLACE PROCEDURE findId_zen(
    p_name IN members.name%TYPE, 
    p_phone IN members.phone%TYPE,
    p_curvar OUT SYS_REFCURSOR
)
IS
BEGIN
    OPEN p_curvar FOR SELECT * FROM members WHERE name=p_name and phone=p_phone;
END;









-- 04/05



-- member

create or replace PROCEDURE getMember_zen(
    p_id IN members.id%TYPE, 
    p_curvar OUT SYS_REFCURSOR
)
IS
BEGIN
    OPEN p_curvar FOR SELECT * FROM members WHERE id=p_id;
END;

create or replace PROCEDURE selectAddressByDong_zen(
    p_dong IN member.address%TYPE, 
    p_curvar OUT SYS_REFCURSOR
)
IS
BEGIN
    OPEN p_curvar FOR SELECT * FROM address WHERE dong LIKE '%'||p_dong||'%';
END;



create or replace PROCEDURE updateMember_zen(
    p_id IN members.id%TYPE,
    p_pwd  IN members.pwd%TYPE,
    p_name  IN members.name%TYPE,
    p_email  IN members.email%TYPE,
    p_phone  IN members.phone%TYPE,
    p_zip_num IN members.zip_num%TYPE,
    p_address IN members.address%TYPE,
    p_address2 IN members.address2%TYPE)
IS
BEGIN
    update members set pwd=p_pwd, name=p_name, email=p_email, phone=p_phone, 
    zip_num=p_zip_num, address=p_address, address2=p_address2 where id=p_id;
    commit;    
END;

create or replace PROCEDURE findId_zen(
    p_name IN members.name%TYPE, 
    p_phone IN members.phone%TYPE,
    p_curvar OUT SYS_REFCURSOR
)
IS
BEGIN
    OPEN p_curvar FOR SELECT * FROM members WHERE name=p_name and phone=p_phone;
END;

create or replace PROCEDURE findPwd_zen(
    p_name IN members.name%TYPE, 
    p_id IN members.id%TYPE,
    p_pwd IN members.pwd%TYPE
)
IS
BEGIN
    update members set pwd = p_pwd where name = p_name and id = p_id;
    commit;
END;

create or replace procedure selectMember_zen(
    p_name IN members.name%TYPE,
    p_phone IN members.phone%TYPE,
    p_email IN members.email%TYPE,
    p_cursor OUT SYS_REFCURSOR
)
IS
BEGIN
    OPEN p_cursor FOR SELECT * FROM members where name=p_name and phone=p_phone and email=p_email;
    commit;
END;


create or replace procedure selectPwd_zen(
    p_email IN members.email%TYPE,
    p_name IN members.name%TYPE,
    p_id IN members.id%TYPE,
    p_cursor OUT SYS_REFCURSOR
)
IS
BEGIN
    OPEN p_cursor FOR SELECT * FROM members where email=p_email and name=p_name and id=p_id;
    commit;
END;




-- 04/06
-- promotion

create or replace procedure findProduct_zen(
    p_pseq in number,
    p_cur out sys_refcursor
)
is
begin
    open p_cur for
        select pseq, name, price2 from products where pseq = p_pseq;
end;



create or replace procedure insertPromotion_zen(
    p_banner in promotions.banner%type,
    p_main_subject in promotions.main_subject%type,
    p_sub_subject in promotions.sub_subject%type,
    p_sdate in date,
    p_edate in date,
    p_prmseq out number
)
is
    v_prmseq number;
begin
    insert into promotions(prmseq, banner, main_subject, sub_subject, sdate, edate)
    values(promotions_seq.nextVal, p_banner, p_main_subject, p_sub_subject, p_sdate, p_edate);
    commit;
    select max(prmseq) into v_prmseq from promotions;
    p_prmseq := v_prmseq;
end;







create or replace procedure insertPromotion_products_zen(
    p_prmseq in promotion_products.prmseq%type,
    p_outnumber in promotion_products.outnumber%type,
    p_summary in promotion_products.summary%type,
    p_pseq in promotion_products.pseq%type,
    p_prmprice in promotion_products.prmprice%type
)
is
begin
    insert into promotion_products(prmseq, outnumber, summary, pseq, prmprice)
    values(p_prmseq, p_outnumber, p_summary, p_pseq, p_prmprice);
    commit;
end;



create or replace procedure getAllCountPromotion_zen(
    p_key in varchar2,
    p_cnt out number
)
is
    v_cnt number;
begin
    select count(*) into v_cnt from promotion_view where main_subject like '%'||p_key||'%' or sub_subject like '%'||p_key||'%';
    p_cnt := v_cnt;
end;



create or replace procedure getPromotionList_zen(
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
                select rownum as rn, q.* from
                   ((select distinct prmseq, banner, main_subject, sub_subject from promotion_view 
                   where main_subject like '%'||p_key||'%' or sub_subject like '%'||p_key||'%' order by prmseq desc) q)
            ) where rn >= p_startNum
        ) where rn <= p_endNum;
end;



create or replace procedure getPromotionDetail_zen(
    p_prmseq in promotions.prmseq%type,
    p_cur1 out sys_refcursor,
    p_cur2 out sys_refcursor
)
is
begin
    open p_cur1 for
        select * from promotion_view where prmseq = p_prmseq;
    
    open p_cur2 for
        select p.*, pp.prmseq, pp.outnumber, pp.prmprice, pp.summary 
        from promotion_products pp, products p 
        where pp.prmseq = p_prmseq and p.pseq = pp.pseq order by pp.outnumber;
end;



create or replace procedure getSummary_zen(
    p_prmseq in promotion_products.prmseq%type,
    p_summary out sys_refcursor
)
is
begin
    open p_summary for
        select distinct outnumber, summary from promotion_products where prmseq = p_prmseq order by outnumber;
end;



-- 04/07
-- promotion
create or replace procedure updatePromotion_zen(
    p_prmseq in promotion_products.prmseq%type,
    p_banner in promotions.banner%type,
    p_main_subject in promotions.main_subject%type,
    p_sub_subject in promotions.sub_subject%type
)
is
begin
    update promotions set banner = p_banner, main_subject = p_main_subject, sub_subject = p_sub_subject where prmseq = p_prmseq;
    
    delete from promotion_products where prmseq = p_prmseq;
    commit;
end;



create or replace procedure changeLive_zen(
    p_apm varchar2,
    p_prmseq promotions.prmseq%type
)
is
begin
    update promotions set live = p_apm where prmseq = p_prmseq;
    commit;
end;



create or replace procedure getPromotionViewList_zen(

    p_cur out sys_refcursor
)
is
begin
    open p_cur for
        select * from promotions where live = 'main';
end;


create or replace procedure AllCountProduct_zen(
    p_cnt out number
)
is
    v_cnt number;
begin
    select count(*) into v_cnt from products;
    p_cnt := v_cnt;
end;


create or replace procedure productAll_zen(
    p_startNum in number,
    p_endNum in number,
    p_cur out sys_refcursor
)
is
begin
    open p_cur for
        select * from (
            select * from (
                select rownum as rn, p.* from
                    ((select * from products) p)
            ) where rn>=p_startNum
        ) where rn<=p_endNum;
end;


create or replace procedure getMainPromotionList_zen(
    p_cur out sys_refcursor
)
is
begin
    open p_cur for
        select * from promotions where live = 'main';
end;





-- 04/08

create or replace procedure getSearchCount_zen(
    p_key in varchar2,
    p_cnt out number
)
is
    v_cnt number;
begin
    select count(*) into v_cnt from products where name like '%'||p_key||'%';
    p_cnt := v_cnt;
end;


create or replace procedure getSearchProductList_zen(
    p_comm in varchar2,
    p_startNum in number,
    p_endNum in number,
    p_cur out sys_refcursor
)
is
begin
    open p_cur for
        select * from (
            select * from (
                select rownum as rn, p.* from
                    ((select * from products where name like '%'||p_comm||'%') p)
            ) where rn>=p_startNum
        ) where rn<=p_endNum;
end;


create or replace procedure insertCart_zen(
    p_id in orderss.id%type,
    p_pseq in orders_details.pseq%type,
    p_quan in orders_details.quantity%type,
    p_sellprice in orders_details.quantity%type
)
is
begin
    insert into carts(cseq, id, pseq, quantity, sellprice)
    values(carts_seq.nextVal, p_id, p_pseq, p_quan, p_sellprice);
    commit;
end;

select * from orders_details



CREATE OR REPLACE PROCEDURE insertOrderOne_zen(
   p_id IN orderss.id%TYPE,
   p_address IN orders_details.address%TYPE,
   p_zip_num IN orders_details.zip_num%TYPE,
   p_address2 IN orders_details.address2%TYPE,
   p_pseq IN orders_details.pseq %TYPE,
   p_quantity IN orders_details.quantity %TYPE,
   p_sellprice IN orders_details.sellprice %TYPE,
   p_oseq OUT orderss.oseq%TYPE
)
IS  
      v_oseq ORDERSS.oseq%TYPE;
BEGIN
        insert into orderss(oseq, id) values(orders_seq.nextVal, p_id);
        select MAX(oseq) into v_oseq from orderss;
        insert into orders_details(odseq, oseq, pseq, quantity,address,zip_num,address2,sellprice)
        values( orders_details_seq.nextVal, v_oseq, p_pseq, p_quantity,p_address,p_zip_num,p_address2,p_sellprice);
        COMMIT;
        p_oseq := v_oseq;
END;





CREATE OR REPLACE PROCEDURE insertOrder_zen(
    p_id IN orderss.id%TYPE,
    p_address IN orders_details.address%TYPE,
    p_zip_num IN orders_details.zip_num%TYPE,
    p_address2 IN orders_details.address2%TYPE,
    p_oseq out orderss.oseq%TYPE)
IS  
      v_oseq ORDERSS.oseq%TYPE;
      temp_cur SYS_REFCURSOR;
      v_cseq carts.cseq%TYPE;
      v_pseq carts.pseq%TYPE;
      v_quantity carts.quantity%TYPE;
      v_sellprice carts.sellprice%type;
BEGIN
      
        insert into orderss(oseq, id) values(orders_seq.nextVal, p_id);
       
        select MAX(oseq) into v_oseq from orderss;
    
        OPEN temp_cur FOR select cseq, pseq, quantity, sellprice from carts where id=p_id AND result='1';
       
        LOOP
            FETCH temp_cur INTO v_cseq, v_pseq, v_quantity, v_sellprice;
            EXIT WHEN temp_cur%NOTFOUND; 
            INSERT INTO orders_details ( odseq, oseq, pseq, quantity,address, zip_num, address2, sellprice) 
            VALUES( orders_details_seq.nextVal, v_oseq, v_pseq, v_quantity,p_address,p_zip_num,p_address2, v_sellprice);  
            DELETE FROM CARTS WHERE cseq = v_cseq;
        END LOOP;
        COMMIT;
    
        p_oseq := v_oseq;
END;

CREATE OR REPLACE PROCEDURE saveOptionMember_zen(
    p_id IN members.id%TYPE,
    p_black IN members.id%TYPE)
IS
BEGIN
    update members set useyn=p_black where id = p_id;
    commit;
END;


CREATE OR REPLACE PROCEDURE getEmail_zen(
    p_email IN members.email%TYPE, 
    p_curvar OUT SYS_REFCURSOR
)
IS
BEGIN
    OPEN p_curvar FOR SELECT * FROM members WHERE email=p_email;
END;

create or replace PROCEDURE insertMember_zen(
    p_id IN members.id%TYPE,
    p_pwd  IN members.pwd%TYPE,
    p_name  IN members.name%TYPE,
    p_email  IN members.email%TYPE,
    p_phone  IN members.phone%TYPE,
    p_zip_num IN members.zip_num%TYPE,
    p_address IN members.address%TYPE,
    p_address2 IN members.address2%TYPE )
IS
BEGIN
    insert into members(id, pwd, name, email, phone, zip_num, address,address2)
    values( p_id, p_pwd, p_name, p_email, p_phone, p_zip_num, p_address,p_address2 );
    commit;    
END;



select
    constraint_name,
    table_name,
    r_constraint_name
from
    user_constraints
where
    constraint_name = 'SYS_C007370';

select * from QNAS

CREATE OR REPLACE PROCEDURE insertProduct_zen(
    p_name IN products.name%TYPE,
    p_kind  IN products.kind%TYPE,
    p_price1  IN products.price1%TYPE,
    p_price2  IN products.price2%TYPE,
    p_content IN products.content%TYPE,
    p_image IN products.image%TYPE,
    p_detail_image IN products.detail_image%TYPE,
    p_newyn IN products.newyn%TYPE,
    p_bestyn IN products.bestyn%TYPE,
    p_pseq out number
)
IS
    v_pseq number;
BEGIN
    insert into products(pseq, name, kind, price1, price2, content, image, detail_image, newyn, bestyn) 
    values(products_seq.nextVal, p_name, p_kind, p_price1, p_price2, p_content, p_image, p_detail_image, p_newyn, p_bestyn);
    
    select max(pseq) into v_pseq from products;
    p_pseq := v_pseq;
    commit;
END;


create or replace procedure insertOption_zen(
    p_pseq in product_options.pseq%type,
    p_option1 in product_options.option1%type,
    p_option2 in product_options.option2%type,
    p_option3 in product_options.option3%type,
    p_changePrice in product_options.changePrice%type,
    p_sku in product_options.sku%type
)
is
begin
    insert into product_options(pseq, option1, option2, option3, changePrice, sku)
    values(p_pseq, p_option1, p_option2, p_option3, p_changePrice, p_sku);
    commit;
end;



create or replace procedure bestUpList_zen(
    p_key in varchar2,
    p_cnt out number
)
is
    v_cnt number;
begin
    select count(*) into v_cnt from products where bestyn='y';
    p_cnt := v_cnt;
end;


select * from products



create or replace procedure upBestList_zen(
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
                select rownum as rn, p.* from
                    ((select * from products where bestyn='y' order by price2) p)
            ) where rn>=p_startNum
        ) where rn<=p_endNum;
end;


select * from products where bestyn='y' order by price2 desc ; 

update products set bestyn='y' ;
commit;


create or replace procedure downBestList_zen(
    p_startNum in number,
    p_endNum in number,
    p_cur out sys_refcursor
)
is
begin
    open p_cur for
        select * from (
            select * from (
                select rownum as rn, p.* from
                    ((select * from products where bestyn='y' order by price2) p)
            ) where rn>=p_startNum
        ) where rn<=p_endNum;
end;


create or replace procedure upBestList_zen(
    p_startNum in number,
    p_endNum in number,
    p_cur out sys_refcursor
)
is
begin
    open p_cur for
        select * from (
            select * from (
                select rownum as rn, p.* from
                    ((select * from products where bestyn='y' order by price2 desc) p)
            ) where rn>=p_startNum
        ) where rn<=p_endNum;
end;

create or replace procedure allUpList_zen(
    p_startNum in number,
    p_endNum in number,
    p_cur out sys_refcursor
)
is
begin
    open p_cur for
        select * from (
            select * from (
                select rownum as rn, p.* from
                    ((select * from products order by price2 desc) p)
            ) where rn>=p_startNum
        ) where rn<=p_endNum;
end;


create or replace procedure allDownList_zen(
    p_startNum in number,
    p_endNum in number,
    p_cur out sys_refcursor
)
is
begin
    open p_cur for
        select * from (
            select * from (
                select rownum as rn, p.* from
                    ((select * from products order by price2 ) p)
            ) where rn>=p_startNum
        ) where rn<=p_endNum;
end;


create or replace procedure kindUpList_zen(
    p_comm in number,
    p_startNum in number,
    p_endNum in number,
    p_cur out sys_refcursor
)
is
begin
    open p_cur for
        select * from (
            select * from (
                select rownum as rn, p.* from
                    ((select * from products where kind = p_comm order by price2 desc ) p)
            ) where rn>=p_startNum
        ) where rn<=p_endNum;
end;

create or replace procedure kindDownList_zen(
    p_comm in number,
    p_startNum in number,
    p_endNum in number,
    p_cur out sys_refcursor
)
is
begin
    open p_cur for
        select * from (
            select * from (
                select rownum as rn, p.* from
                    ((select * from products where kind = p_comm order by price2 ) p)
            ) where rn>=p_startNum
        ) where rn<=p_endNum;
end;


