package com.testtask.service.card.service;

import com.testtask.model.Card;

import java.util.List;

public interface CardService {
    void save(Card card);

    long generateCardNumber();

    void replenishMoney(Card card, int amount);

    boolean withdrawMoney(Card card, int amount);

    Card transferMoney(Card card, String owner, long toCardNumber, int amount);

    Card operationValidation(long cardNumber, String ownerEmail, String pincode);

    List<Card> getAllCards(String ownerEmail);
}
