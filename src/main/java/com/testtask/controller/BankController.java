package com.testtask.controller;

import com.testtask.model.Card;
import com.testtask.model.Transaction;
import com.testtask.model.User;
import com.testtask.service.card.service.CardService;
import com.testtask.service.transaction.service.TransactionService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import java.util.List;

@Controller
public class BankController {

    @Autowired
    private CardService cardService;

    @Autowired
    private TransactionService transactionService;

    @RequestMapping(value = "/bankPage")
    public String listCards(Model model, HttpServletRequest request) {
        User user = getUserBySession(request);

        if (user == null) {
            return "redirect:/";
        }

        List<Card> cardList = cardService.getAllCards(user.getEmail());

        model.addAttribute("cardList", cardList);
        model.addAttribute("userName", user.getName());

        return "bankPage";
    }

    public User getUserBySession(HttpServletRequest request) {
        HttpSession session = request.getSession();

        return (User) session.getAttribute("user");
    }

    @RequestMapping(value = "/bankPage/addcard", method = RequestMethod.POST)
    public String addCard(@RequestParam("cardName") String cardName, @RequestParam("pincode") String pincode, HttpServletRequest request) {
        Card card = new Card();

        User user = getUserBySession(request);

        card.setName(cardName);
        card.setPincode(pincode);
        card.setOwnerEmail(user.getEmail());
        card.setBalance(0);

        cardService.save(card);

        return "redirect:/bankPage";
    }

    @RequestMapping(value = "/replenish", method = RequestMethod.GET)
    public ModelAndView replenishPage(HttpServletRequest request) {
        User user = getUserBySession(request);

        List<Card> cardList = cardService.getAllCards(user.getEmail());

        return new ModelAndView("replenishCard", "cardList", cardList);
    }

    @RequestMapping(value = "/withdraw", method = RequestMethod.GET)
    public ModelAndView withdrawPage(HttpServletRequest request) {
        User user = getUserBySession(request);

        List<Card> cardList = cardService.getAllCards(user.getEmail());

        return new ModelAndView("withdrawCard", "cardList", cardList);
    }

    @RequestMapping(value = "/transfer", method = RequestMethod.GET)
    public ModelAndView transferPage(HttpServletRequest request) {
        User user = getUserBySession(request);

        List<Card> cardList = cardService.getAllCards(user.getEmail());

        return new ModelAndView("transferCard", "cardList", cardList);
    }

    @RequestMapping(value = "/bankPage/replenish", method = RequestMethod.POST)
    public ModelAndView replenishCard(HttpServletRequest request, @RequestParam("cardNumber") String cardNumber, @RequestParam("pincode") String pincode, @RequestParam("amount") int amount) {
        User user = getUserBySession(request);

        Card card = cardService.operationValidation(Long.parseLong(cardNumber), user.getEmail(), pincode);

        if (card != null) {
            cardService.replenishMoney(card, amount);
            transactionService.save(new Transaction(card.getId(), "Пополнение", amount));
        }

        if (card == null) {
            ModelAndView modelAndView = new ModelAndView("replenishCard");
            modelAndView.addObject("error", "Неправильный пинкод");

            List<Card> cardList = cardService.getAllCards(user.getEmail());

            modelAndView.addObject("cardList", cardList);

            return modelAndView;
        }

        return new ModelAndView("redirect:/bankPage");
    }

    @RequestMapping(value = "/bankPage/withdraw", method = RequestMethod.POST)
    public ModelAndView withdrawCard(HttpServletRequest request, @RequestParam("cardNumber") String cardNumber, @RequestParam("pincode") String pincode, @RequestParam("amount") int amount) {
        User user = getUserBySession(request);

        Card card = cardService.operationValidation(Long.parseLong(cardNumber), user.getEmail(), pincode);

        String error = null;

        if (card == null)
            error = "Неправильный пинкод";

        if (card != null) {
            if (cardService.withdrawMoney(card, amount)) {
                transactionService.save(new Transaction(card.getId(), "Снятие", amount));
                return new ModelAndView("redirect:/bankPage");
            } else {
                error = "Нехватка средств на счету";
            }
        }

        List<Card> cardList = cardService.getAllCards(user.getEmail());

        ModelAndView modelAndView = new ModelAndView("withdrawCard");
        modelAndView.addObject("error", error);
        modelAndView.addObject("cardList", cardList);

        return modelAndView;
    }

    @RequestMapping(value = "/bankPage/transfer", method = RequestMethod.POST)
    public ModelAndView transferCard(HttpServletRequest request, @RequestParam("cardNumber") String cardNumber, @RequestParam("toCard") String toCardNumber,
                                     @RequestParam("pincode") String pincode, @RequestParam("amount") int amount) {
        User user = getUserBySession(request);

        toCardNumber = toCardNumber.replaceAll(" ", "");

        Card card = cardService.operationValidation(Long.parseLong(cardNumber), user.getEmail(), pincode);

        List<Card> cardList = cardService.getAllCards(user.getEmail());

        ModelAndView modelAndView = new ModelAndView("transferCard");
        modelAndView.addObject("cardList", cardList);

        String error = null;

        if (card == null) {
            error = "Неправильный пинкод";
            modelAndView.addObject("error", error);
            return modelAndView;
        }

        if (card.getBalance() < amount) {
            error = "Нехватка денег на счету";
            modelAndView.addObject("error", error);
            return modelAndView;
        }

        Card recieveCard = cardService.transferMoney(card, user.getEmail(), Long.parseLong(toCardNumber), amount);

        if (recieveCard != null) {
            transactionService.save(new Transaction(card.getId(), "Перевод", amount));
            transactionService.save(new Transaction(recieveCard.getId(), "Пополнение", amount));
        } else {
            transactionService.save(new Transaction(card.getId(), "Перевод", amount));
        }

        return new ModelAndView("redirect:/bankPage");
    }

    @RequestMapping(value = "/history", method = RequestMethod.GET)
    public ModelAndView showHistory(@RequestParam int id) {
        List<Transaction> allTransactions = transactionService.getAllTransactions(id);

        return new ModelAndView("transactionsPage", "transList", allTransactions);
    }
}
