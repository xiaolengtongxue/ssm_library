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
</head>
<body>
<div class="container">
    <div class="table-responsive">
        <table border="1" align="center" class="table table-striped table-bordered  table-hover">
            <thead>
            <tr>
                <th align="center">编号</th>
                <th align="center">书名</th>
                <th align="center">剩余数量</th>

                <c:choose>
                    <c:when test="${user.username=='admin'}">
                        <th align="center" >编辑</th>
                        <th align="center" >删除</th>
                        <th align="center" ><a class="appoint btn btn-danger" onclick="getbooklist(this)"> 获取图书列表</a></th>
                        <th align="center" ><a class="appoint btn btn-danger" onclick="openModel1(this)"> 添加图书</a></th>
                    </c:when>
                </c:choose>
                <c:choose>
                    <c:when test="${user.username!='admin'}">
                        <th align="center" >预约</th>
                        <th align="center" ><a class="appoint btn btn-danger" onclick="getbooklist(this)"> 获取图书列表</a></th>
<%--                    <th align="center" >取消预约</th>--%>
                    </c:when>
                </c:choose>
                <%--<th>删除该图书</th>--%>
            </tr>
            </thead>
<%--            <c:forEach items="${booklist}" var="i">--%>
            <tbody id="test">
<%--            <tr >--%>
<%--                <td  class="bookid" align="center">${i.bookid}</td>--%>
<%--                <td align="center" class="bookname">${i.bookname}</td>--%>
<%--                <td class="booknumber" align="center" >${i.booknumber}</td>--%>

<%--                <c:choose>--%>
<%--                    <c:when test="${user.username=='admin'}">--%>
<%--                        <td align="center" class="app"><button class="appoint btn btn-info" onclick="openModel(this)">编辑</button></td>--%>
<%--                        <td align="center" ><a class="appoint btn btn-danger" onclick="deleteUser(this)"> 删除</a></td>--%>
<%--                    </c:when>--%>
<%--                </c:choose>--%>
<%--                <c:choose>--%>
<%--                    <c:when test="${user.username!='admin'}">--%>
<%--                        <td align="center" ><a class="appoint btn btn-danger" onclick="deleteUser(this)"> 预约</a></td>--%>
<%--                    </c:when>--%>
<%--                </c:choose>--%>
<%--            </tr>--%>
            </tbody>
