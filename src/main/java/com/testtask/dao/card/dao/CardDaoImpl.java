package com.testtask.dao.card.dao;

import com.testtask.model.Card;
import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;

@Repository
public class CardDaoImpl implements CardDao {

    @Autowired
    private SessionFactory sessionFactory;

    public void setSessionFactory(SessionFactory sessionFactory) {
        this.sessionFactory = sessionFactory;
    }

    @Override
    @Transactional
    public void save(Card card) {
        Session session = sessionFactory.getCurrentSession();
        session.persist(card);
    }

    @Override
    @Transactional
    public void update(Card card) {
        Session session = sessionFactory.getCurrentSession();
        session.update(card);
    }

    @Override
    @Transactional
    @SuppressWarnings("unchecked")
    public List<Card> getAllCards(String ownerEmail) {
        Session session = sessionFactory.getCurrentSession();

        return session.createQuery("from Card where ownerEmail = \'" + ownerEmail + "\'").list();
    }
}
