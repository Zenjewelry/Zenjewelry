
CREATE TABLE members(
   id varchar2(20) NOT NULL ,   -- 회원 아이디
   pwd varchar2(20) NOT NULL,   -- 회원 비밀번호
   name varchar2(20) NOT NULL,   -- 회원 이름
   email varchar2(40) NOT NULL,   -- 회원 이메일
   zip_num varchar2(10) NOT NULL,   -- 회원 주소
   address varchar2(100) NOT NULL,   -- 
   phone varchar2(20) NOT NULL,   -- 회원 핸드폰번호
   indate date DEFAULT sysdate,   -- 가입일
   PRIMARY KEY (id)
);

select * from products;

DROP TABLE products;

CREATE TABLE products(
   pseq number(5) NOT NULL,
   name varchar2(100) NOT NULL,   -- 상품이름
   kind char(1) NOT NULL,   -- 상품 종류
   price1 number(7),   -- 원가
   price2 number(7),   -- 판매가
   content varchar2(1000),      -- 상품설명
   image varchar2(50),      -- 상품 이미지
   newyn char(1) DEFAULT 'n',     -- 신상품 진열 여부
   bestyn char(1) DEFAULT 'n',   -- 베스트상품 진열 여부
   indate date DEFAULT sysdate,    -- 등록일
   PRIMARY KEY (pseq)
); 

alter table products modify detail_image varchar2(500)

alter table products add detail_image varchar2(50);

drop sequence products_seq;
create sequence products_seq start with 41 increment by 1;

select * from products;

CREATE TABLE workers(
   id varchar2(20) NOT NULL,   -- 관리자 아이디
   pwd varchar2(20) NOT NULL,   -- 관리자 비밀번호
   name varchar2(20) NOT NULL,   -- 관리자 이름
   phone varchar2(20) NOT NULL, -- 관리자 핸드폰
   PRIMARY KEY (id)
);

update 

update products set kind=5  where pseq=9;

create table carts(
  cseq         number(10)    primary key,  -- 장바구니 일련번호
  id             varchar2(16)   references members(id),   -- 주문자 아이디(FK :　member.id) 
  pseq        number(5)     references products(pseq),  -- 주문 상품번호(FK :product.pseq) 
  quantity   number(5)     default 1,        -- 주문 수량
  result       char(1)       default '1',      -- 1:미처리(카트에 담김 상태, 주문전)   2:처리(주문완료)
  indate       date          default SYSDATE   -- 장바구니에 담은 날짜
);

drop sequence carts_seq;
create sequence carts_seq start with 1;


create table orderss(
  oseq        number(10)    primary key,           -- 주문번호  
  id          varchar2(20)   references members(id), -- 주문자 아이디
  indate      date          default  sysdate       -- 주문일
);

drop sequence orders_seq;
create sequence orders_seq start with 1;


select * from orders_details;

create table orders_details(
  odseq       number(10)   primary key,        -- 주문상세번호
  oseq        number(10)   references orderss(oseq),   -- orders 테이블에 추가된 주문번호  
  pseq        number(5)    references products(pseq),  -- 상품번호
  quantity    number(5)    default 1,                 -- 주문수량
  result      char(1)      default '1'                -- 1: 미처리 2: 처리     
);

drop sequence orders_details_seq;
create sequence orders_details_seq start with 1;


CREATE TABLE address (
       zip_num              VARCHAR2(7) NOT NULL,
       sido                 VARCHAR2(30) NOT NULL,
       gugun                VARCHAR2(30) NOT NULL,
       dong                 VARCHAR2(100) NOT NULL,
       zip_code             VARCHAR2(30) ,
       bunji                VARCHAR2(30) 
);

select * from address;

create table qnas (
  qseq        number(5)    primary key,  -- 글번호 
  subject     varchar2(300),            -- 제목
  content     varchar2(1000),          -- 문의내용
  reply       varchar2(1000),           -- 답변내용
  id          varchar2(20) references members(id),                 -- 작성자(FK : member.id) 
  rep         char(1)       default '1',        --1:답변 무  2:답변 유  
  indate      date default  sysdate     -- 작성일
); 

drop sequence qna_seq;
create sequence qna_seq start with 1;


