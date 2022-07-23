use `springmvc-news`;

insert into role(code,name) values('ADMIN','Admin');
insert into role(code,name) values('USER','User');

insert into user(username,password,fullname,status) 
values('admin','123456','Trần Tuy Hòa',1);
insert into user(username,password,fullname,status)
values('nguyenvana','123456','Nguyễn Văn A A',1);
insert into user(username,password,fullname,status)
values('nguyenvanb','123456','Nguyễn Văn B',1);

INSERT INTO user_role(user_id,role_id) VALUES (1,1);
INSERT INTO user_role(user_id,role_id) VALUES (2,2);
INSERT INTO user_role(user_id,role_id) VALUES (3,2);