<html>
<head>
    <meta charset="UTF-8"/>
    <title>点名册</title>
</head>
<body>
<h2>学期：${term}</h2>
<h3>班级编号：${classId}</h3>
<p>${placeholder}</p>
<table border="1" cellpadding="6" cellspacing="0">
    <tr>
        <th>序号</th>
        <th>学号</th>
        <th>姓名</th>
        <th>联系方式</th>
        <th>备注</th>
    </tr>
    <#list 1..5 as idx>
        <tr>
            <td>${idx}</td>
            <td>示例学号${idx}</td>
            <td>示例姓名${idx}</td>
            <td>联系方式</td>
            <td></td>
        </tr>
    </#list>
</table>
</body>
</html>
