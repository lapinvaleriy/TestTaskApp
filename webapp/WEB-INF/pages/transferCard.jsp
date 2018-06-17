<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring" %>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form" %>
<%@ taglib prefix="from" uri="http://www.springframework.org/tags/form" %>
<%@ page session="false" %>
<%@page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>

<html>
<head>
    <title>Переслать</title>
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
        <a class="btnLinks" href="/withdraw">Снять деньги</a>
        <a class="btnLinks" id="selectedLink" href="/transfer">Перевести деньги</a>
    </div>

    <br>
    <br>
    <div class="inputTransWrapper">
        <c:if test="${empty cardList}"><label id="notFound">У вас нет ни одной карты</label></c:if>
        <c:if test="${!empty cardList}">
            <form name="form" id="form" method="POST" action="bankPage/transfer" role="form">
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
                    <label><span class="glyphicon glyphicon-transfer"></span> Введите номер карты</label>
                    <input type="text" pattern="[0-9]{4}\s[0-9]{4}\s[0-9]{4}\s[0-9]{4}" name="toCard"
                           class="form-control"
                           id="psws" placeholder="Номер карты">
                </div>

                <span class="errorMsg" id="invalid_card_error"></span>

                <div class="form-group">
                    <label><span class="glyphicon glyphicon-usd"></span> Введите сумму</label>
                    <input type="number" name="amount" class="form-control" id="amount" placeholder="Сумма">
                </div>

                <span class="errorMsg" id="amount_error"></span>

                <div class="form-group">
                    <label><span class="glyphicon glyphicon-eye-open"></span> Введите пин код</label>
                    <input type="password" name="pincode" maxlength="4" class="form-control" id="pswTr"
                           placeholder="PIN code">
                </div>

                <span class="errorMsg" id="pin_error"></span>
                <span class="errorMsg">${error}</span>
                <br>

                <button type="submit" class="send">Перевести</button>
            </form>
        </c:if>
    </div>
</div>
<script>
    var cc = form.toCard;

    for (var i in ['input', 'change', 'blur', 'keyup']) {
        cc.addEventListener('input', formatCardCode, false);
    }

    function formatCardCode() {
        var cardCode = this.value.replace(/[^\d]/g, '').substring(0, 16);
        cardCode = cardCode != '' ? cardCode.match(/.{1,4}/g).join(' ') : '';
        this.value = cardCode;
    }

    $(function () {
        $("amount_error").hide();
        $("pin_error").hide();
        $("invalid_card_error").hide();

        var amountErr = false;
        var pinErr = false;
        var invalidCard = false;

        $("#amount").focusout(function () {
            check_amount();
        });

        $("#pswTr").focusout(function () {
            check_pin();
        });

        $("#psws").focusout(function () {
            check_card();
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
            var pin = $("#pswTr").val().length;

            if (pin < 4) {
                $("#pin_error").html("Введите пинкод!");
                $("#pin_error").show();
                pinErr = true;
            } else {
                $("#pin_error").hide();
            }
        }

        function check_card() {
            var number = $("#psws").val().length;

            if (number < 19) {
                $("#invalid_card_error").html("Неверный номер карты");
                $("#invalid_card_error").show();
                pinErr = true;
            } else {
                $("#invalid_card_error").hide();
            }
        }

        $("#form").submit(function () {
            amountErr = false;
            pinErr = false;
            invalidCard = false;

            check_amount();
            check_pin();
            check_card();

            if (amountErr == false && pinErr == false && invalidCard == false) {
                return true;
            } else {
                return false;
            }
        });
    });
</script>
</body>
</html>