<%--            </c:forEach>--%>
    </div>
    <script type="text/javascript">
        function getbooklist(obj) {
            $.ajax({
                url: "<%=request.getContextPath()%>/book/list",
                type:"post",
                success:success_function,
                error:error_function
            });
            function success_function(data){
                if(data.info=="success"){
                    $("#test").empty();
                    for(var i=0;i<data.list.length;i++){
                        var str = "<tr>"+
                            "<td  class='bookid' align='center'>"+data.list[i].bookid+"</td>"+
                            "<td align='center' class='bookname'>"+data.list[i].bookname+"</td>"+
                            "<td class='booknumber' align='center' >"+data.list[i].booknumber+"</td>";
                        if (${user.username=='admin'}) {
                            str = str + "<td align='center' class='app'><button class='appoint btn btn-info' onclick='openModel(this)'>编辑</button></td>"
                                      + "<td align='center' ><a class='appoint btn btn-danger' onclick='deleteBook(this)'> 删除</a></td>"
                                      + "</tr>";
                        }else {
                            str = str + " <td align='center' ><a class='appoint btn btn-danger' onclick='appoint(this)'> 预约</a></td>"
                                      + "</tr>";
                        }
                        $("#test").append(str);
                    }
                    // window.location.reload();
                    <%--location.href = '${pageContext.request.contextPath}'+"/book/manage";--%>
                }
                else {
                    alert("图书列表为空！");
                    <%--location.href = '${pageContext.request.contextPath}'+"/user/register";--%>
                }
            }
            function  error_function(){
                alert("something wrong!");
            }
        }
    </script>
    <div class="modal fade  myModel" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true" data-backdrop="static">
        <div class="modal-dialog">
            <div class="modal-content">
                <div class="modal-header">
                    <button type="button" class="close" data-dismiss="modal" aria-hidden="true">
                        &times;
                    </button>
                    <h4 class="modal-title" id="myModalLabel">
                        修改图书信息
                    </h4>
                </div>
                <div id="book" class="book modal-body form-group">
                    <h5 class="form-signin-heading">图书编号：</h5>
                    <input class="form-control bookid"  readonly/>
                    <h5 class="form-signin-heading">图书名：</h5>
                    <input class="form-control name"  />
                    <h5 class="form-signin-heading ">剩余数量：</h5>
                    <input class="form-control number"/>
                </div>
                <div class="modal-footer">
                    <a class="waves-effect btn btn-danger btn-sm"
                       data-dismiss="modal"><i class="zmdi zmdi-delete"></i> 关闭</a>
                    <a class="waves-effect btn btn-info btn-sm" id="confirmdirbutton"
                       href="javascript:confirmdir(this);"><i class="zmdi zmdi-edit"></i>
                        确认</a>
                    <%--<button type="button" class="btn btn-default" data-dismiss="modal">关闭--%>
                    <%--</button>--%>
                    <%--<button type="button" class=" btn btn-primary" onclick="editUser()">--%>
                    <%--更改--%>
                    <%--</button>--%>
                </div>
            </div><!-- /.modal-content -->
        </div><!-- /.modal -->
    </div>
    <div class="modal fade  myModel1" tabindex="-1" role="dialog" aria-labelledby="myModalLabel1" aria-hidden="true" data-backdrop="static">
        <div class="modal-dialog">
            <div class="modal-content">
                <div class="modal-header">
                    <button type="button" class="close" data-dismiss="modal" aria-hidden="true">
                        &times;
                    </button>
                    <h4 class="modal-title" id="myModalLabel1">
                        添加图书信息
                    </h4>
                </div>
                <div id="book1" class="book modal-body form-group">
                    <h5 class="form-signin-heading">图书编号：</h5>
                    <input class="form-control bookid" />
                    <h5 class="form-signin-heading">图书名：</h5>
                    <input class="form-control name"  />
                    <h5 class="form-signin-heading ">剩余数量：</h5>
                    <input class="form-control number"/>
                </div>
                <div class="modal-footer">
                    <a class="waves-effect btn btn-danger btn-sm"
                       data-dismiss="modal"><i class="zmdi zmdi-delete"></i> 关闭</a>
                    <a class="waves-effect btn btn-info btn-sm" id="confirmdirbutton"
                       href="javascript:confirmdirbook(this);"><i class="zmdi zmdi-edit"></i>
                        确认</a>
                    <%--<button type="button" class="btn btn-default" data-dismiss="modal">关闭--%>
                    <%--</button>--%>
                    <%--<button type="button" class=" btn btn-primary" onclick="editUser()">--%>
                    <%--更改--%>
                    <%--</button>--%>
                </div>
            </div><!-- /.modal-content -->
        </div><!-- /.modal -->
    </div>
