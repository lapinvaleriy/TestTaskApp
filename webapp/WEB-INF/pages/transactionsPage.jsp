<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring" %>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form" %>
<%@ taglib prefix="from" uri="http://www.springframework.org/tags/form" %>
<%@ page session="false" %>
<%@page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>

<html>
<head>
    <title>История транзакций</title>
    <link rel="stylesheet" href="<c:url value="/resources/css/bankPage.css"/>" type="text/css"/>
</head>
<body>
<div class="table-list">
    <div class="tableWrapper">
        <br>
        <a style="margin-left: 30px; color: #22d853;" href="/bankPage">Вернуться к картам</a>
        <span style="font-size: 27px ; margin-left: 200px; color: #5161bb;"> Транзакции</span>
        <br>
        <br>
        <c:if test="${empty transList}"><label id="notFound">Нет транзакций по этой карте</label></c:if>
        <c:if test="${!empty transList}">
            <table class="tg">
                <tr>
                    <th>№</th>
                    <th>Тип</th>
                    <th>Сумма</th>
                </tr>
                <c:forEach items="${transList}" var="transaction">
                    <tr>
                        <td>${transList.indexOf(transaction) + 1}</td>
                        <td>${transaction.transactionType}</td>
                        <td>${transaction.amount}</td>
                    </tr>
                </c:forEach>
            </table>
        </c:if>
    </div>
</div>
</body>
</html>
