select * from products

update products set newyn='n';
update products set bestyn='n';

delete from products where name='상품옵션 테스트';
delete from products where name='목걸이';
delete from products where name='귀걸이';
delete from products where name='팔찌';

alter table products modify image varchar2(500);
alter table products modify detail_image varchar2(500);

update products set bestyn='y' where pseq=71;
update products set bestyn='y' where pseq=68;
update products set bestyn='y' where pseq=70;
update products set bestyn='y' where pseq=69;

select * from promotions
select * from boards

alter table boards modify title varchar2(100);

update boards set content='어떤지, 좀더 나은 착장방법이 있을지 댓글부탁드려요 !!' where num = 121;

select * from board_replys
delete from board_replys where reply_num = 25

select * from product_qna
update product_qna set rep=1;