</div>
<script type="text/javascript">
    function openModel (obj) {
        $('.myModel').modal('show');
        var bookid = $(obj).parents('td').parents('tr').find('.bookid').text();
        var bookname = $(obj).parents('td').parents('tr').find('.bookname').text();
        var booknumber = $(obj).parents('td').parents('tr').find('.booknumber').text();
        // 获取每一行的数据到模态框中
        $('.bookid').val(bookid);
        $('.name').val(bookname);
        $('.number').val(booknumber);
    }

    function openModel1 (obj) {
        $('.myModel1').modal('show');
        var bookid = $(obj).parents('td').parents('tr').find('.bookid').text();
        var bookname = $(obj).parents('td').parents('tr').find('.bookname').text();
        var booknumber = $(obj).parents('td').parents('tr').find('.booknumber').text();
        // 获取每一行的数据到模态框中
        $('.bookid').val(bookid);
        $('.name').val(bookname);
        $('.number').val(booknumber);
    }

    function deleteBook(obj) {
        var bookid= $(obj).parents('td').parents('tr').find('.bookid').text();
        $.confirm({
            type: 'grey',
            title: false,
            content: '确定删除该图书么？',
            buttons: {
                confirm: {
                    text: '确认',
                    action: function () {
                        <%--$.post(--%>
                        <%--    '${pageContext.request.contextPath}/book/deleteBook',--%>
                        <%--    {bookid:bookid},--%>
                        <%--    function (data) {--%>
                        <%--        if(data=="success")--%>
                        <%--            window.location.reload();--%>
                        <%--    }--%>
                        <%--)--%>
                        $.ajax({
                            url:'${pageContext.request.contextPath}/book/deleteBook',
                            type:'post',
                            data:{bookid:bookid},
                            datatype:'text',
                            success:function (data) {
                                if (data=="success")
                                    window.location.reload();
                                else
                                    alert("删除失败！")
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
    function appoint(obj) {
        var bookid= $(obj).parents('td').parents('tr').find('.bookid').text();
        $.confirm({
            type: 'grey',
            title: false,
            content: '确定预约该图书么？',
            buttons: {
                confirm: {
                    text: '确认',
                    action: function () {
                        $.ajax({
                            url:'${pageContext.request.contextPath}/appointment/appoint',
                            type:'post',
                            data:{bookid:bookid,userid:'${user.userid}'},
                            datatype:'text',
                            success:function (data) {
                                if (data=="success") {
                                    alert("预约成功！");
                                    window.location.reload();
                                }
                                else if (data=="repeat")
                                    alert("您已经预约过本图书，请勿重复预约！");
                                else if (data=="nonum")
                                    alert("库存不足，预约失败！");
                                else if (data=="updateerror")
                                    alert("图书数量更新失败，请手动减一！");
                                else
                                    alert("预约失败！");
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
    function confirmdir() {
        var bookid =  $('#book').find('.bookid').val();
        var bookname = $('#book').find('.name').val();
        var booknumber = $('#book').find('.number').val();
        $.ajax({
            url: '<%=request.getContextPath()%>/book/editBook',
            type: 'post',
            data:{bookid:bookid,bookname:bookname,booknumber:booknumber},
            datatype:'text',
            success:function (data) {
                if(data=="success") {
                    $('.myModel').modal('hide');
                    window.location.reload();
                    //$(obj).parent('div').parent('div').children('div').find('.name').text(username);
                    //$(obj).parent('td').parent('tr').find('.password').text(password);
                }
                else if(data=="error"){
                    alert("图书名已存在，请重新修改图书名！");
                    //location.href = '${pageContext.request.contextPath}'+"/user/register";
                }else if(data=="numerror"){
                    alert("图书剩余数量不能小于0，请重新修改！");
                }else {
                    alert("图书名或数量不能为空，请重新修改！");
                }
            },
            error:function (){
                alert("something wrong!");
            }
        })
    }

    function confirmdirbook() {
        var bookid =  $('#book1').find('.bookid').val();
        var bookname = $('#book1').find('.name').val();
        var booknumber = $('#book1').find('.number').val();

        $.ajax({
            url: '<%=request.getContextPath()%>/book/addBook',
            type: 'post',
            data:{bookid:bookid,bookname:bookname,booknumber:booknumber},
            datatype:'text',
            success:function (data) {
                if(data=="success") {
                    $('.myModel1').modal('hide');
                    window.location.reload();
                    //$(obj).parent('div').parent('div').children('div').find('.name').text(username);
                    //$(obj).parent('td').parent('tr').find('.password').text(password);
                }
                else if(data=="nameerror"){
                    alert("图书名已存在，请重新添加图书名！");
                    //location.href = '${pageContext.request.contextPath}'+"/user/register";
                }else if(data=="numerror"){
                    alert("图书剩余数量不能小于0，请重新添加！");
                }else if (data=="iderror") {
                    alert("图书编号已存在，请重新添加！");
                }else if (data=="idnull"){
                    alert("图书编号不能为空，请重新添加图书编号！");
                } else if (data=="namenull"){
                    alert("图书名不能为空，请重新添加图书名！");
                } else if (data=="numnull"){
                    alert("图书剩余数量不能为空，请重新添加图书剩余数量！");
                }
                else {
                    alert("添加失败！")
                }
            },
            error:function () {
                alert("something wrong!");
            }
        })
    }
</script>
</body>
</html>
