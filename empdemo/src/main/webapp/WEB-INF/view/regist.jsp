<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>regist</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/r/bootstrap/css/bootstrap.min.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/r/css/style.css">

</head>
<body>
    <div class="container">
        <div class="row head"></div>
        <div class="row body">
            <form class="form-horizontal"  action="${pageContext.request.contextPath}/user/regist" method="post" id="registForm">
                <div class="form-group">
                    <label for="username" class="col-sm-2 control-label">姓名</label>
                    <div class="col-sm-6 username">
                        <input type="text" class="form-control" id="username" name="username">
                    </div>
                    <div class="col-sm-4 nameRemind"></div>
                </div>
                <div class="form-group">
                    <label for="password" class="col-sm-2 control-label">密码</label>
                    <div class="col-sm-6 password">
                        <input type="password" class="form-control" id="password" name="password">
                    </div>
                    <div class="col-sm-4 pwd1"></div>
                </div>
                <div class="form-group">
                    <label for="password1" class="col-sm-2 control-label">密码确认</label>
                    <div class="col-sm-6 password1">
                        <input type="password" class="form-control" id="password1" name="password1">
                    </div>
                    <div class="col-sm-4 pwd2"></div>
                </div>
                <div class="form-group">
                    <label for="headimg" class="col-sm-2 control-label">头像</label>
                    <div class="col-sm-6">
                        <input type="file" id="headimg" name="headimg">
                        <p class="help-block">仅支持png、jpg格式</p>
                        <img src="..." alt="..." class="img-thumbnail" id="preview" width="140px" height="140px">
                    </div>
                </div>


                <div class="form-group">
                    <div class="col-sm-offset-2 col-sm-10">
                        <button type="button" class="btn btn-primary sub">注册</button>
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
            var isUsername = false;
            var isPassword = false;
            var isPassword1 = false;

            $("#username").blur(function () {
                //正则校验
                var username = $(this).val();
                var reg = /^[a-zA-Z]{5,10}/;
                if(reg.test(username)){
                    //检查用户名是否存在
                    $.ajax({
                        url:"${pageContext.request.contextPath}/user/checkUsername?username=" + username,
                        type:"get",
                        success:function(data) {
                            var isRegist = data.trim();
                            if(isRegist == "true"){
                                //能注册
                                $(".username").attr("class","col-sm-6 username has-success");
                                isUsername = true;
                                $(".nameRemind").html("");
                            }else{
                                //不能注册
                                $(".username").attr("class","col-sm-6 username has-error");
                                $(".nameRemind").html("用户名已存在");
                                isUsername = false;
                            }
                        }
                    });
                }else{
                    $(".username").attr("class","col-sm-6 username has-error");
                    $(".nameRemind").html("用户名不合法");
                    isUsername = false;
                }
            });

            $("#password").blur(function () {
                var password = $(this).val();
                if(password == ""){
                    $(".password").attr("class","col-sm-6 password has-error");
                    $(".pwd1").html("密码不能为空");
                    isPassword = false;
                }else{
                    $(".password").attr("class","col-sm-6 password has-success");
                    $(".pwd1").html("");
                    isPassword = true;
                }
            });
            $("#password1").blur(function () {
                var password1 = $(this).val();
                if(password1 == ""){
                    $(".password1").attr("class","col-sm-6 password has-error");
                    $(".pwd2").html("密码不能为空");
                    isPassword1 = false;
                }else{
                    if(password1 == $("#password").val()){
                        $(".password1").attr("class","col-sm-6 password has-success");
                        $(".pwd2").html("");
                        isPassword1 = true;
                    }else{
                        $(".password1").attr("class","col-sm-6 password has-error");
                        $(".pwd2").html("两次密码不一致");
                        isPassword1 = false;
                    }
                }
            });

            $("#headimg").change(function () {
                var path = $(this).val();
                var suffix = path.substring(path.indexOf("."));
                if(suffix == ".jpg" || suffix == ".png"){
                    //图片预览
                    var  img = document.getElementById("headimg").files[0];
                    var reader = new FileReader();
                    reader.readAsDataURL(img);
                    reader.onload = function (ev) {
                        $("#preview").attr("src",this.result);
                    }
                }
            });
            
            $(".sub").click(function () {
                if(isPassword1 && isPassword && isUsername){
                    $("#registForm").submit();
                }
            });
        });
    </script>
</body>
</html>
