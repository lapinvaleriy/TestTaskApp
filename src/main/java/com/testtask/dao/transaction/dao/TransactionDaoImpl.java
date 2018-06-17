package com.testtask.dao.transaction.dao;

import com.testtask.model.Transaction;
import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;

@Repository
public class TransactionDaoImpl implements TransactionDao {

    @Autowired
    private SessionFactory sessionFactory;

    public void setSessionFactory(SessionFactory sessionFactory) {
        this.sessionFactory = sessionFactory;
    }

    @Override
    @Transactional
    public void save(Transaction transaction) {
        Session session = sessionFactory.getCurrentSession();
        session.persist(transaction);
    }

    @Override
    @Transactional
    @SuppressWarnings("unchecked")
    public List<Transaction> getAllTransactions(int cardId) {
        Session session = sessionFactory.getCurrentSession();

        return session.createQuery("from Transaction where cardId = \'" + cardId + "\'").list();
    }
}
