<%--
  Created by IntelliJ IDEA.
  User: Think
  Date: 2019/7/5
  Time: 9:26
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<%@ page isELIgnored="false" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@include file="/common/globel.jsp"%>
<%@include file="/views/index.jsp"%>
<html>
<head>
    <title>Title</title>
    <style type="text/css">
        .test{
            position: absolute;
            bottom: 30px;
            left: 500px;
        }
    </style>
</head>
<body>
<div class="container">
    <div class="table-responsive">
        <table border="1" align="center" class="table table-striped table-bordered  table-hover">
            <thead>
            <tr>
                <th align="center">user_id</th>
                <th align="center">用户名</th>
                <th align="center">图书编号</th>
                <th align="center">书名</th>
                <th align="center">预约时间</th>
                <th align="center">取消预约</th>
                <th align="center" ><a class="appoint btn btn-danger" onclick="getappointment(this)"> 获取预约列表</a></th>
<%--                <c:choose>--%>
<%--                    <c:when test="${user.username=='admin'}">--%>
<%--                        <th align="center" >编辑</th>--%>
<%--                        <th align="center" >删除</th>--%>
<%--                    </c:when>--%>
<%--                </c:choose>--%>
<%--                <c:choose>--%>
<%--                    <c:when test="${user.username!='admin'}">--%>
<%--                        <th align="center" >预约</th>--%>
<%--                        &lt;%&ndash;                        <th align="center" >取消预约</th>&ndash;%&gt;--%>
<%--                    </c:when>--%>
<%--                </c:choose>--%>
                <%--<th>删除该图书</th>--%>
            </tr>
            </thead>
<%--            <c:forEach items="${userlist}" var="i">--%>
            <tbody id="test">
<%--            <tr >--%>
<%--                <td  class="userid" align="center">${i.userid}</td>--%>
<%--                <td align="center" class="username">${i.username}</td>--%>
<%--                <td class="password" align="center" >${i.password}</td>--%>
<%--                <td align="center" class="app"><button class="appoint btn btn-info" onclick="openModel(this)">编辑</button></td>--%>
<%--                <c:choose>--%>
<%--                    <c:when test="${user.username=='admin'}">--%>
<%--                        <td align="center" ><a class="appoint btn btn-danger" onclick="deleteUser(this)"> 删除</a></td>--%>
<%--                    </c:when>--%>
<%--                </c:choose>--%>
<%--            </tr>--%>
            </tbody>
<%--            </c:forEach>--%>
<%--        在网上找了一个用bootstrap实现分页例子，但未与列表记录产生连接，只是一个单纯的分页样式--%>
            <div class="test" pagination="p-new" pagenumber="5" totalnumber="15" paginationmax="10">

            </div>

