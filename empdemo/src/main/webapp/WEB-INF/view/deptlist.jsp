<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>deptlist</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/r/bootstrap/css/bootstrap.min.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/r/css/style.css">
</head>
<body>
    <div class="container">
        <div class="row head"></div>
        <div class="row">
            <table class="table table-striped table-hover">
                <thead>
                <tr>
                    <th><input type="checkbox" class="check-all"></th>
                    <th>#</th>
                    <th>部门名称</th>
                    <th>工作地点</th>
                    <th width="15%">操作</th>
                </tr>
                </thead>
                <tbody>
                <c:forEach items="${pageInfo.list}" var="dept" varStatus="index">
                    <tr>
                        <td><input type="checkbox" class="item" value="${dept.id}"></td>
                        <td>${index.index + 1}</td>
                        <td>${dept.dname}</td>
                        <td>${dept.location}</td>
                        <td>
                            <button type="button" class="btn btn-info">修改</button>
                            <button type="button" class="btn btn-danger delete-one" delete-id="${dept.id}">删除</button>
                        </td>
                    </tr>
                </c:forEach>

                </tbody>
            </table>
        </div>
        <div class="row">
            <div class="col-sm-9">
                <ul class="list-inline">
                    <li><button type="button" class="btn btn-primary addDeptView">增加</button></li>
                    <li><button type="button" class="btn btn-danger delete-all">删除</button></li>
                    <li><button type="button" class="btn btn-success a_demp">员工</button></li>
                    <li>
                        <form method="post" id="importForm" action="${pageContext.request.contextPath}/dept/importdept" enctype="multipart/form-data">
                            <input type="file" name="file">
                            <button type="button" class="btn btn-info" id="import">上传</button>
                        </form>
                    </li>
                    <li><button type="button" class="btn btn-info exportdata">下载</button></li>

                </ul>






                </p>
            </div>
            <div class="col-sm-3">
                <nav aria-label="Page navigation">
                    <ul class="pagination">
                        <c:if test="${pageInfo.isFirstPage}">
                            <li class="disabled">
                                <a href="javascript:;" aria-label="Previous">
                                    <span aria-hidden="true">&laquo;</span>
                                </a>
                            </li>
                        </c:if>
                        <c:if test="${!pageInfo.isFirstPage}">
                            <li>
                                <a href="${pageContext.request.contextPath}/dept/deptlist?pageNum=${pageInfo.prePage}" aria-label="Previous">
                                    <span aria-hidden="true">&laquo;</span>
                                </a>
                            </li>
                        </c:if>
                        <c:forEach items="${pageInfo.navigatepageNums}" var="num">
                            <li <c:if test="${pageInfo.pageNum == num}">class="active"</c:if>><a href="${pageContext.request.contextPath}/dept/deptlist?pageNum=${num}">${num}</a></li>
                        </c:forEach>
                        <c:if test="${pageInfo.isLastPage}">
                            <li class="disabled">
                                <a href="javascript:;" aria-label="Next">
                                    <span aria-hidden="true">&raquo;</span>
                                </a>
                            </li>
                        </c:if>
                        <c:if test="${!pageInfo.isLastPage}">
                            <li>
                                <a href="${pageContext.request.contextPath}/dept/deptlist?pageNum=${pageInfo.nextPage}" aria-label="Next">
                                    <span aria-hidden="true">&raquo;</span>
                                </a>
                            </li>
                        </c:if>
                    </ul>
                </nav>
            </div>
        </div>
        <div class="row foot"></div>
    </div>

    <script type="text/javascript" src="${pageContext.request.contextPath}/r/js/jquery-3.3.1.min.js"></script>
    <script type="text/javascript" src="${pageContext.request.contextPath}/r/bootstrap/js/bootstrap.min.js"></script>
    <script type="text/javascript">
        $(function () {
            $(".exportdata").click(function () {
                var path = "${pageContext.request.contextPath}/dept/exportdata";
                location.href = path;
            });

            $("#import").click(function () {
                $("#importForm").submit();
            });
            $(".addDeptView").click(function () {
                var path = "${pageContext.request.contextPath}/dept/addDeptView";
                location.href = path;
            });

            $(".a_demp").click(function () {
                var path = "${pageContext.request.contextPath}/emp/emplist";
                location.href = path;
            });
            $(".delete-one").click(function () {
                var id = $(this).attr("delete-id");
                var path = "${pageContext.request.contextPath}/dept/deleteDeptById?id=" + id;
                location.href = path;
            });
            $(".check-all").click(function () {
                $(".item").prop("checked",$(this).prop("checked"));
            });
            $(".delete-all").click(function () {
                var ids = [];
                $(".item").each(function () {
                    var item = $(this);
                    if(item.prop("checked")){
                        ids[ids.length] = item.val();
                    }
                });
                var path = "${pageContext.request.contextPath}/dept/deleteDeptById?id=" + ids;
                location.href = path;
            });
        });
    </script>
</body>
</html>
