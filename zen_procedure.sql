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



CREATE OR REPLACE PROCEDURE getMember_zen(
    p_id IN members.id%TYPE, 
    p_curvar OUT SYS_REFCURSOR
)
IS
BEGIN
    OPEN p_curvar FOR SELECT * FROM member WHERE id=p_id;
END;


CREATE OR REPLACE PROCEDURE getAdminMember_zen(
    p_id IN workers.id%TYPE, 
    p_rc OUT SYS_REFCURSOR
)
IS
BEGIN
    OPEN p_rc FOR SELECT * FROM workers WHERE id=p_id;
END;














