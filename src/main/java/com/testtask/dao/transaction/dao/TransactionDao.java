package com.testtask.dao.transaction.dao;

import com.testtask.model.Transaction;

import java.util.List;

public interface TransactionDao {
    void save(Transaction transaction);

    List<Transaction> getAllTransactions(int cardId);
}
