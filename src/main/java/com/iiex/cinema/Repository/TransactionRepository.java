//package com.iiex.cinema.Repository;
//
//import com.iiex.cinema.DTO.RevenueMonth;
//import com.iiex.cinema.DTO.TransactionDTO;
//import org.springframework.data.jpa.repository.JpaRepository;
//import org.springframework.data.jpa.repository.query.Procedure;
//import org.springframework.data.repository.query.Param;
//import org.springframework.stereotype.Repository;
//
//
//import java.util.Date;
//import java.util.List;
//
//@Repository
//public interface TransactionRepository extends JpaRepository<TransactionDTO,Long> {
//    @Procedure(name = "get_transactions")
//    List<TransactionDTO> getTransactions();
//
//    @Procedure(name = "get_transaction_by_id")
//    TransactionDTO getTransactionById(@Param("id") Long id);
//
//    @Procedure(name = "get_revenue_of_month")
//    RevenueMonth getRevenueOfMonth(@Param("month_value") Date monthValue);
//}
