package com.iiex.cinema.Controller;

import com.iiex.cinema.DTO.FoodDTO;
import com.iiex.cinema.DTO.ScheduleTodayDTO;
import com.iiex.cinema.DTO.TransactionDTO;
import com.iiex.cinema.Model.*;
import com.iiex.cinema.Service.*;
import com.iiex.cinema.Service.impl.UserServiceImpl;

import java.awt.print.Book;
import java.util.Date;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;


import jakarta.servlet.http.HttpSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

@Controller
@RequestMapping("/")
public class HomeController {

  @Autowired
  private UserServiceImpl userService;

  @Autowired
  private MovieService movieService;

  @Autowired
  private ScheduleService scheduleService;
  @Autowired
  private ComboFoodService comboFoodService;

  @Autowired
  private ShowroomService showroomService;

  @Autowired
  private SeatService seatService;

  @Autowired
  private TicketService ticketService;

  @Autowired
  private TransactionService transactionService;



  @GetMapping
  public String index(Model model) {
    model.addAttribute("fragmentName", "HomePage");
    String username = userService.getCurrentUsername();
    model.addAttribute("username", username);
    List<Movie> ongoing = movieService.findAllIsOnGoing();
    model.addAttribute("ongoing", ongoing);
    return "Client/index";
  }

  @GetMapping("/movie")
  public String movie(Model model) {
    model.addAttribute("fragmentName", "Movie");
    String username = userService.getCurrentUsername();
    model.addAttribute("username", username);
    List<Movie> ongoing = movieService.findAllIsOnGoing();
    model.addAttribute("ongoing", ongoing);
    return "Client/index";
  }

  @GetMapping("/moviedetail/{id}")
  public String movieDetail(@PathVariable Long id, Model model) {
    model.addAttribute("fragmentName", "MovieDetail");
    String username = userService.getCurrentUsername();
    model.addAttribute("username", username);
    List<Movie> ongoing = movieService.findAllIsOnGoing();
    model.addAttribute("ongoing", ongoing);

    Movie movie = movieService.finMovieByID(id);
    model.addAttribute("movie", movie);

    return "Client/index";
  }

  @GetMapping("/seatbooking")
  public String seatBooking( Model model, HttpSession session) {
    model.addAttribute("fragmentName", "SeatBooking");
    String username = userService.getCurrentUsername();
    model.addAttribute("username", username);
    List<Movie> ongoing = movieService.findAllIsOnGoing();
    model.addAttribute("ongoing", ongoing);

    model.addAttribute("session",session);

    return "Client/index";
  }

  @GetMapping("/ticketbooking/{id}")
  public String ticketBooking(@PathVariable Long id, Model model, HttpSession session) {
    model.addAttribute("fragmentName", "TicketBooking");
    String username = userService.getCurrentUsername();
    model.addAttribute("username", username);
    List<Movie> ongoing = movieService.findAllIsOnGoing();
    model.addAttribute("ongoing", ongoing);

    Schedule schedule = scheduleService.finSchedule(id);
    Movie movie = schedule.getMovie();
    session.setAttribute("schedule", id);
    session.setAttribute("showRoomID",schedule.getShowRoom().getId());
    session.setAttribute("movieTitle", movie.getTitle());
    session.setAttribute("moviePoster", movie.getPoster());
    session.setAttribute("startTime", schedule.getStartTime());
    session.setAttribute("cinemaName", schedule.getShowRoom().getCinema().getName());
    session.setAttribute("cinemaAddress", schedule.getShowRoom().getCinema().getAddress());
    session.setAttribute("showRoom", schedule.getShowRoom().getShowroom_number());
    session.setAttribute("price", schedule.getPrice());
    model.addAttribute("session",session);
    return "Client/index";
  }

