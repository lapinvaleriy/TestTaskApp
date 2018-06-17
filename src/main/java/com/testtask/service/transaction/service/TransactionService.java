package com.testtask.service.transaction.service;

import com.testtask.model.Transaction;

import java.util.List;

public interface TransactionService {
    void save(Transaction transaction);

    List<Transaction> getAllTransactions(int cardId);
}
