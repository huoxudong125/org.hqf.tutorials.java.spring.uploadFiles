<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%--
  Created by IntelliJ IDEA.
  User: huoquanfu
  Date: 2020/1/2
  Time: 21:01
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Index</title>
</head>
<body>

<legend>文件信息</legend>
<table class="table" style="width: 100%;">
    <tr>
        <th style="width: 20%;">
            文件:
        </th>
        <td>
            <input id="file" name="file" type="file" style="width:300px;height: 25px">
        </td>
    </tr>
    <tr>
        <th>关键字:</th>
        <td>
            <input id="fileName" name="fileName" style="width:300px;height: 20px"/>
        </td>
    </tr>
    <tr>
        <th>分类:</th>
        <td>
            <input id="fileType" name="fileType" style="width:300px;height: 25px">
        </td>
    </tr>
</table>
</fieldset>

<button type="button" onclick="uploadFile()">保存</button>

<script src="https://cdn.bootcss.com/jquery/3.2.1/jquery.min.js"></script>
<script type="text/javascript">
    function uploadFile() {
        debugger;
        var myform = new FormData();
        myform.append('file', $("#file")[0].files[0]);
        // myform.append('fileType', $("#fileType").val());
        myform.append('name', $("#fileName").val());
        $.ajax({
            url: "uploadFile",
            type: "POST",
            data: myform,
            async: false,
            contentType: false,
            processData: false,
            success: function (result) {
                console.log(result);
                if (result && result.result) {
                    getFileListPage();
                } else {
                    console.log(result);
                    // $.messager.alert("警告", "文件上传失败！", "warning", function () {
                    //     var file = document.getElementById('file');
                    //     file.value = '';
                    // });
                }
            },

            error: function (data) {
                console.log("%s", data.responseText);
                // console.log("警告"+ "文件上传失败！", "warning", function () {
                //     var file = document.getElementById('file');
                //     file.value = '';
                // });
            }
        });
    }
</script>
</body>
</html>