  @GetMapping("/combobooking")
  public String comboBooking( Model model, HttpSession session) {
    model.addAttribute("fragmentName", "ComboBooking");
    String username = userService.getCurrentUsername();
    model.addAttribute("username", username);
    List<Movie> ongoing = movieService.findAllIsOnGoing();
    model.addAttribute("ongoing", ongoing);

    List<ComboFood> comboFoods = comboFoodService.findAllComboFood();
    model.addAttribute("combo", comboFoods);
    model.addAttribute("session",session);

    return "Client/index";
  }
  @GetMapping("/confirmbooking")
  public String confirmBooking( Model model, HttpSession session) {
    model.addAttribute("fragmentName", "ConfirmBooking");
    String username = userService.getCurrentUsername();
    model.addAttribute("username", username);
    List<Movie> ongoing = movieService.findAllIsOnGoing();
    model.addAttribute("ongoing", ongoing);

    model.addAttribute("session",session);

    return "Client/index";
  }
  @GetMapping("/successbooking")
  public String successBooking( Model model, HttpSession session) {
    model.addAttribute("fragmentName", "SuccessBooking");
    String username = userService.getCurrentUsername();
    model.addAttribute("username", username);
    List<Movie> ongoing = movieService.findAllIsOnGoing();
    model.addAttribute("ongoing", ongoing);
    model.addAttribute("session",session);
    User user = userService.findByEmail(username);
    ShowRoom showRoom =  showroomService.findShowroomByID((Long) session.getAttribute("showRoomID"));
    Schedule schedule = scheduleService.finSchedule((Long) session.getAttribute("schedule"));
    Date currentDate = new Date();
    Booking booking = new Booking();
    booking.setFood_price(0);
    booking.setTicket_price(0);
    booking.setUser(user);
    booking.setCreated_at(currentDate);
    booking = transactionService.save(booking);
    List<String> seats = (List<String>) session.getAttribute("seats");
    for (String seat: seats
         ) {
          Seat seat1 = seatService.getByShowRoomAndSeatNumber(showRoom,seat);
          Ticket ticket = ticketService.findByScheduleAndSeat(schedule,seat1);
          ticket.setBooking(booking);
          ticketService.save(ticket);
    }

    List<String> foodS = (List<String>) session.getAttribute("foods");
    for (String food_id :
            foodS) {
            ComboFood comboFood = comboFoodService.findComboFoodByID(Long.valueOf(food_id));
            List<Booking> bookings = (List<Booking>) comboFood.getBookings();
            bookings.add(booking);
            comboFood.setBookings(bookings);
            comboFoodService.saveComboFood(comboFood);
    }

    return "Client/index";
  }

  @GetMapping("/showtime")
  public String showTime( Model model) {
    model.addAttribute("fragmentName", "ShowTime");
    String username = userService.getCurrentUsername();
    model.addAttribute("username", username);
    List<Movie> ongoing = movieService.findAllIsOnGoing();
    model.addAttribute("ongoing", ongoing);

    List<ScheduleTodayDTO> schedulesToday = scheduleService.getScheduleToday();

    model.addAttribute("schedules", schedulesToday);

    return "Client/index";
  }

  @GetMapping("/profile")
  public String proFile( Model model) {
    model.addAttribute("fragmentName", "Profile");
    String username = userService.getCurrentUsername();
    model.addAttribute("username", username);
    User user = userService.findByEmail(username);

    model.addAttribute("user", user);
    return "Client/Profile/index";
  }
  @GetMapping("/bookinghistory")
  public String bookinghistory( Model model) {
    model.addAttribute("fragmentName", "BookingHistory");
    String username = userService.getCurrentUsername();
    model.addAttribute("username", username);
    User user = userService.findByEmail(username);

    List<TransactionDTO> transactionDTOS = transactionService.getAllTransactionByUser(user);

    model.addAttribute("transactions", transactionDTOS);


    return "Client/Profile/index";
  }

  @GetMapping("/changepassword")
  public String changePass( Model model) {
    model.addAttribute("fragmentName", "Changepass");
    String username = userService.getCurrentUsername();
    model.addAttribute("username", username);
    User user = userService.findByEmail(username);



    return "Client/Profile/index";
  }

}
