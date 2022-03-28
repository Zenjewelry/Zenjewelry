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