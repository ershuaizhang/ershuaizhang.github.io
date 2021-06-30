<ul><a href="#" onclick="refreshDBConnectContent('mybatis')">返回</a></ul>

##MyBatis中#{}和${}的区别    			

	#{}：占位符号，好处防止sql注入 （替换结果会增加单引号‘’）
    ${}：sql拼接符号 不会转义字符串（替换结果不会增加单引号‘’，like和order by后使用，存在sql注入问题，需手动代码中过滤）
	示例1： 
	执行SQL：Select * from emp where name = #{employeeName} 
	参数：employeeName=>Smith 
	解析后执行的SQL：Select * from emp where name = ？ 
	执行SQL：Select * from emp where name = ${employeeName} 
	参数：employeeName传入值为：Smith 
	解析后执行的SQL：Select * from emp where name =Smith

