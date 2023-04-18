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

  @GetMapping("/staff")
  public String staffManager(Model model) {
    model.addAttribute("fragmentName", "Staff");
    return "Admin/dashboard";
  }

  @GetMapping("/theater")
  public String theaterManager(Model model) {
    model.addAttribute("fragmentName", "Theater");
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
}
