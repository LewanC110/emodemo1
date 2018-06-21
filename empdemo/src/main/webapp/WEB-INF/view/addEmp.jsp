<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>addEmp</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/r/bootstrap/css/bootstrap.min.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/r/css/style.css">
</head>
<body>
<div class="container">
    <div class="row head"></div>
    <div class="row body">
        <form class="form-horizontal" id="addEmpForm" action="${pageContext.request.contextPath}/emp/addEmp" method="post">
            <div class="form-group">
                <label for="name" class="col-sm-2 control-label">姓名</label>
                <div class="col-sm-6 name">
                    <input type="text" class="form-control" id="name" name="name">
                </div>
                <div class="col-sm-4 checkName"></div>
            </div>
            <div class="form-group">
                <label for="phone" class="col-sm-2 control-label">手机</label>
                <div class="col-sm-6 phone">
                    <input type="text" class="form-control" id="phone" name="phone">
                </div>
            </div>
            <div class="form-group">
                <label class="col-sm-2 control-label">性别</label>
                <div class="radio" style="left:15px">
                    <label>
                        <input type="radio" name="sex" value="男" checked="checked">
                        男
                    </label>
                    <label>
                        <input type="radio" name="sex" value="女" >
                        女
                    </label>
                </div>
            </div>
            <div class="form-group">
                <label for="salary" class="col-sm-2 control-label">工资</label>
                <div class="col-sm-6 salary">
                    <input type="text" class="form-control" id="salary" name="salary">
                </div>
            </div>
            <div class="form-group">
                <label class="col-sm-2 control-label">部门</label>
                <div class="col-sm-6">
                    <select class="form-control" name="dept_id" style="display:inline-block">
                        <c:forEach items="${deptList}" var="dept">
                        <option value="${dept.id}">${dept.dname}</option>
                        </c:forEach>
                    </select>
                </div>
            </div>
            <div class="form-group">
                <div class="col-sm-offset-2 col-sm-10">
                    <button type="button" class="btn btn-primary sub">提交</button>
                </div>
            </div>
        </form>
    </div>
    <div class="row foot"></div>
</div>
<script type="text/javascript" src="${pageContext.request.contextPath}/r/js/jquery-3.3.1.min.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/r/bootstrap/js/bootstrap.min.js"></script>
<script type="text/javascript">
    $(function () {
        var isName = false;
        var isPhone = false;
        var isSalary = false;
       $("#name").blur(function () {
           var name = $("#name").val();
           var reg = /^[\u4e00-\u9fa5]{2,4}$/;
           if(reg.test(name)){
               // $(".checkName").html("&#10004");
               $(".name").attr("class","col-sm-6 name has-success");
               isName = true;
           }else{
               // $(".checkName").html("&#10008");
               $(".name").attr("class","col-sm-6 name has-error");
               isName = false;
           }
       });

        $("#phone").blur(function () {
            var name = $("#phone").val();
            var reg = /^(13[0-9]|14[579]|15[0-3,5-9]|16[6]|17[0135678]|18[0-9]|19[89])\d{8}$/;
            if(reg.test(name)){
                // $(".checkName").html("&#10004");
                $(".phone").attr("class","col-sm-6 phone has-success");
                isPhone = true;
            }else{
                // $(".checkName").html("&#10008");
                $(".phone").attr("class","col-sm-6 phone has-error");
                isPhone = false;
            }
        });
        $("#phone").keyup(function(){
            $("#phone").val($("#phone").val().replace(/[^\d]/g,""));
        });
        $("#salary").blur(function () {
            var name = $("#salary").val();
            var reg = /^[0-9]{0,6}/;
            if(reg.test(name)){
                // $(".checkName").html("&#10004");
                $(".salary").attr("class","col-sm-6 salary has-success");
                isSalary = true;
            }else{
                // $(".checkName").html("&#10008");
                $(".salary").attr("class","col-sm-6 salary has-error");
                isSalary = false;
            }
        });
        $("#salary").keyup(function(){
            $("#salary").val($("#salary").val().replace(/[^\d]/g,""));
        });
        $(".sub").click(function() {
            if(isName && isPhone && isSalary){
                //提交表单
                $("#addEmpForm").submit();
            }
        });
    });
</script>
</body>
</html>
