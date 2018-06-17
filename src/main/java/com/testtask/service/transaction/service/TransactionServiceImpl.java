package com.testtask.service.transaction.service;

import com.testtask.dao.transaction.dao.TransactionDao;
import com.testtask.model.Transaction;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class TransactionServiceImpl implements TransactionService {

    @Autowired
    private TransactionDao transactionDao;

    public void setTransactionDao(TransactionDao transactionDao) {
        this.transactionDao = transactionDao;
    }

    @Override
    public void save(Transaction transaction) {
        transactionDao.save(transaction);
    }

    @Override
    public List<Transaction> getAllTransactions(int cardId) {
        return transactionDao.getAllTransactions(cardId);
    }
}
