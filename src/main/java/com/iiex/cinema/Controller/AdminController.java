package com.iiex.cinema.Controller;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
@RequestMapping("/admin")
public class AdminController {

  @GetMapping("/dashboard")
  public String dashboard(Model model) {
    model.addAttribute("fragmentName", "Movie");
    return "Admin/dashboard";
  }

  @GetMapping("/changepassword")
  public String changePass(Model model) {
    model.addAttribute("fragmentName", "ChangePass");
    return "Admin/dashboard";
  }

  @GetMapping("/staff")
  public String staffManager(Model model) {
    model.addAttribute("fragmentName", "Staff");
    return "Admin/dashboard";
  }
  @GetMapping("/cinema")
  public String cinemaManager(Model model) {
    model.addAttribute("fragmentName", "Cinema");
    return "Admin/dashboard";
  }

  @GetMapping("/showroom")
  public String showRoomManager(Model model) {
    model.addAttribute("fragmentName", "ShowRoom");
    return "Admin/dashboard";
  }


  @GetMapping("/schedule")
  public String scheduleManager(Model model) {
    model.addAttribute("fragmentName", "Schedule");
    return "Admin/dashboard";
  }


  @GetMapping("/movie")
  public String movieManager(Model model) {
    model.addAttribute("fragmentName", "Movie");
    return "Admin/dashboard";
  }
  @GetMapping("/client")
  public String clientManager(Model model) {
    model.addAttribute("fragmentName", "Client");
    return "Admin/dashboard";
  }

  @GetMapping("/combo")
  public String comboManager(Model model) {
    model.addAttribute("fragmentName", "Combo");
    return "Admin/dashboard";
  }
  @GetMapping("/revenue")
  public String revenueManager(Model model) {
    model.addAttribute("fragmentName", "Revenue");
    return "Admin/dashboard";
  }
  @GetMapping("/transaction")
  public String transactionManager(Model model) {
    model.addAttribute("fragmentName", "Transaction");
    return "Admin/dashboard";
  }
}