<script type="text/javascript">
    function getappointment(obj) {
        $.ajax({
            url: "<%=request.getContextPath()%>/appointment/getlist",
            type:"post",
            data:{username:'${user.username}'},
            datatype:'text',
            success:success_function,
            error:error_function
        });
        function success_function(data){
            if(data.info=="success"){
                $("#test").empty();
                for(var i=0;i<data.list.length;i++){
                    console.log(data.list[i]);
                    var str = "<tr>"+
                        "<td  class='userid' align='center'>"+data.list[i].userid+"</td>"+
                        "<td  class='username' align='center'>"+data.userlist[i].username+"</td>"+
                        "<td align='center' class='bookid'>"+data.list[i].bookid+"</td>"+
                        "<td  class='bookname' align='center'>"+data.booklist[i].bookname+"</td>"+
                        "<td class='appointtime' align='center' >"+data.list[i].appointtime+"</td>"+
                        "<td align='center' ><a class='appoint btn btn-danger' onclick='disappoint(this)'> 取消预约</a></td>"
                        + "</tr>";

                    $("#test").append(str);
                }
                // window.location.reload();
                <%--location.href = '${pageContext.request.contextPath}'+"/book/manage";--%>
            }
            else {
                alert("预约列表为空！");
                <%--location.href = '${pageContext.request.contextPath}'+"/user/register";--%>
            }
        }
        function  error_function(){
            alert("something wrong!")
        }
    }

    function disappoint(obj) {
        var userid= $(obj).parents('td').parents('tr').find('.userid').text();
        var bookid= $(obj).parents('td').parents('tr').find('.bookid').text();
        $.confirm({
            type: 'grey',
            title: false,
            content: '确定取消该预约么？',
            buttons: {
                confirm: {
                    text: '确认',
                    action: function () {
                        <%--$.post(--%>
                        <%--    '${pageContext.request.contextPath}/appointment/disappoint',--%>
                        <%--    {userid:userid,bookid:bookid},--%>
                        <%--    function (data) {--%>
                        <%--        if(data=="success")--%>
                        <%--            window.location.reload();--%>
                        <%--        else--%>
                        <%--            alert("取消预约失败！");--%>
                        <%--    },--%>
                        <%--    function () {--%>
                        <%--        alert("something wrong!");--%>
                        <%--    }--%>
                        <%--)--%>
                        $.ajax({
                            url:'${pageContext.request.contextPath}/appointment/disappoint',
                            type:'post',
                            data:{bookid:bookid,userid:userid},
                            datatype:'text',
                            success:function (data) {
                                if (data=="success") {
                                    alert("取消预约成功！");
                                    window.location.reload();
                                }
                                else if (data=="updateerror"){
                                    alert("图书数量更新失败，请手动加一！");
                                }
                                else
                                    alert("取消预约失败！");
                            },
                            error:function () {
                                alert("something wrong!");
                            }
                        })
                    }
                },
                cancel: {
                    text: '取消',
                }
            }
        });
    }
    //当前页数
    var pagenumber;
    //总页数
    var totalnumber;
    //分页栏显示的页数
    var paginationmax;
    paginationInit();
    function initPagination(element){
        pagenumber = Number(element.attr('pagenumber'));
        totalnumber = Number(element.attr('totalnumber'));
        paginationmax = Number(element.attr('paginationmax'));
        if(totalnumber >= 1 && pagenumber <= totalnumber && paginationmax <= totalnumber){
            var content =
                "<ul class='pagination'>" +
                "<li value='pre'>" +
                "<a href='javascript:void(0);'>«</a>" +
                "</li>";
            for (var i = 0; i < totalnumber; i++) {
                content +=
                    "<li value='"+ (i + 1) +"'>" +
                    "<a href='javascript:void(0);'>" + (i + 1) +
                    "</a>" +
                    "</li>"
            }
            content +=
                "<li value='next'>" +
                "<a href='javascript:void(0);'>»</a>" +
                "</li>" +
                "</ul>";
            element.append(content);
                //为设置为当前页的页签添加样式
            element.children('ul').children('li[value = '+ pagenumber +']').addClass('active');
            element.children('ul').children('li').click(clickChange);
            element.children('ul').children('li').click(processData);
                //显示那几个页签 传入任意li元素即可
            pageShow(element.children('ul').children('li[value = '+ pagenumber +']'));
        }else{
            console.log('分页自定义属性不合理！');
        }
    };
    //凡是带有pagination = p-new属性的元素，都会生成分页，这样设计方便一个页面中有多个不同的分页
    function paginationInit(){
        $('[pagination = p-new]').each(function(){
            initPagination($(this))
        })
    };
    //点击页签时候样式的变化
    function clickChange(ev){
        ev = event || window.event;
        pageShow($(ev.target).parent());

        $(ev.target).parent().parent().children('li').each(function(index,item){
            if($(item).hasClass('active')){
                $(item).removeClass('active');
            }
        });
        //点击页码页签
        if($(ev.target).parent().attr('value') != 'pre' && $(ev.target).parent().attr('value') != 'next'){
            pagenumber = Number($(ev.target).parent().attr('value'))
            $(ev.target).parent().addClass('active');
            $(ev.target).parent().parent().children('li[value = pre]').removeClass('disabled');
            $(ev.target).parent().parent().children('li[value = next]').removeClass('disabled');
        //点击上一页页签
        }else if($(ev.target).parent().attr('value') == 'pre'){
            pagenumber -= 1;
            if(pagenumber <= 1){
                pagenumber = 1;
                $(ev.target).parent().parent().children('li[value = 1]').addClass('active');
                $(ev.target).parent().parent().children('li[value = pre]').addClass('disabled');
            }else{
                $(ev.target).parent().parent().children('li[value = '+ pagenumber.toString() +']').addClass('active');
                $(ev.target).parent().parent().children('li[value = pre]').removeClass('disabled');
                $(ev.target).parent().parent().children('li[value = next]').removeClass('disabled');
            }
        //点击下一页页签
        }else if($(ev.target).parent().attr('value') == 'next'){
            pagenumber += 1;
            if(pagenumber >= totalnumber){
                pagenumber = totalnumber;
                $(ev.target).parent().parent().children('li[value = '+ totalnumber +']').addClass('active');
                $(ev.target).parent().parent().children('li[value = next]').addClass('disabled');
            }else{
                $(ev.target).parent().parent().children('li[value = '+ pagenumber.toString() +']').addClass('active');
                $(ev.target).parent().parent().children('li[value = next]').removeClass('disabled');
                $(ev.target).parent().parent().children('li[value = pre]').removeClass('disabled');
            }
        }
    }
    //展示哪些页码 要用一个实际的分页找规律
    function pageShow(element){
        if(Number(pagenumber) >= 1 && Number(pagenumber) <= parseInt(.5 * Number(paginationmax))){
            element.parent().children('li').each(function(index,item){
                if(Number($(item).attr('value')) >= 1 + Number(paginationmax) && Number($(item).attr('value')) <= Number(totalnumber)){
                    $(item).css('display','none')
                }else{
                    $(item).css('display','inline-block')
                }
            });
        }else if(Number(pagenumber) > parseInt(.5 * Number(paginationmax)) && Number(pagenumber) <= Number(totalnumber) - parseInt(.5 * Number(paginationmax))){
            element.parent().children('li').each(function(index,item){
                if((Number($(item).attr('value')) >= 1 && Number($(item).attr('value')) <= Number(pagenumber) - parseInt(.5 * Number(paginationmax))) || (Number($(item).attr('value')) > Number(pagenumber) + parseInt(.5 * Number(paginationmax)) && Number($(item).attr('value')) <= Number(totalnumber))){
                    $(item).css('display','none')
                }else{
                    $(item).css('display','inline-block')
                }
            });
        }else if(Number(pagenumber) > Number(totalnumber) - parseInt(.5 * Number(paginationmax))){
            element.parent().children('li').each(function(index,item){
                if(Number($(item).attr('value')) >= 1 && Number($(item).attr('value')) <= Number(totalnumber) - Number(paginationmax)){
                    $(item).css('display','none')
                }else{
                    $(item).css('display','inline-block')
                }
            });
        }
    }
    //页面切换时候的处理函数。比如发ajax根据不同页码获取不同数据展示数据等，用户自行配置。
    function processData(){
        console.log('当前页码',pagenumber);
            //用户在这里写页码切换时候的逻辑
    }

</script>
</body>
</html>
