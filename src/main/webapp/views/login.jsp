<%--
  Created by IntelliJ IDEA.
  User: My
  Date: 2018/9/18
  Time: 14:46
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ include file="/common/globel.jsp"%>
<%--<%@include file="../narbar.jsp"%>--%>
<link href="<%=request.getContextPath()%>/resources/css/login.css" rel="stylesheet">
<link href="<%=request.getContextPath()%>/resources/css/rotation.css" rel="stylesheet" type="text/css">
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>图书管理系统</title>
    <meta name="description" content="particles.js is a lightweight JavaScript library for creating particles.">
    <meta name="author" content="Vincent Garreau"/>
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <script src="<%=request.getContextPath()%>/resources/js/rotation.js" type="text/javascript"></script>
</head>
<body>
<div class="content">
    <ul class="imgs">
        <li><img src="<%=request.getContextPath()%>/resources/imgs/1.jpg" width="720px" height="410px" /></li>
        <li><img src="<%=request.getContextPath()%>/resources/imgs/2.jpg" width="720px" height="410px" /></li>
        <li><img src="<%=request.getContextPath()%>/resources/imgs/3.jpg" width="720px" height="410px" /></li>
        <li><img src="<%=request.getContextPath()%>/resources/imgs/4.jpg" width="720px" height="410px" /></li>
    </ul>
    <div class="btn leftBtn"><</div>
    <div class="btn nextBtn">></div>
    <ul class="focusList">
        <li class="cur"></li>
        <li></li>
        <li></li>
        <li></li>
    </ul>
</div>
<div id="particles-js">
    <%--action="<%=request.getContextPath()%>/user/login" method="post"--%>
    <div class="container" style="position: absolute; left: 120px;">
        <form class="form-signin" id="loginForm">
            <h2 class="form-signin-heading">登录</h2>
            <div class="form-group">
                <input class="form-control" type="text" id ="userName" name="userName" placeholder="用户名"/>
            </div>
            <%--<h2 class="form-signin-heading">密码：</h2>--%>
            <div class="form-group">
                <input class="form-control" type="password" id ="passWord" name ="passWord" placeholder="密码"><br>
            </div>
            <div class="checkbox">
                <%--<label>--%>
                    <%--<input type="checkbox"  id="rememberMe" name="rememberMe" >记住我--%>
                <%--</label>--%>
                <%--<label>--%>
                    <%--<a href="<%=request.getContextPath()%>/user/forget">忘记密码</a>--%>
                <%--</label>--%>
                <button type = "button" id="submit" class="btn btn-primary btn-block">login</button><br>
            </div>
            <a href="<%=request.getContextPath()%>/user/register" class="btn btn-link">点击注册</a>
        </form>
    </div>
</div>

<script src="<%=request.getContextPath()%>/resources/js/login.js"></script>
<script type="text/javascript">
    $("#submit").click(function () {
        var  userName = $("#userName").val();
        var  password = $("#passWord").val();
        // var  rememberMe=$('#rememberMe').val();
        $.ajax({
            url: "<%=request.getContextPath()%>/user/login",
            type:"post",
            data:{"userName":userName,"password":password},
            dataType:"text",
            success : function(data) {
                console.log(data);
                // data = JSON.parse(data);
                // console.log(data.status);
                if(data=="success" ){
                    // <%--if(userEmail="admin@qq.com")--%>
                    location.href='${pageContext.request.contextPath}'+"/";
                    // <%--else--%>
                    //     <%--location.href = '${pageContext.request.contextPath}'+"/book/list?username="+username;--%>
                }
                else if(data=="error") {
                    //alert(data.msg);
                    alert("用户名或密码错误，请重新登录！");
                    //sweetAlert(data.msg);
                }
                else {
                    alert("用户名或密码不能为空，请重新登录！")
                }
            },
            error: function(data) {
                alert(JSON.stringify(data));
            }
        });
    })
</script>
<%--<!-- 背景JS -->--%>
<%--<script src="<%=request.getContextPath()%>/resources/js/background/particles.js"></script>--%>
<%--<script src="<%=request.getContextPath()%>/resources/js/background/app.js"></script>--%>
</body>
</html>