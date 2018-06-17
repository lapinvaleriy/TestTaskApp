package com.testtask.dao.card.dao;

import com.testtask.model.Card;

import java.util.List;

public interface CardDao {
    void save(Card card);

    void update(Card card);

    List<Card> getAllCards(String ownerEmail);
}
