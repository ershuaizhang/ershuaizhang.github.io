<p>
    <a href="#" onclick="refreshContent('oracle2')">返回 Oracle 2.0</a>
    
</p>

# Oracle 3.0
##同时插入多条数据
    Mysql：
    INSERT INTO users(name, age) VALUES('ccc', 333), ('aaa', 222), ('bbb', 111);
    Oracle：
    INSERT ALL INTO tb_red VALUES(1000, 8001, '2016-10-10 10:59:59', 1, 8001, '测试用户1000', '红名单0', '男', '膜法学院', '被测')
    INTO tb_red VALUES (1001, 8001, '2016-10-10 11:00:00', 2, 8001, '测试用户1001', '红名单1', '男', '膜法学院', '被测')
    INTO tb_red VALUES (1002, 8001, '2016-10-10 11:00:01', 0, 8001, '测试用户1002', '红名单2', '男', '膜法学院', '被测')
    INTO tb_red VALUES (1003, 8001, '2016-10-11 10:59:59', 1, 8001, '测试用户1003', '红名单3', '男', '膜法学院', '被测')
    INTO tb_red VALUES (1004, 8001, '2016-10-11 11:00:00', 2, 8001, '测试用户1004', '红名单4', '男', '膜法学院', '被测')
    INTO tb_red VALUES (1005, 8001, '2016-10-11 11:00:01', 0, 8001, '测试用户1005', '红名单5', '男', '膜法学院', '被测')
    select 1 from dual;
    
##什么情况下数据库索引会失效
    a、如果条件中有or，即使其中有条件带索引也不会使用(这也是为什么尽量少用or的原因)
        要想使用or，又想让索引生效，只能将or条件中的每个列都加上索引
    
    b、对于多列索引，不是使用的第一部分，则不会使用索引
    c、like查询是以%开头
    d、如果列类型是字符串，那一定要在条件中将数据使用引号引用起来,否则不使用索引
    
    e、在where子句中进行null值判断的话会导致引擎放弃索引而产生全表扫描
    f、避免在where子句中使用!= ,< >这样的符号,否则会导致引擎放弃索引而产生全表扫描
    g、避免在where子句中使用or来连接条件,因为如果俩个字段中有一个没有索引的话,引擎会放弃索引而产生全表扫描
    
    h、在使用联合索引是要注意最左原则
    
##分析sql 的关键字 
    explain + 语句

##连表查询
    外连接可分为：左连接、右连接、完全外连接。
        1、左连接  left join 或 left outer join
            SQL语句：select * from student left join course on student.ID=course.ID
            左外连接包含left join左表所有行，如果左表中某行在右表没有匹配，则结果中对应行右表的部分全部为空(NULL).

        2、右连接  right join 或 right outer join
            SQL语句：select * from student right join course on student.ID=course.ID
            右外连接包含right join右表所有行，如果左表中某行在右表没有匹配，则结果中对应左表的部分全部为空(NULL)。
        
        3、完全外连接  full join 或 full outer join
            SQL语句：select * from student full join course on student.ID=course.
            完全外连接包含full join左右两表中所有的行，如果右表中某行在左表中没有匹配，则结果中对应行右表的部分全部为空(NULL)，
            如果左表中某行在右表中没有匹配，则结果中对应行左表的部分全部为空(NULL)。
         
    内连接  join 或 inner join
        SQL语句：select * from student inner join course on student.ID=course.ID

        inner join 是比较运算符，只返回符合条件的行。
        此时相当于：select * from student,course where student.ID=course.ID     
    
    交叉连接 cross join
        1.概念：没有 WHERE 子句的交叉联接将产生连接所涉及的表的笛卡尔积。第一个表的行数乘以第二个表的行数等于笛卡尔积结果集的大小。
        SQL语句：select * from student cross join course
        
        如果我们在此时给这条SQL加上WHERE子句的时候比如SQL:select * from student cross join course where student.ID=course.ID
        此时将返回符合条件的结果集，结果和inner join所示执行结果一样
##伪列
    是Oracle中的一个列但是并不会存储在表中,伪列可以从表中查询,但不能插入,更新和删除就是不能进行操作
    rowid:存的是每一行的地址； 
    rownum:存的是每一列的id,代替limit进行每页查询的编写
<p>
    <a href="#" onclick="refreshContent('oracle2')">返回 Oracle 2.0</a>
</p>

#练习Demo： 
    https://blog.csdn.net/yelang0111/article/details/77435025
    
    declare
          num   number;
    begin
        select count(1) into num from all_all_tables where owner = UPPER('test_user') and table_name = UPPER('student'); 
        if num > 0 then
            execute immediate 'drop table test_user.student' ;
        end if;
    end;   
    
    上下不能同时执行  
           
    create table test_user.Student(
    Sno varchar2(7) primary key,
    Sname varchar2(10),
    Ssex varchar2(2),
    Sage  int,
    Dept varchar2(20) 
    ) tablespace MYUSER_SPACE;
    comment on column test_user.Student.Sname is '学号';
    comment on column test_user.Student.Sno is '姓名';
    comment on column test_user.Student.Ssex is '性别';
    comment on column test_user.Student.Sage is '年龄';
    comment on column test_user.Student.Dept is '所在系';  

    alter table test_user.Student add constraint CK_Sage check (Sage between 5 and 80);
    alter table test_user.Student add constraint CK_Ssex check (Ssex in ('男','女'));
    alter table test_user.Student modify Ssex varchar2(4);
    
        INSERT ALL INTO test_user.Student values('0811101','李勇','男',21,'计算机系')
        into  test_user.Student values('0811102','刘晨','男',20,'计算机系')
        into  test_user.Student values('0811103','王敏','女',20,'计算机系')
        into  test_user.Student values('0811104','张小红','女',19,'计算机系')   
        into  test_user.Student values('0821101','张立','男',21,'信息管理系')
        into  test_user.Student values('0821102','吴宾','女',19,'信息管理系')
        into  test_user.Student values('0821103','张海','男',20,'信息管理系')     
        into  test_user.Student values('0831101','钱小平','女',21,'通信工程系')
        into  test_user.Student values('0831102','王大力','男',21,'通信工程系')
        into  test_user.Student values('0831103','张姗姗','女',19,'通信工程系')
         select 1 from dual;
         commit ;
    
    drop table test_user.Course;
    create table test_user.Course(
    Cno varchar2(10) primary key,
    Cname  varchar2(20) not null,
    Credit int,
    Semester  int
    ) tablespace MYUSER_SPACE;
    comment on column test_user.Course.Cno is '课程号';
    comment on column test_user.Course.Cname is '课程名';
    comment on column test_user.Course.Credit is '学分';
    comment on column test_user.Course.Semester is '开课学期';  
    alter table test_user.Course add constraint CK_Credit check (Credit > 0);
    
    drop table test_user.Score;
    create table test_user.Score(
    Sno  varchar2(7),
    Cno  varchar2(10),
    Grade  int
    ) tablespace MYUSER_SPACE;
    
    comment on column test_user.Score.Sno is '学号';
    comment on column test_user.Score.Cno is '课程号';
    comment on column test_user.Score.Grade is '成绩';
    
    alter table test_user.Score add constraint FK_Sno foreign key(Sno) references test_user.Student(Sno);
    alter table test_user.Score add constraint FK_Cno foreign key(Cno) references test_user.Course(Cno);
    
    alter table test_user.Score add constraint CK_Grade check (Grade between 0 and 100);

