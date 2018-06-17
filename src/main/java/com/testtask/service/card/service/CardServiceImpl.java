package com.testtask.service.card.service;

import com.testtask.dao.card.dao.CardDao;
import com.testtask.model.Card;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class CardServiceImpl implements CardService {

    @Autowired
    private CardDao cardDao;

    @Autowired
    private BCryptPasswordEncoder bCryptPasswordEncoder;

    public void setCardDao(CardDao cardDao) {
        this.cardDao = cardDao;
    }

    @Override
    public void save(Card card) {
        card.setCardNumber(generateCardNumber());
        card.setPincode(bCryptPasswordEncoder.encode(card.getPincode()));
        cardDao.save(card);
    }

    @Override
    public long generateCardNumber() {
        final long min = 1_000_000_000_000_000L;
        final long max = 9_999_999_999_999_999L;

        return min + (long) (Math.random() * (max - min));
    }

    @Override
    public void replenishMoney(Card card, int amount) {
        card.setBalance(card.getBalance() + amount);

        cardDao.update(card);
    }

    @Override
    public boolean withdrawMoney(Card card, int amount) {
        card.setBalance(card.getBalance() - amount);

        if (card.getBalance() < 0) {
            card.setBalance(card.getBalance() + amount);
            return false;
        }

        cardDao.update(card);

        return true;
    }

    @Override
    public Card transferMoney(Card card, String owner, long toCardNumber, int amount) {
        if (withdrawMoney(card, amount)) {
            List<Card> cards = getAllCards(owner);

            Card acceptCard = null;

            for (Card eachCard : cards) {
                if (eachCard.getCardNumber() == toCardNumber)
                    acceptCard = eachCard;
            }

            if (acceptCard != null) {
                replenishMoney(acceptCard, amount);

                return acceptCard;
            }
        }

        return null;
    }

    @Override
    public Card operationValidation(long cardNumber, String ownerEmail, String pincode) {
        List<Card> cards = cardDao.getAllCards(ownerEmail);

        Card card = null;

        for (Card eachCard : cards) {
            if (eachCard.getCardNumber() == cardNumber)
                card = eachCard;
        }

        if (card != null) {
            if (bCryptPasswordEncoder.matches(pincode, card.getPincode())) {
                return card;
            }
        }

        return null;
    }

    @Override
    public List<Card> getAllCards(String ownerEmail) {
        return cardDao.getAllCards(ownerEmail);
    }
}