create table reviews (
  oseq  number(5) references orderss(oseq),   -- 리뷰 주문번호
  odseq number(5) references orders_details(odseq),   -- 리뷰 주문상세번호
  id    varchar2(20) references members(id),   -- 리뷰 아이디
  pseq   number(5) references products(pseq),   -- 리뷰 상품
  subject varchar2(300),   -- 리뷰 제목
  content varchar2(1000),   -- 리뷰 내용
  image   varchar2(50)   -- 리뷰 이미지
);



select * from reviews


-- cart 안의 상품번호와 사용자 아이디로  상품이름과 사용자 이름을 함께 조회하는  view
create or replace view cart_views
as
select c.cseq, c.id, m.name as mname, c.pseq, p.name as pname, c.quantity, p.price2, c.result, c.indate
from carts c, products p, members m
where c.pseq = p.pseq and c.id = m.id;

-- orders 와 order_detail 의 join 으로 
-- 1. 주문번호(oseq)에 따른 주문상품들의 표시 
-- 2. 상품번호에 따른 상품 이름과 가격 등의 정보 표시
-- 3. 아이디에 따른 고객 이름과 배송주소 등의 정보 표시
create or replace view order_views
as
select d.odseq, o.oseq, o.indate,  o.id, 
         m.name as mname, m.zip_num, m.address, m.phone, m.address2,
         d.pseq,  p.name as pname, p.price2, d.quantity, d.result
from orderss o, orders_details d, members m, products p
where o.oseq=d.oseq and o.id=m.id and d.pseq=p.pseq;

select * from order_views;

create or replace view delivery_views
as
select m.name as mname, m.zip_num, m.address, m.phone, 
		o.id
from members m, orderss o
where o.id=m.id

select * from delivery_views


-- 신상품 view
create or replace view new_pro_views
as
select * from
( select rownum, pseq, name, price2, image 
from products
where newyn='y'
order by indate desc )
where rownum <= 4; -- 보여줄 신상품 수 

-- 베스트상품 view
create or replace view best_pro_views
as
select * from
(select rownum, pseq, name, price2, image 
from products
where bestyn='y'  
order by indate desc) 
where  rownum <= 4; -- 보여줄 베스트상품 수


