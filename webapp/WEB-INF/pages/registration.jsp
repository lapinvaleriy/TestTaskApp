<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring" %>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form" %>
<%@ taglib prefix="from" uri="http://www.springframework.org/tags/form" %>
<%@ page session="false" %>
<%@page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>

<html>
<head>
    <title>Registration</title>
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css">
    <link rel="stylesheet" href="<c:url value="/resources/css/registration.css"/>" type="text/css"/>
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
    <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>
</head>
<body>
<div class="wrapper">
    <div class="imgcontainer">
        <img src="/resources/img/logo.png" class="img">
    </div>
    <br>
    <span class="regtext">Регистрация</span>
    <br>

    <div class="container">
        <form:form method="POST" modelAttribute="user" class="form-signin">
            <spring:bind path="email">
                <div class="form-group ${status.error ? 'has-error' : ''}">
                    <form:input type="text" path="email" class="form-control" placeholder="Ваш e-mail"
                                autofocus="true"></form:input>
                    <form:errors cssClass="error" path="email"></form:errors>
                </div>
            </spring:bind>
            <spring:bind path="name">
                <div class="form-group ${status.error ? 'has-error' : ''}">
                    <form:input type="text" path="name" class="form-control"
                                placeholder="Ваше имя"></form:input>
                    <form:errors cssClass="error" path="name"></form:errors>
                </div>
            </spring:bind>
            <spring:bind path="password">
                <div class="form-group ${status.error ? 'has-error' : ''}">
                    <form:input type="password" path="password" class="form-control" placeholder="Пароль"></form:input>
                    <form:errors cssClass="error" path="password"></form:errors>
                </div>
            </spring:bind>
            <spring:bind path="confirmPassword">
                <div class="form-group ${status.error ? 'has-error' : ''}">
                    <form:input type="password" path="confirmPassword" class="form-control"
                                placeholder="Подтверждение пароля"></form:input>
                    <form:errors cssClass="error" path="confirmPassword"></form:errors>
                </div>
            </spring:bind>
            <br>
            <button class="btn btn-lg btn-primary btn-block" type="submit">Зарегистрироваться</button>
        </form:form>
    </div>
</div>
</body>
</html>
