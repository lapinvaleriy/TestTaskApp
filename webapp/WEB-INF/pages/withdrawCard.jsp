<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring" %>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form" %>
<%@ taglib prefix="from" uri="http://www.springframework.org/tags/form" %>
<%@ page session="false" %>
<%@page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>

<html>
<head>
    <title>Снять</title>
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css">
    <link rel="stylesheet" href="<c:url value="/resources/css/bankPage.css"/>" type="text/css"/>
    <link rel="stylesheet" href="<c:url value="/resources/css/links.css"/>" type="text/css"/>
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
    <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>
</head>
<body>

<div class="wrapper">
    <div class="links">
        <a class="btnLinks" href="/bankPage">Мои карты</a>
        <a class="btnLinks" href="/replenish">Пополнить карту</a>
        <a class="btnLinks" id="selectedLink" href="/withdraw">Снять деньги</a>
        <a class="btnLinks" href="/transfer">Перевести деньги</a>
    </div>
    <br>
    <br>
    <div class="inputWrapper">
        <c:if test="${empty cardList}"><label id="notFound">У вас нет ни одной карты</label></c:if>
        <c:if test="${!empty cardList}">
            <form id="form" method="POST" action="/bankPage/withdraw" role="form">
                <div class="form-group">
                    <label class="cardLabel"><span class="glyphicon glyphicon-credit-card"></span> Выберите
                        карту</label>
                    <br>
                    <select name="cardNumber">
                        <c:forEach items="${cardList}" var="card">
                            <option>${card.cardNumber}</option>
                        </c:forEach>
                    </select>
                </div>

                <div class="form-group">
                    <label><span class="glyphicon glyphicon-usd"></span> Введите сумму</label>
                    <input type="number" name="amount" class="form-control" id="amount" placeholder="Сумма">
                </div>

                <span class="errorMsg" id="amount_error"></span>

                <div class="form-group">
                    <label for="pswWit"><span class="glyphicon glyphicon-eye-open"></span> Введите пин код</label>
                    <input type="password" name="pincode" maxlength="4" class="form-control" id="pswWit"
                           placeholder="PIN code">
                </div>

                <span class="errorMsg" id="pin_error"></span>
                <span class="errorMsg">${error}</span>
                <br>

                <button type="submit" class="send">Снять</button>
            </form>
        </c:if>
    </div>
</div>

<script>
    $(function () {
        $("amount_error").hide();
        $("pin_error").hide();

        var amountErr = false;
        var pinErr = false;

        $("#amount").focusout(function () {
            check_amount();
        });

        $("#pswWit").focusout(function () {
            check_pin();
        });

        function check_amount() {
            var amount = $("#amount").val();

            if (amount <= 0) {
                $("#amount_error").html("Сумма перевода не может быть меньше либо равна 0");
                $("#amount_error").show();
                amountErr = true;
            } else {
                $("#amount_error").hide();
            }
        }

        function check_pin() {
            var pin = $("#pswWit").val().length;

            if (pin < 4) {
                $("#pin_error").html("Введите пинкод!");
                $("#pin_error").show();
                pinErr = true;
            } else {
                $("#pin_error").hide();
            }
        }

        $("#form").submit(function () {
            amountErr = false;
            pinErr = false;

            check_amount();
            check_pin();

            if (amountErr == false && pinErr == false) {
                return true;
            } else {
                return false;
            }
        });
    });
</script>
</body>
</html>
