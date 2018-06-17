package com.testtask.controller;

import com.testtask.model.User;
import com.testtask.service.user.service.UserService;
import com.testtask.validator.UserValidator;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

@Controller
public class UserController {

    @Autowired
    private UserService userService;

    @Autowired
    private UserValidator userValidator;

    @RequestMapping(value = "/", method = RequestMethod.GET)
    public String loginPage(Model model, HttpServletRequest request) {
        HttpSession session = request.getSession();

        if (session.getAttribute("afterReg") != null) {
            model.addAttribute("message", session.getAttribute("afterReg"));
            session.removeAttribute("afterReg");
        }

        return "login";
    }

    @RequestMapping(value = "/login", method = RequestMethod.POST)
    public ModelAndView login(@RequestParam("email") String userEmail, @RequestParam("password") String password, HttpServletRequest request) {
        User user = userService.loginValidation(userEmail, password);

        if (user == null) {
            return new ModelAndView("login", "error", "Неверный email или пароль");
        }

        HttpSession session = request.getSession();
        session.setAttribute("user", user);

        return new ModelAndView("redirect:/bankPage");
    }


    @RequestMapping(value = "/registration", method = RequestMethod.GET)
    public String registration(Model model) {
        model.addAttribute("user", new User());

        return "registration";
    }

    @RequestMapping(value = "/registration", method = RequestMethod.POST)
    public String registration(@ModelAttribute("user") User user, BindingResult bindingResult, HttpServletRequest request) {
        userValidator.validate(user, bindingResult);

        if (bindingResult.hasErrors()) {
            return "registration";
        }

        userService.save(user);

        HttpSession session = request.getSession();
        session.setAttribute("afterReg", "Теперь вы можете войти");

        return "redirect:/";
    }
}