insert into products(pseq, name, kind, price1, price2, content, image, detail_image) 
values(product_seq.nextval, '라자르102 목걸이', '1', 400000, 500000, '메탈 하나로도 포인트를 줄 수 있는 아이템입니다.
오피스 룩이나 캐주얼 룩에 잘 어울려 감각적이고, 데일리하게 착용이 가능한 제품입니다.', 'abc.jpeg','abc_d.jpeg' );

-- 관리자
insert into workers values('admin', 'admin', '관리자', '010-1111-2222');
insert into workers values('scott', 'tiger', '홍길동', '010-6400-6068');


-- 회원
insert into members(id, pwd, name, zip_num, address, phone, email) values
('one', '1111', '김나리', '133-110', '서울시 성동구 성수동1가 1번지21호', '011-1111-1111','acc@abc.com');
insert into members(id, pwd, name, zip_num, address, phone, email)values
('two', '2222', '김길동', '130-120', '서울시 송파구 잠실2동 리센츠 아파트 222동 222호', '022-222-2222','acc@abc.com');
insert into members(id, pwd, name, zip_num, address, phone, email) values
('three', '3333', '김나리', '133-110', '서울시 성동구 성수동1가 3번지3호', '033-333-3333','acc@abc.com');
insert into members(id, pwd, name, zip_num, address, phone, email)values
('four', '4444', '김길동', '130-120', '서울시 송파구 잠실2동 리센츠 아파트 444동 444호', '044-444-4444','acc@abc.com');


-- 상품
insert into products(pseq, name, kind, price1, price2, content, image) 
values(products_seq.nextval, '반지', '1', 40000, 50000,  '삐까뻔쩍 반지입니다.', 'ring1.jpg');
insert into products(pseq, name, kind, price1, price2, content, image) 
values(products_seq.nextval, '반지', '1', 35000, 45000,  '삐까 반지입니다.', 'ring2.jpg');
insert into products(pseq, name, kind, price1, price2, content, image) 
values(products_seq.nextval, '반지', '1', 30000, 40000,  '뻔쩍 반지입니다.', 'ring3.jpg');
insert into products(pseq, name, kind, price1, price2, content, image) 
values(products_seq.nextval, '반지', '1', 25000, 35000,  '반지입니다.', 'ring4.jpg');
insert into products(pseq, name, kind, price1, price2, content, image) 
values(products_seq.nextval, '반지', '1', 20000, 30000,  '반반지입니다.', 'ring5.jpg');
insert into products(pseq, name, kind, price1, price2, content, image, bestyn) 
values(products_seq.nextval, '목걸이', '2', 40000, 50000,'삐까뻔쩍 목걸이입니다.', 'necklace1.jpg', 'n');
insert into products(pseq,  name, kind, price1, price2, content, image, bestyn) 
values(products_seq.nextval, '귀걸이', '3', 10000, 12000, '삐까뻔쩍 귀걸이입니다', 'earring1.jpg', 'n');
insert into products(pseq,  name, kind, price1, price2, content, image, bestyn)
values(products_seq.nextval, '팔찌', '4', 5000, 5500, '팔에걸면 팔찌 발에걸먼 발찌입니다', 'bracelet1.jpg', 'y');


-- 카트 추가
insert into carts(cseq,id, pseq, quantity) values(carts_seq.nextval, 'one', 1, 1);   -- id:one 사용자가 1번 상품 1개를 카트에 추가
insert into carts(cseq,id, pseq, quantity) values(carts_seq.nextval, 'two', 2, 1);


-- orders 와 order_detail 추가
insert into orderss( oseq, id) values(orders_seq.nextVal, 'one');
insert into orders_details(odseq, oseq, pseq, quantity) values(orders_details_seq.nextval, 1, 1, 1);
insert into orders_details(odseq, oseq, pseq, quantity) values(orders_details_seq.nextval, 1, 2, 2);
insert into orderss(oseq, id) values(orders_seq.nextval, 'two');
insert into orders_details(odseq, oseq, pseq, quantity) values(orders_details_seq.nextval, 2, 4, 3);


-- Q&A
insert into qnas (qseq, subject, content, id) 
values(qna_seq.nextval, '배송관련 문의입니다', '현재 배송상태와 예상 배송일을 답변 부탁합니다', 'one');
insert into qnas (qseq, subject, content, id) 
values(qna_seq.nextval, '환불관련', '환불절차 안내부탁드려요.... 배송사 선택은 어떻게 되는지도...', 'two');
insert into qnas (qseq, subject, content, id) 
values(qna_seq.nextval, '사이즈 교환 하고 싶어요', '사이즈가 예상보다 작습니다. 교환절차를 안내부탁드려요', 'three');
insert into qnas (qseq, subject, content, id) 
values(qna_seq.nextval, '배송이 많이 지연되고 있습니다', '언제 받을 수 있나요', 'four');
insert into qnas (qseq, subject, content, id) 
values(qna_seq.nextval, '불량품 교환 문의', '교환 또는 환불 등의 안내가 필요합니다. 유선안내부탁드려요', 'one')

create table product_qna(
	qna_num number(7),
	id varchar2(20) references members(id) ,   -- 회원 아이디  -- 작성자(FK : member.id)
	pwd varchar2(20)  ,   -- qna 비밀번호
	pseq number(5) references products(pseq), -- 제품 번호
	subject     varchar2(300),            -- 제목
	content     varchar2(1000),          -- 문의내용
	reply       varchar2(1000),           -- 답변내용
	rep         char(1)       default '1',        --1:답변 무  2:답변 유  
	indate      date default  sysdate     -- 작성일
);

select* from product_qna

create sequence qna_num_seq start with 1 increment by 1;






drop table boards purge;

create table boards(
	num number(5) primary key,
	userid varchar2(30),
	title varchar2(50),
	content varchar2(1000),
	pictureurl varchar2(50),
	readcount number(4) default 0,		-- 조회수
	writedate date default sysdate		-- 작성일자
);

drop sequence boards_seq
create sequence boards_seq start with 1 increment by 1;

create table board_replys(
	reply_num number(7) primary key,		-- 댓글 순번
	boardnum number(5),							-- 댓글의 해당 게시물 번호
	userid varchar2(20),								-- 댓글 쓰니
	writedate date default sysdate,				-- 작성일
	content varchar2(1000)							-- 작성 내용
);

create sequence board_replys_seq start with 1 increment by 1;

select * from boards
select * from board_replys

insert into board_replys(reply_num, boardnum, userid, content) values(board_replys_seq.nextVal, 8, 'jinwoo', 'test1');
insert into board_replys(reply_num, boardnum, userid, content) values(board_replys_seq.nextVal, 8, 'jinwoo', 'test2');
insert into board_replys(reply_num, boardnum, userid, content) values(board_replys_seq.nextVal, 8, 'jinwoo', 'test3');
insert into board_replys(reply_num, boardnum, userid, content) values(board_replys_seq.nextVal, 8, 'jinwoo', 'test4');
insert into board_replys(reply_num, boardnum, userid, content) values(board_replys_seq.nextVal, 8, 'jinwoo', 'test5');
insert into board_replys(reply_num, boardnum, userid, content) values(board_replys_seq.nextVal, 8, 'jinwoo', 'test6');



select rownum as rn, br.* from ((select * from board_replys where boardnum = 8) br) order by rn desc

select * from (select * from (select rownum as rn, m.* from((select * from order_view order by result, odseq desc) m)) where rn>=?) where rn<=?";



select count(*) as cnt from board_replys where boardnum=1;

alter table boards add replycount number(4) default 0;		-- 댓글 수




insert into boards(num, userid, title, content) values(boards_seq.nextVal, 'one', 'test0', 'testtesttest');
insert into boards(num, userid, title, content) values(boards_seq.nextVal, 'two', 'test2', 'testtesttest');
insert into boards(num, userid, title, content) values(boards_seq.nextVal, 'three', 'test3', 'testtesttest');
insert into boards(num, userid, title, content) values(boards_seq.nextVal, 'four', 'test4', 'testtesttest');
insert into boards(num, userid, title, content) values(boards_seq.nextVal, 'one', 'test5', 'testtesttest');
insert into boards(num, userid, title, content) values(boards_seq.nextVal, 'three', 'test6', 'testtesttest');
insert into boards(num, userid, title, content) values(boards_seq.nextVal, 'one', 'test7', 'testtesttest');
insert into boards(num, userid, title, content) values(boards_seq.nextVal, 'three', 'test8', 'testtesttest');
insert into boards(num, userid, title, content) values(boards_seq.nextVal, 'two', 'test9', 'testtesttest');
insert into boards(num, userid, title, content) values(boards_seq.nextVal, 'one', 'test10', 'testtesttest');
insert into boards(num, userid, title, content) values(boards_seq.nextVal, 'two', 'test11', 'testtesttest');
insert into boards(num, userid, title, content) values(boards_seq.nextVal, 'four', 'test12', 'testtesttest');
insert into boards(num, userid, title, content) values(boards_seq.nextVal, 'one', 'test13', 'testtesttest');
insert into boards(num, userid, title, content) values(boards_seq.nextVal, 'two', 'test14', 'testtesttest');
insert into boards(num, userid, title, content) values(boards_seq.nextVal, 'four', 'test15', 'testtesttest');
insert into boards(num, userid, title, content) values(boards_seq.nextVal, 'one', 'test16', 'testtesttest');
insert into boards(num, userid, title, content) values(boards_seq.nextVal, 'three', 'test17', 'testtesttest');
insert into boards(num, userid, title, content) values(boards_seq.nextVal, 'three', 'test18', 'testtesttest');
insert into boards(num, userid, title, content) values(boards_seq.nextVal, 'one', 'test19', 'testtesttest');
insert into boards(num, userid, title, content) values(boards_seq.nextVal, 'four', 'test20', 'testtesttest');
insert into boards(num, userid, title, content) values(boards_seq.nextVal, 'one', 'test0', 'testtesttest');
insert into boards(num, userid, title, content) values(boards_seq.nextVal, 'two', 'test2', 'testtesttest');
insert into boards(num, userid, title, content) values(boards_seq.nextVal, 'three', 'test3', 'testtesttest');
insert into boards(num, userid, title, content) values(boards_seq.nextVal, 'four', 'test4', 'testtesttest');
insert into boards(num, userid, title, content) values(boards_seq.nextVal, 'one', 'test5', 'testtesttest');
insert into boards(num, userid, title, content) values(boards_seq.nextVal, 'three', 'test6', 'testtesttest');
insert into boards(num, userid, title, content) values(boards_seq.nextVal, 'one', 'test7', 'testtesttest');
insert into boards(num, userid, title, content) values(boards_seq.nextVal, 'three', 'test8', 'testtesttest');
insert into boards(num, userid, title, content) values(boards_seq.nextVal, 'two', 'test9', 'testtesttest');
insert into boards(num, userid, title, content) values(boards_seq.nextVal, 'one', 'test10', 'testtesttest');
insert into boards(num, userid, title, content) values(boards_seq.nextVal, 'two', 'test11', 'testtesttest');
insert into boards(num, userid, title, content) values(boards_seq.nextVal, 'four', 'test12', 'testtesttest');
insert into boards(num, userid, title, content) values(boards_seq.nextVal, 'one', 'test13', 'testtesttest');
insert into boards(num, userid, title, content) values(boards_seq.nextVal, 'two', 'test14', 'testtesttest');
insert into boards(num, userid, title, content) values(boards_seq.nextVal, 'four', 'test15', 'testtesttest');
insert into boards(num, userid, title, content) values(boards_seq.nextVal, 'one', 'test16', 'testtesttest');
insert into boards(num, userid, title, content) values(boards_seq.nextVal, 'three', 'test17', 'testtesttest');
insert into boards(num, userid, title, content) values(boards_seq.nextVal, 'three', 'test18', 'testtesttest');
insert into boards(num, userid, title, content) values(boards_seq.nextVal, 'one', 'test19', 'testtesttest');
insert into boards(num, userid, title, content) values(boards_seq.nextVal, 'four', 'test20', 'testtesttest');
insert into boards(num, userid, title, content) values(boards_seq.nextVal, 'one', 'test0', 'testtesttest');
insert into boards(num, userid, title, content) values(boards_seq.nextVal, 'two', 'test2', 'testtesttest');
insert into boards(num, userid, title, content) values(boards_seq.nextVal, 'three', 'test3', 'testtesttest');
insert into boards(num, userid, title, content) values(boards_seq.nextVal, 'four', 'test4', 'testtesttest');
insert into boards(num, userid, title, content) values(boards_seq.nextVal, 'one', 'test5', 'testtesttest');
insert into boards(num, userid, title, content) values(boards_seq.nextVal, 'three', 'test6', 'testtesttest');
insert into boards(num, userid, title, content) values(boards_seq.nextVal, 'one', 'test7', 'testtesttest');
insert into boards(num, userid, title, content) values(boards_seq.nextVal, 'three', 'test8', 'testtesttest');
insert into boards(num, userid, title, content) values(boards_seq.nextVal, 'two', 'test9', 'testtesttest');
insert into boards(num, userid, title, content) values(boards_seq.nextVal, 'one', 'test10', 'testtesttest');
insert into boards(num, userid, title, content) values(boards_seq.nextVal, 'two', 'test11', 'testtesttest');
insert into boards(num, userid, title, content) values(boards_seq.nextVal, 'four', 'test12', 'testtesttest');
insert into boards(num, userid, title, content) values(boards_seq.nextVal, 'one', 'test13', 'testtesttest');
insert into boards(num, userid, title, content) values(boards_seq.nextVal, 'two', 'test14', 'testtesttest');
insert into boards(num, userid, title, content) values(boards_seq.nextVal, 'four', 'test15', 'testtesttest');
insert into boards(num, userid, title, content) values(boards_seq.nextVal, 'one', 'test16', 'testtesttest');
insert into boards(num, userid, title, content) values(boards_seq.nextVal, 'three', 'test17', 'testtesttest');
insert into boards(num, userid, title, content) values(boards_seq.nextVal, 'three', 'test18', 'testtesttest');
insert into boards(num, userid, title, content) values(boards_seq.nextVal, 'one', 'test19', 'testtesttest');
insert into boards(num, userid, title, content) values(boards_seq.nextVal, 'four', 'test20', 'testtesttest');
insert into boards(num, userid, title, content) values(boards_seq.nextVal, 'one', 'test0', 'testtesttest');
insert into boards(num, userid, title, content) values(boards_seq.nextVal, 'two', 'test2', 'testtesttest');
insert into boards(num, userid, title, content) values(boards_seq.nextVal, 'three', 'test3', 'testtesttest');
insert into boards(num, userid, title, content) values(boards_seq.nextVal, 'four', 'test4', 'testtesttest');
insert into boards(num, userid, title, content) values(boards_seq.nextVal, 'one', 'test5', 'testtesttest');
insert into boards(num, userid, title, content) values(boards_seq.nextVal, 'three', 'test6', 'testtesttest');
insert into boards(num, userid, title, content) values(boards_seq.nextVal, 'one', 'test7', 'testtesttest');
insert into boards(num, userid, title, content) values(boards_seq.nextVal, 'three', 'test8', 'testtesttest');
insert into boards(num, userid, title, content) values(boards_seq.nextVal, 'two', 'test9', 'testtesttest');
insert into boards(num, userid, title, content) values(boards_seq.nextVal, 'one', 'test10', 'testtesttest');
insert into boards(num, userid, title, content) values(boards_seq.nextVal, 'two', 'test11', 'testtesttest');
insert into boards(num, userid, title, content) values(boards_seq.nextVal, 'four', 'test12', 'testtesttest');
insert into boards(num, userid, title, content) values(boards_seq.nextVal, 'one', 'test13', 'testtesttest');
insert into boards(num, userid, title, content) values(boards_seq.nextVal, 'two', 'test14', 'testtesttest');
insert into boards(num, userid, title, content) values(boards_seq.nextVal, 'four', 'test15', 'testtesttest');
insert into boards(num, userid, title, content) values(boards_seq.nextVal, 'one', 'test16', 'testtesttest');
insert into boards(num, userid, title, content) values(boards_seq.nextVal, 'three', 'test17', 'testtesttest');
insert into boards(num, userid, title, content) values(boards_seq.nextVal, 'three', 'test18', 'testtesttest');
insert into boards(num, userid, title, content) values(boards_seq.nextVal, 'one', 'test19', 'testtesttest');
insert into boards(num, userid, title, content) values(boards_seq.nextVal, 'four', 'test20', 'testtesttest');
insert into boards(num, userid, title, content) values(boards_seq.nextVal, 'one', 'test0', 'testtesttest');
insert into boards(num, userid, title, content) values(boards_seq.nextVal, 'two', 'test2', 'testtesttest');
insert into boards(num, userid, title, content) values(boards_seq.nextVal, 'three', 'test3', 'testtesttest');
insert into boards(num, userid, title, content) values(boards_seq.nextVal, 'four', 'test4', 'testtesttest');
insert into boards(num, userid, title, content) values(boards_seq.nextVal, 'one', 'test5', 'testtesttest');
insert into boards(num, userid, title, content) values(boards_seq.nextVal, 'three', 'test6', 'testtesttest');
insert into boards(num, userid, title, content) values(boards_seq.nextVal, 'one', 'test7', 'testtesttest');
insert into boards(num, userid, title, content) values(boards_seq.nextVal, 'three', 'test8', 'testtesttest');
insert into boards(num, userid, title, content) values(boards_seq.nextVal, 'two', 'test9', 'testtesttest');
insert into boards(num, userid, title, content) values(boards_seq.nextVal, 'one', 'test10', 'testtesttest');
insert into boards(num, userid, title, content) values(boards_seq.nextVal, 'two', 'test11', 'testtesttest');
insert into boards(num, userid, title, content) values(boards_seq.nextVal, 'four', 'test12', 'testtesttest');
insert into boards(num, userid, title, content) values(boards_seq.nextVal, 'one', 'test13', 'testtesttest');
insert into boards(num, userid, title, content) values(boards_seq.nextVal, 'two', 'test14', 'testtesttest');
insert into boards(num, userid, title, content) values(boards_seq.nextVal, 'four', 'test15', 'testtesttest');
insert into boards(num, userid, title, content) values(boards_seq.nextVal, 'one', 'test16', 'testtesttest');
insert into boards(num, userid, title, content) values(boards_seq.nextVal, 'three', 'test17', 'testtesttest');
insert into boards(num, userid, title, content) values(boards_seq.nextVal, 'three', 'test18', 'testtesttest');
insert into boards(num, userid, title, content) values(boards_seq.nextVal, 'one', 'test19', 'testtesttest');
insert into boards(num, userid, title, content) values(boards_seq.nextVal, 'four', 'test20', 'testtesttest');
insert into boards(num, userid, title, content) values(boards_seq.nextVal, 'one', 'test0', 'testtesttest');
insert into boards(num, userid, title, content) values(boards_seq.nextVal, 'two', 'test2', 'testtesttest');
insert into boards(num, userid, title, content) values(boards_seq.nextVal, 'three', 'test3', 'testtesttest');
insert into boards(num, userid, title, content) values(boards_seq.nextVal, 'four', 'test4', 'testtesttest');
insert into boards(num, userid, title, content) values(boards_seq.nextVal, 'one', 'test5', 'testtesttest');
insert into boards(num, userid, title, content) values(boards_seq.nextVal, 'three', 'test6', 'testtesttest');
insert into boards(num, userid, title, content) values(boards_seq.nextVal, 'one', 'test7', 'testtesttest');
insert into boards(num, userid, title, content) values(boards_seq.nextVal, 'three', 'test8', 'testtesttest');
insert into boards(num, userid, title, content) values(boards_seq.nextVal, 'two', 'test9', 'testtesttest');
insert into boards(num, userid, title, content) values(boards_seq.nextVal, 'one', 'test10', 'testtesttest');
insert into boards(num, userid, title, content) values(boards_seq.nextVal, 'two', 'test11', 'testtesttest');
insert into boards(num, userid, title, content) values(boards_seq.nextVal, 'four', 'test12', 'testtesttest');
insert into boards(num, userid, title, content) values(boards_seq.nextVal, 'one', 'test13', 'testtesttest');
insert into boards(num, userid, title, content) values(boards_seq.nextVal, 'two', 'test14', 'testtesttest');
insert into boards(num, userid, title, content) values(boards_seq.nextVal, 'four', 'test15', 'testtesttest');
insert into boards(num, userid, title, content) values(boards_seq.nextVal, 'one', 'test16', 'testtesttest');
insert into boards(num, userid, title, content) values(boards_seq.nextVal, 'three', 'test17', 'testtesttest');
insert into boards(num, userid, title, content) values(boards_seq.nextVal, 'three', 'test18', 'testtesttest');
insert into boards(num, userid, title, content) values(boards_seq.nextVal, 'one', 'test19', 'testtesttest');
insert into boards(num, userid, title, content) values(boards_seq.nextVal, 'four', 'test20', 'testtesttest');





select rownum as rn, br.* from ((select * from board_replys where boardnum = 8) br) order by rn desc

select * from (select * from (select rownum as rn, m.* from((select * from order_view order by result, odseq desc) m)) where rn>=?) where rn<=?";

alter table orders_details add address varchar2(500);
alter table orders_details add zip_num varchar2(7);

drop view order_views;

create or replace view order_views
as
select d.odseq, o.oseq, o.indate,  o.id, 
         m.name as mname, m.zip_num, m.address, m.phone, 
         d.pseq,  p.name as pname, p.price2, d.quantity, d.result
from orderss o, orders_details d, members m, products p
where o.oseq=d.oseq and o.id=m.id and d.pseq=p.pseq;
select * from orders_details

select * from members;

select * from products
delete from products where pseq=24

insert into products(pseq, name, kind, price1, price2, content, image, detail_image) 
values(product_seq.nextval, '14K/18K 인어공주 목걸이 N17-43', '2', 250000, 380000,  '14K/18K 인어공주 목걸이', 'n1.jpg', 'ni1.jpg');

update products set name='알록달록 예쁜 팔찌' where pseq=4;

insert into products(pseq, name, kind, price1, price2, content, image, detail_image) 
values(product_seq.nextval, '14K/18K 발키리 반지 R11-33', '1', 600000, 722000,  '14K/18K 발키리 반지 R11-33', 'r1.jpg', 'ri1.jpg');

select * from products
delete from products where pseq=42

update products set newyn='y';
update products set bestyn='y';


select * from orders_details;


SELECT * FROM BOARDS

select * from board_replys

select * from (
            select * from (
                select rownum as rn, b.* from
                   ((select * from boards where title like '%'||''||'%') b)
            ) where rn>=1
        ) where rn<=100;
delete from boards

select * from boards

--------- 수정 --------------
select * from products
alter table members add address2 varchar(100);

alter table orders_details add zip_num varchar(100);
alter table orders_details add address varchar(100);
alter table orders_details add address2 varchar(100);

select * from orders_details

-- address2 때문에 수정
create or replace view order_views
as
select d.odseq, o.oseq, o.indate,  o.id, 
         m.name as mname, d.zip_num, d.address, m.phone, d.address2,
         d.pseq,  p.name as pname, p.price2, d.quantity, d.result
from orderss o, orders_details d, members m, products p
where o.oseq=d.oseq and o.id=m.id and d.pseq=p.pseq;



--------------3/31

select * from board_replys;

select * from products;
select * from order_views;

-- address, zip_num, image 수정 

create or replace view order_views
as
select d.odseq, o.oseq, o.indate,  o.id, 
         m.name as mname, d.zip_num, d.address, m.phone, d.address2,
         d.pseq,  p.name as pname, p.price2, d.quantity, d.result , p.image
from orderss o, orders_details d, members m, products p
where o.oseq=d.oseq and o.id=m.id and d.pseq=p.pseq;


-- image 수정
create or replace view cart_views
as
select c.cseq, c.id, m.name as mname, c.pseq, p.name as pname, c.quantity, p.price2, c.result, c.indate, p.image
from carts c, products p, members m
where c.pseq = p.pseq and c.id = m.id;



select * from qnas where subject like '%'||'다'||'%' or content like '%'||'다'||'%';




-- members useyn
-- useyn - 1: 사용 2: 휴먼 3: 블랙 4:일시정지
-- blockDate - 정지 종료일
alter table members add useyn varchar2(10);
alter table members add blockDate date;
alter table members add grade varchar2(100);

select * from members;

-- 기획전 DB
create table promotions(
	prmseq number(10) not null,
	banner varchar(50) not null,
	main_subject varchar(50) not null,
	sub_subject varchar(50),
	sdate date,
	edate date,
	primary key(prmseq)
);

create table promotion_products(
	prmseq number(10) not null,
	outnumber number(10) not null,
	summary varchar2(50),
	pseq number(5) not null,
	prmprice number(10) not null
);

alter table promotion_products add prmprice number(10) not null;
alter table promotions add live varchar(10) default 'none';

create or replace view promotion_view
as
select p.prmseq, p.banner, p.main_subject, p.sub_subject, p.sdate, p.edate
from promotions p, promotion_products ps 
where p.prmseq = ps.prmseq;

create sequence promotions_seq start with 1 increment by 1;






-- members update
alter table members add useyn varchar2(10) default 'y' not null;
alter table members add grade varchar2(10);
alter table members drop column useyn;



-- cart_views 수정
alter table carts add sellprice number(10);

create or replace view cart_views
as
select c.cseq, c.id, m.name as mname, c.pseq, p.name as pname, c.quantity, c.sellprice, c.result, c.indate, p.image
from carts c, products p, members m
where c.pseq = p.pseq and c.id = m.id;

delete from carts 



select * from products;


-- order_derails 수정 
alter table orders_details add sellprice number(10);

-- order_views 수정3 
create or replace view order_views
as
select d.odseq, o.oseq, o.indate,  o.id, 
         m.name as mname, d.zip_num, d.address, m.phone, d.address2,
         d.pseq,  p.name as pname, d.sellprice, d.quantity, d.result , p.image
from orderss o, orders_details d, members m, products p
where o.oseq=d.oseq and o.id=m.id and d.pseq=p.pseq;


-- 상품 옵션테이블 업데이트
create table product_options(
	pseq number(10),
	option1 varchar2(50),	-- 순도
	option2 varchar2(50),	-- 사이즈
	option3 varchar2(50),	-- 색상
	sku number(10) default 10,
	changePrice number(10) default 0
);

select * from products
select * from product_options;


-- carts 옵션 추가

alter table carts add option1 varchar2(50);
alter table carts add option2 varchar2(50);
alter table carts add option3 varchar2(50);

create or replace view cart_views
as
select c.cseq, c.id, m.name as mname, c.pseq, p.name as pname, c.quantity, c.sellprice, c.result, c.indate, c.option1, c.option2, c.option3, p.image
from carts c, products p, members m
where c.pseq = p.pseq and c.id = m.id;



-- order 옵션 추가
alter table orders_details add option1 varchar2(50);
alter table orders_details add option2 varchar2(50);
alter table orders_details add option3 varchar2(50);

create or replace view order_views
as
select d.odseq, o.oseq, o.indate,  o.id, 
         m.name as mname, d.zip_num, d.address, m.phone, d.address2,
         d.pseq,  p.name as pname, d.sellprice, d.quantity, d.result , p.image, d.option1, d.option2, d.option3
from orderss o, orders_details d, members m, products p
where o.oseq=d.oseq and o.id=m.id and d.pseq=p.pseq;


select * from orders_details
select * from members

update members set useyn='사용'


-- 04/11 image 수정
create or replace view cart_views
as
select c.cseq, c.id, m.name as mname, c.pseq, p.name as pname, c.quantity, c.sellprice, c.result, c.indate, c.option1, c.option2, c.option3, p.image
from carts c, products p, members m
where c.pseq = p.pseq and c.id = m.id;