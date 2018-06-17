<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring" %>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form" %>
<%@ taglib prefix="from" uri="http://www.springframework.org/tags/form" %>
<%@ page session="false" %>
<%@page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>

<c:set var="contextPath" value="${pageContext.request.contextPath}"/>

<html>
<head>
    <title>Login</title>
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css">
    <link rel="stylesheet" href="<c:url value="/resources/css/login.css"/>" type="text/css"/>
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
    <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>
</head>
<body>

<div class="wrapper">
    <div class="imgcontainer">
        <img src="/resources/img/logo.png" class="img">
    </div>

    <br>
    <br>

    <div class="container">
        <form id="form" method="POST" action="/login" class="form-signin">
            <div class="loginForm">
                <div class="form-group">
                    <span class="justMsg">${message}</span>
                    <br>
                    <input name="email" type="text" class="form-control" placeholder="Email" autofocus="true"/>
                    <br>
                    <input name="password" type="password" class="form-control" placeholder="Пароль"/>
                    <span class="errorMsg">${error}</span>
                    <br>
                    <button class="btn btn-lg btn-primary btn-block" type="submit">Войти</button>
                    <h4 class="text-center"><a href="${contextPath}/registration">Зарегистрироваться</a></h4>
                </div>
            </div>
        </form>
    </div>
</div>

<script>

</script>

</body>
</html>
