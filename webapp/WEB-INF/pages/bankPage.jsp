<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring" %>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form" %>
<%@ taglib prefix="from" uri="http://www.springframework.org/tags/form" %>
<%@ page session="false" %>
<%@page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>

<html>
<head>
    <title>My Bank</title>
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css">
    <link rel="stylesheet" href="<c:url value="/resources/css/bankPage.css"/>" type="text/css"/>
    <link rel="stylesheet" href="<c:url value="/resources/css/links.css"/>" type="text/css"/>
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
    <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>

    <style>

    </style>
</head>
<body>

<div class="wrapper">
    <div class="links">
        <a id="selectedLink" class="btnLinks">Мои карты</a>
        <a class="btnLinks" href="/replenish">Пополнить карту</a>
        <a class="btnLinks" href="/withdraw">Снять деньги</a>
        <a class="btnLinks" href="/transfer">Перевести деньги</a>
    </div>

    <br>

    <div class="table-list">
        <div class="container">
            <form id="form" method="POST" action="bankPage/addcard">
                <div class="modal fade" id="myModal" role="dialog">
                    <div class="modal-dialog">
                        <div class="modal-content">
                            <div class="modal-header" style="padding:35px 50px;">
                                <button type="button" class="close" data-dismiss="modal">&times;</button>
                                <h4><span class="glyphicon glyphicon-credit-card"></span> Добавить карту</h4>
                            </div>
                            <div class="modal-body" style="padding:40px 50px;">
                                <form role="form">
                                    <div class="form-group">
                                        <label class="modalLabel" for="cardName"><span
                                                class="glyphicon glyphicon-user"></span> Назовите
                                            свою карту</label>
                                        <input class="modalInput" type="text" name="cardName" class="form-control"
                                               id="cardName"
                                               placeholder="Имя карты">
                                    </div>

                                    <span class="errorMsg" id="name_error"></span>

                                    <div class="form-group">
                                        <label class="modalLabel" for="psw"><span
                                                class="glyphicon glyphicon-eye-open"></span> Придумайте
                                            пин-код </label>
                                        <input class="modalInput" type="password" name="pincode" maxlength="4"
                                               class="form-control"
                                               id="psw" placeholder="PIN code">
                                    </div>

                                    <span class="errorMsg" id="pin_error"></span>

                                    <button type="submit" id="modalSubmit" class="btn btn-success btn-block">
                                        <span></span> Добавить
                                    </button>
                                </form>
                            </div>
                        </div>

                    </div>
                </div>
            </form>
        </div>

        <div class="tableWrapper">
            <br>
            <span class="glyphicon glyphicon-credit-card"
                  style="font-size: 27px ; margin-left: 309px; color: #5161bb;"> Мои карты</span>
            <button type="button" class="btn btn-default btn-lg" id="myBtn">Добавить карту</button>
            <br>
            <br>
            <c:if test="${empty cardList}"><label id="notFound">У вас нет ни одной карты</label></c:if>
            <c:if test="${!empty cardList}">
                <table class="tg">
                    <tr>
                        <th>Карта</th>
                        <th>Баланс</th>
                        <th width="200">Действия</th>
                    </tr>
                    <c:forEach items="${cardList}" var="card">
                        <tr>
                            <td>${card.cardNumber} <br> ${card.name}</td>
                            <td>${card.balance} $</td>
                            <td><a id="transLink" href="history/?id=<c:out value='${card.id}'/>">История транзакций</a>
                            </td>
                        </tr>
                    </c:forEach>
                </table>
            </c:if>
        </div>
    </div>
</div>
</body>
<script>
    $(document).ready(function () {
        $("#myBtn").click(function () {
            $("#myModal").modal();
        });
    });


    $(function () {
        $("name_error").hide();
        $("pin_error").hide();

        var nameErr = false;
        var pinErr = false;

        $("#cardName").focusout(function () {
            check_name();
        });

        $("#psw").focusout(function () {
            check_pin();
        });

        function check_name() {
            var name = $("#cardName").val().length;

            if (name <= 0) {
                $("#name_error").html("Введите имя карты");
                $("#name_error").show();
                nameErr = true;
            } else {
                $("#name_error").hide();
            }
        }

        function check_pin() {
            var pin = $("#psw").val().length;

            if (pin < 4) {
                $("#pin_error").html("Придумайте пинкод!");
                $("#pin_error").show();
                pinErr = true;
            } else {
                $("#pin_error").hide();
            }
        }

        $("#form").submit(function () {
            nameErr = false;
            pinErr = false;

            check_name();
            check_pin();

            if (nameErr == false && pinErr == false) {
                return true;
            } else {
                return false;
            }
        });
    });
</script>
</html>
