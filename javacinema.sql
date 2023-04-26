    -- phpMyAdmin SQL Dump
    -- version 5.2.0
    -- https://www.phpmyadmin.net/
    --
    -- Host: 127.0.0.1
    -- Generation Time: Apr 16, 2023 at 04:43 PM
    -- Server version: 10.4.27-MariaDB
    -- PHP Version: 8.2.0

    SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
    START TRANSACTION;
    SET time_zone = "+00:00";


    /*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
    /*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
    /*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
    /*!40101 SET NAMES utf8mb4 */;

    --
    -- Database: `javacinema`
    --

    DELIMITER $$
    --
    -- Procedures
    --
    CREATE DEFINER=`root`@`localhost` PROCEDURE `create_schedule` (IN `p_theaterID` INT, IN `p_movieID` INT, IN `p_startTime` DATETIME, IN `p_endTime` DATETIME, IN `p_price` DOUBLE)   BEGIN
    Select THEATER.seat_count Into @seatCount from THEATER where ID =  p_theaterID;
        INSERT INTO `SCHEDULE`
               (`THEATER_ID`
               ,`MOVIE_ID`
               ,`START_TIME`
               ,`END_TIME`)
         VALUES
               (p_theaterID
               ,p_movieID
               ,p_startTime
               ,p_endTime);

        SELECT MIN(SEAT.ID) INTO @counter from SEAT JOIN THEATER ON THEATER.ID = SEAT.THEATER_ID
        WHERE THEATER.ID = p_theaterID
        LIMIT 1;


        SET @schedule_id = LAST_INSERT_ID();

       SET @seatCount = @seatCount+@counter;

            WHILE @counter < @seatCount
        DO
            -- SQLINES LICENSE FOR EVALUATION USE ONLY
            INSERT INTO `TICKET`
               (`BOOKING_ID`
               ,`PRICE`
               ,`schedule_id`
               ,`seat_id`
               ,`booked`)
            VALUES
               (null
               ,p_price
               ,@schedule_id
               ,@counter
               ,0);
            SET @ticket_id  = LAST_INSERT_ID();

            SET @counter = @counter + 1;
        END WHILE;
    END$$

    CREATE DEFINER=`root`@`localhost` PROCEDURE `create_theater` (IN `theater_num` INT, IN `seat_count` INT)   BEGIN
      -- Tạo rạp chiếu phim mới
      INSERT INTO `showRoom` (`THEATER_NUMBER`, `SEAT_COUNT`, `IS_SHOWING`)
      VALUES (theater_num, seat_count, 0);

      -- Lấy ID của rạp chiếu phim mới
      SET @theater_id = LAST_INSERT_ID();

      -- Tạo các ghế Standard trong rạp chiếu phim
      SET @Standard_count = FLOOR(seat_count / 3);
      SET @Standard_count = @Standard_count + @Standard_count;
      SET @seat_num = 1;
      WHILE @seat_num <= @Standard_count DO
        INSERT INTO `seat` (`THEATER_ID`, `SEAT_NUMBER`, `SEAT_TYPE`)
        VALUES (@theater_id, @seat_num, 'Standard');
        SET @seat_num = @seat_num + 1;
      END WHILE;

      -- Tạo các ghế Couple trong rạp chiếu phim
      SET @couple_count = FLOOR(seat_count / 3);
      SET @couple_seat_num = seat_count - @couple_count + 1;
      WHILE @couple_seat_num <= seat_count DO
        INSERT INTO `seat` (`THEATER_ID`, `SEAT_NUMBER`, `SEAT_TYPE`)
        VALUES (@theater_id, @couple_seat_num, 'Couple');
        SET @couple_seat_num = @couple_seat_num + 1;
      END WHILE;
    END$$

    CREATE DEFINER=`root`@`localhost` PROCEDURE `get_schedule_by_theater` (IN `theater_id` INT)   SELECT movie.TITLE, movie.DURATION,schedule.* ,  showRoom.SEATCOUNT, COUNT(ticket_seat_schedule.TICKET_ID) AS EMPTYSEAT
    FROM schedule, showRoom, ticket_seat_schedule, movie
    WHERE schedule.THEA_ID = showRoom.ID
    AND schedule.ID = ticket_seat_schedule.SCHEDULE_ID
    AND movie.ID = schedule.MOVIE_ID
    AND ticket_seat_schedule.BOOKED  = 0
    AND showRoom.ID = theater_id
    GROUP BY schedule.ID$$

    CREATE DEFINER=`root`@`localhost` PROCEDURE `get_schedule_today` ()   SELECT schedule.ID,movie.ID as MID, movie.TITLE, movie.POSTER, movie.STORY, GROUP_CONCAT(TIME(schedule.STARTTIME)) AS TIME, DATE(schedule.STARTTIME) as DAY FROM schedule JOIN movie ON movie.ID = schedule.MOVIE_ID WHERE now()< schedule.STARTTIME AND DATE(now()) = DATE(schedule.STARTTIME) GROUP BY MID$$

    CREATE DEFINER=`root`@`localhost` PROCEDURE `get_trailers` ()   SELECT id, trailer FROM movie WHERE LENGTH(trailer) > 1 LIMIT 10$$

    CREATE DEFINER=`root`@`localhost` PROCEDURE `isValidSchedule` (IN `stime` DATETIME, IN `theater_num` INT)   SELECT * FROM `schedule`
    WHERE stime BETWEEN STARTTIME AND ENDTIME
    AND theater_ID = theater_num$$

    CREATE DEFINER=`root`@`localhost` PROCEDURE `ongoing_movies` ()   SELECT * FROM movie
    WHERE CURDATE() BETWEEN OPENING_DAY AND CLOSING_DAY
    ORDER by OPENING_DAY ASC$$

    CREATE DEFINER=`root`@`localhost` PROCEDURE `upcoming_movies` ()   SELECT * FROM movie WHERE opening_day > CURDATE() ORDER BY opening_day ASC LIMIT 10$$

    DELIMITER ;

    -- --------------------------------------------------------

    --
    -- Table structure for table `booking`
    --

    CREATE TABLE `booking` (
      `ID` int(11) NOT NULL,
      `USER_ID` int(11) DEFAULT NULL,
      `CREATED_AT` datetime NOT NULL
    ) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

    -- --------------------------------------------------------

    --
    -- Table structure for table `foodcombo`
    --

    CREATE TABLE `foodcombo` (
      `ID` int(11) NOT NULL,
      `NAME` varchar(50) DEFAULT NULL,
      `PRICE` float DEFAULT NULL
    ) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

    -- --------------------------------------------------------

    --
    -- Table structure for table `food_booking`
    --

    CREATE TABLE `food_booking` (
      `FOOD_ID` int(11) NOT NULL,
      `BOOKING_ID` int(11) NOT NULL
    ) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

    -- --------------------------------------------------------

    --
    -- Table structure for table `movie`
    --

    CREATE TABLE `movie` (
      `ID` int(11) NOT NULL,
      `TITLE` text DEFAULT NULL,
      `Director` text NOT NULL,
      `Actors` text NOT NULL,
      `GENRE` text DEFAULT NULL,
      `DURATION` int(11) DEFAULT NULL,
      `RATING` float DEFAULT NULL,
      `STORY` text DEFAULT NULL,
      `POSTER` text DEFAULT NULL,
      `TRAILER` longtext DEFAULT NULL,
      `OPENING_DAY` date DEFAULT NULL,
      `CLOSING_DAY` date DEFAULT NULL
    ) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

    --
    -- Dumping data for table `movie`
    --

    INSERT INTO `movie` (`ID`, `TITLE`, `Director`, `Actors`, `GENRE`, `DURATION`, `RATING`, `STORY`, `POSTER`, `TRAILER`, `OPENING_DAY`, `CLOSING_DAY`) VALUES
    (1, 'MY BEAUTIFUL MAN MOVIE: SPECIAL EDITION', '', 'Riku Hagiwara, Yusei Yagi', 'Drama', 132, 5, 'Hira, 17 tuổi, cố gắng ẩn mình ở trường, không bao giờ muốn phơi bày tật nói lắp của mình với các bạn cùng lớp. Anh ấy nhìn thế giới qua ống kính máy ảnh của mình, cho đến một ngày Kiyoi Sou bước qua cửa lớp...', 'http://booking.bhdstar.vn/CDN/media/entity/get/FilmPosterGraphic/HO00002651?referenceScheme=HeadOffice&allowPlaceHolder=true&height=500', '', '2023-04-14', '2023-06-20'),
    (2, 'RENFIELD', 'Chris McKay', 'Nicolas  Cage, Nicholas Hoult', 'Horror', 92, 5, 'Renfield bị buộc phải bắt con mồi về cho chủ nhân và thực hiện mọi mệnh lệnh, kể cả những việc nhục nhã. Nhưng giờ đây, sau nhiều thế kỷ làm nô lệ, Renfield đã sẵn sàng để khám phá cuộc sống bên ngoài cái bóng của Hoàng Tử Bóng Đêm...', 'http://booking.bhdstar.vn/CDN/media/entity/get/FilmPosterGraphic/HO00002656?referenceScheme=HeadOffice&allowPlaceHolder=true&height=500', 'https://www.youtube.com/watch?v=_hO0vGwqClM', '2023-04-14', '2023-06-20'),
    (3, 'THE POPES EXORCIST', 'Julius Avery', 'Russell Crowe, Daniel Zovatto', 'Horror', 104, 5, 'Từ những hồ sơ có thật của Cha Gabriele Amorth, Trưởng Trừ Tà của Vatican, \"The Popes Exorcist\" theo chân Amorth trong cuộc điều tra về vụ quỷ ám kinh hoàng của một cậu bé và dần khám phá ra những bí mật hàng thế kỉ mà Vatican đã cố giấu kín...', 'http://booking.bhdstar.vn/CDN/media/entity/get/FilmPosterGraphic/HO00002665?referenceScheme=HeadOffice&allowPlaceHolder=true&height=500', '', '2023-04-14', '2023-06-20'),
    (4, 'AIR', 'Ben  Affleck', 'Viola Davis', 'Drama', 112, 5, 'Bí mật trong mối quan hệ hợp tác lịch sử giữa Nike và một vận động viên bóng rổ vĩ đại.Cả hai đã cho ra mắt thương hiệu Air Jordan đình đám và theo chân Sonny Vaccaro- saleman của Nike trong hành trình tiếp cận và đánh cược cả sự nghiệp vào Michael Jordan', 'http://booking.bhdstar.vn/CDN/media/entity/get/FilmPosterGraphic/HO00002670?referenceScheme=HeadOffice&allowPlaceHolder=true&height=500', '', '2023-04-14', '2023-06-20'),
    (5, 'NGƯỜI GIỮ THỜI GIAN : TRI ÂM ', 'MỸ TÂM', 'Ca sĩ Mỹ Tâm', 'Musical', 106, 5, 'Mỹ Tâm sẽ phác họa chân thực toàn bộ những diễn biến tâm lý và cảm xúc thăng trầm cùng những thăng hoa trong suốt quá trình thực hiện Liveshow \"Tri Âm\" lịch sử bằng những thước phim quý giá được quay lại trong 2 năm...', 'http://booking.bhdstar.vn/CDN/media/entity/get/FilmPosterGraphic/HO00002663?referenceScheme=HeadOffice&allowPlaceHolder=true&height=500', 'https://www.youtube.com/watch?v=8BdO_M8bUZo', '2023-04-08', '2023-06-20'),
    (6, 'YOU & ME & ME ', 'Waew Waewwan Hongvivatana', 'Baipor Thitiya Jirapornsilp, Tony Anthony Buisseret', 'Drama', 121, 5, 'Hai chị em sinh đôi \"You\" và \"Me\"có ngoại hình và sở thích giống hệt nhau,thân thiết đến mức họ có thể chia sẻ mọi khía cạnh trong cuộc sống,cho đến khi một cậu bé - \"mối tình đầu\" của họ xuất hiện và đặt ra những thử thách khó khăn cho mối quan hệ của họ', 'http://booking.bhdstar.vn/CDN/media/entity/get/FilmPosterGraphic/HO00002669?referenceScheme=HeadOffice&allowPlaceHolder=true&height=500', '', '2023-04-07', '2023-06-20'),
    (7, 'ASSASSIN CLUB', 'Camille Delamarre', 'Henry Golding, Noomi Repace', 'Action', 109, 5, 'Bảy tên sát thủ vô tình bị thiết lập trong một trò chơi sống còn. Morgan Gaines- một sát thủ chuyên nghiệp có nhiệm vụ phải giết bảy người,Morgan phát hiện ra bảy \"mục tiêu\" cũng là bảy sát thủ nặng ký. Lối thoát duy nhất cho Morgan là tìm ra kẻ chủ mưu..', 'http://booking.bhdstar.vn/CDN/media/entity/get/FilmPosterGraphic/HO00002661?referenceScheme=HeadOffice&allowPlaceHolder=true&height=500', 'https://www.youtube.com/watch?v=usYcScx3yMk', '2023-04-07', '2023-06-20'),
    (8, 'MARRY MY DEAD BODY ', 'Wei Hao Cheng', 'Greg Han Hsu, Gingle Wang', 'Drama', 130, 5, 'Ming-Han, một sĩ quan cảnh sát nhiệt huyết, trong quá trình truy bắt tội phạm đã tìm thấy một phong bì cưới màu đỏ và chủ nhân của nó là hồn ma Mao-Mao với nguyện vọng phải được kết hôn với một sĩ quan cảnh sát trước khi tái sinh...', 'http://booking.bhdstar.vn/CDN/media/entity/get/FilmPosterGraphic/HO00002654?referenceScheme=HeadOffice&allowPlaceHolder=true&height=500', '', '2023-04-07', '2023-06-20'),
    (9, 'THE SUPER MARIO BROS. MOVIE', 'Aaron Horvath', 'Chris Pratt, Anya Taylor-Joy', 'Animation', 93, 5, 'Theo chân anh chàng thợ sửa ống nước tên Mario cùng công chúa Peach của Vương quốc Nấm trong cuộc phiêu lưu giải cứu anh trai Luigi đang bị bắt cóc và ngăn chặn tên độc tài Bowser, kẻ đang âm mưu thôn tính thế giới', 'http://booking.bhdstar.vn/CDN/media/entity/get/FilmPosterGraphic/HO00002631?referenceScheme=HeadOffice&allowPlaceHolder=true&height=500', 'https://www.youtube.com/watch?v=wODah30-agA', '2023-04-07', '2023-06-20'),
    (10, 'BIỆT ĐỘI RẤT ỔN', 'Tạ Nguyên Hiệp', 'Võ Tấn Phát, Hoàng  Oanh', 'Comedy', 104, 5, 'Xoay quanh bộ đôi Khuê và Phong. Sau lần chạm trán tình cờ, bộ đôi lôi kéo gia đình Bảy Cục tham gia vào phi vụ đặc biệt: Đánh tráo chiếc vòng đính hôn bằng kim cương quí giá và lật tẩy bộ mặt thật của Tuấn-chồng cũ của Khuê...', 'http://booking.bhdstar.vn/CDN/media/entity/get/FilmPosterGraphic/HO00002633?referenceScheme=HeadOffice&allowPlaceHolder=true&height=500', 'https://www.youtube.com/watch?v=6qZbBiL65cI', '2023-03-31', '2023-06-20'),
    (11, 'THE ONE', 'Dmitriy Suvorov', 'Nadezhda Kaleganova, Viktor Dobronravov', 'Drama', 96, 5, 'Cặp vợ chồng mới cưới Larisa và Vladimir trở về nhà từ tuần trăng mật ở Blagoveshchensk và bị va chạm máy bay, Larisa phải vật lộn với cái đói cái lạnh và động vật hoang dã săn mồi. Liệu Larisa có tìm được vị hôn phu và cùng sống sót trở về ?', 'http://booking.bhdstar.vn/CDN/media/entity/get/FilmPosterGraphic/HO00002580?referenceScheme=HeadOffice&allowPlaceHolder=true&height=500', '', '2023-03-31', '2023-06-20'),
    (12, 'PULAU ', 'Eu  Ho', 'Amelia Henderson, Alif Satar', 'Horror', 112, 5, 'Kỳ nghỉ của nhóm bạn trẻ biến thành cơn ác mộng kinh hoàng sau khi họ thua một cuộc cá cược,họ buộc phải qua đêm tại một đảo hoang, khi tình cờ đến một ngôi làng bị bỏ hoang bí ẩn ở đó, họ đã phá vỡ câu thần chú cũ được đặt để kiềm chế một linh hồn tàn ác', 'http://booking.bhdstar.vn/CDN/media/entity/get/FilmPosterGraphic/HO00002673?referenceScheme=HeadOffice&allowPlaceHolder=true&height=500', '', '2023-03-31', '2023-06-20'),
    (13, 'SOULMATE', 'Young-Keun Min', 'Kim Da-Mi, Woo-Seok Byeon', 'Drama', 124, 5, 'Mi So và Ha Eun trong một mối quan hệ chồng chéo chất chứa những hạnh phúc, rung động và biệt ly. Từ giây phút gặp nhau , hai cô gái đã hình thành sợi dây liên kết đặc biệt nhưng mối quan hệ của họ rạn nứt khi một chàng trai xuất hiện...', 'http://booking.bhdstar.vn/CDN/media/entity/get/FilmPosterGraphic/HO00002611?referenceScheme=HeadOffice&allowPlaceHolder=true&height=500', 'https://www.youtube.com/watch?v=pGAFcV97dpw', '2023-03-24', '2023-06-20'),
    (14, 'NHỮNG ĐỨA TRẺ TRONG SƯƠNG', 'Hà Lệ Diễm', 'Má Thị Di', 'Documentary', 93, 5, 'Di, một cô gái trẻ nhiệt huyết đến từ cộng đồng người Mông bị mắc kẹt giữa truyền thống \"kéo vợ\" và mong muốn được tiếp tục sống thời thơ ấu và đến trường đi học , liệu với trái tim trong sáng ấy , Di sẽ đối diện với xã hội ấy như thế nào...?\r\n', 'http://booking.bhdstar.vn/CDN/media/entity/get/FilmPosterGraphic/HO00002676?referenceScheme=HeadOffice&allowPlaceHolder=true&height=500', '', '2023-03-17', '2023-06-20'),
    (15, 'SIÊU LỪA GẶP SIÊU LẦY', 'Võ Thanh Hòa', 'Mạc Văn Khoa, Anh Tú', 'Comedy', 112, 5, 'Khoa, một tên lừa đảo tới Phú Quốc với mục tiêu đổi đời. Không ngờ đây là sân nhà của Tú, một tên lừa đảo chuyên nghiệp, cả hai bắt tay cùng thực hiện một phi vụ siêu lớn và mục tiêu là các quý bà giàu có và đam mê sự nổi tiếng', 'http://booking.bhdstar.vn/CDN/media/entity/get/FilmPosterGraphic/HO00002593?referenceScheme=HeadOffice&allowPlaceHolder=true&height=500', 'https://www.youtube.com/watch?v=xy8RznX_uyM', '2023-03-03', '2023-06-20'),
    (16, 'THE FIRST SLAM DUNK', 'Takehiko  Inoue', 'Masaya Fukunishi, Yoshiaki Hasegawa', 'Animation', 124, 5, '\"Hanamichi Sakuragi\" bắt đầu quan tâm đến một cô gái tên  \"Haruko\",người yêu thích bóng rổ.Vì thế cậu quyêt định tham gia Câu lạc bộ bóng rổ trường trung học Shohoku và tài năng của cậu nhanh chóng phát triển sau những trận đấu', 'http://booking.bhdstar.vn/CDN/media/entity/get/FilmPosterGraphic/HO00002640?referenceScheme=HeadOffice&allowPlaceHolder=true&height=500', 'https://www.youtube.com/watch?v=8x7-46aDmHQ', '2022-02-13', '2023-06-20'),
    (17, 'BEARMAN', 'Park Sung-kwang', 'Park Sung-woong, Lee Yi-kyung', 'Comedy', 97, 5, 'Dựa trên thần thoại dân gian Hàn Quốc về cặp gấu song sinh hoá thành người sau khi ăn tỏi và ngải cứu, phim kể câu chuyện về Woong-Nam, người đối đầu với một tổ chức tội phạm quốc tế với khả năng bẩm sinh đầy thú tính... vượt xa con người', 'http://booking.bhdstar.vn/CDN/media/entity/get/FilmPosterGraphic/HO00002675?referenceScheme=HeadOffice&allowPlaceHolder=true&height=500', '', '2023-04-21', '2023-06-20'),
    (18, 'CHUYỆN XÓM TUI : CON NHÓT MÓT CHỒNG', 'Vũ  Ngọc Đãng', 'Thái Hòa, Thu  Trang', '', 100, 5, 'Là câu chuyện của Nhót - Người phụ nữ \"chưa kịp già\" đã sắp bị mãn kinh, vội vàng đi tìm chồng. Nhưng sâu thẳm trong cô là khao khát muốn có một đứa con và luôn muốn hàn gắn với người cha suốt ngày say xỉn của mình', 'http://booking.bhdstar.vn/CDN/media/entity/get/FilmPosterGraphic/HO00002650?referenceScheme=HeadOffice&allowPlaceHolder=true&height=500', 'https://www.youtube.com/watch?v=qehxOMR-rFQ', '2023-04-28', '2023-06-20'),
    (19, 'DUNGEONS & DRAGONS: HONOR AMONG THIEVES ', 'John Francis Daley', 'Chris Pine, Michelle Rodriguez', 'Adventure', 134, 5, 'Theo chân một tên trộm quyến rũ và một nhóm những kẻ bịp bợm nghiệp dư thực hiện vụ trộm sử thi nhằm lấy lại một di vật đã mất, nhưng mọi thứ trở nên nguy hiểm khó lường hơn bao giờ hết khi họ đã chạm trám nhầm người...', 'http://booking.bhdstar.vn/CDN/media/entity/get/FilmPosterGraphic/HO00002629?referenceScheme=HeadOffice&allowPlaceHolder=true&height=500', 'https://www.youtube.com/watch?v=iTZJ-uwIZxg', '2023-04-21', '2023-06-20'),
    (20, 'ELEMENTAL', 'Peter Sohn', 'Leah Lewis, Mamoudou Athie', 'Animation', 93, 5, 'Ember, một cô nàng cá tính, thông minh, mạnh mẽ và đầy sức hút. Tuy nhiên mối quan hệ của cô với Wade- một anh chàng hài hước, luôn thuận thế đẩy dòng - khiến Ember cảm thấy ngờ vực với thế giới này...', 'http://booking.bhdstar.vn/CDN/media/entity/get/FilmPosterGraphic/HO00002677?referenceScheme=HeadOffice&allowPlaceHolder=true&height=500', 'https://www.youtube.com/watch?v=K19bf6ButD4', '2023-06-16', '2023-06-20'),
    (21, 'FAST & FURIOUS X', '', 'Vin  Diesel', '', 93, 5, 'Dom Toretto và gia đình của anh ấy bị trở thành mục tiêu của người con trai đầy thù hận của ông trùm ma túy Hernan Reyes', 'http://booking.bhdstar.vn/CDN/media/entity/get/FilmPosterGraphic/HO00002671?referenceScheme=HeadOffice&allowPlaceHolder=true&height=500', 'https://www.youtube.com/watch?v=nIXKtldz5Yk', '2023-05-19', '2023-06-20'),
    (22, 'GUARDIANS OF THE GALAXY 3', 'James  Gunn', 'Chris  Pratt, Zoe Saldana', 'Adventure', 119, 5, 'Cho dù vũ trụ này có bao la đến đâu, các Vệ Binh của chúng ta cũng không thể trốn chạy mãi mãi...', 'http://booking.bhdstar.vn/CDN/media/entity/get/FilmPosterGraphic/HO00002647?referenceScheme=HeadOffice&allowPlaceHolder=true&height=500', 'https://www.youtube.com/watch?v=Pp6reH8bpZ8', '2023-05-03', '2023-06-20'),
    (23, 'LẬT MẶT 6', 'Lý  Hải', 'Duy Khánh, Quốc Cường', 'Action', 132, 5, 'Nhóm bạn thân lâu năm bất ngờ nhận được cơ hội đổi đời khi biết tấm vé của cả nhóm trúng giải độc đắc 136.8 tỷ. Đột nhiên An,người giữ tấm vé bất ngờ qua đời, liệu trong hành trình tìm kiếm và chia chác món tiền trong mơ béo bở này sẽ đưa cả nhóm đến đâu?', 'http://booking.bhdstar.vn/CDN/media/entity/get/FilmPosterGraphic/HO00002653?referenceScheme=HeadOffice&allowPlaceHolder=true&height=500', 'https://www.youtube.com/watch?v=tpjjd7usfnA', '2023-04-28', '2023-06-20'),
    (24, 'SOUND OF SILENCE', 'Alessandro Antonaci', 'Daniel Lascar', 'Horror', 93, 5, 'Trở về nhà sau mất mát của cha mẹ, Emma vô tình giải phóng những linh hồn quá khứ mắc kẹt trong chiếc radio cổ. Vô số câu chuyện bí ẩn lần lượt được vạch trần, liệu Emma sẽ tỉnh táo đối mặt hay cô sẽ bị nhấn chìm bởi quỹ dữ ?', 'http://booking.bhdstar.vn/CDN/media/entity/get/FilmPosterGraphic/HO00002666?referenceScheme=HeadOffice&allowPlaceHolder=true&height=500', '', '2023-04-21', '2023-06-20'),
    (25, 'SPIDER-MAN: ACROSS THE SPIDER-VERSE', '', '', 'Animation', 92, 5, 'Miles Morales đến Đa vũ trụ, nơi anh chạm trán với một nhóm Người Nhện chịu trách nhiệm bảo vệ sự tồn tại của họ. Khi các anh hùng xung đột về cách đối phó với mối đe dọa mới, Miles phải xác định lại ý nghĩa của việc trở thành anh hùng...', 'http://booking.bhdstar.vn/CDN/media/entity/get/FilmPosterGraphic/HO00002632?referenceScheme=HeadOffice&allowPlaceHolder=true&height=500', 'https://www.youtube.com/watch?v=bbXAJNvJJGw&t=33s', '2023-06-02', '2023-06-20'),
    (26, 'THE COVENANT', 'Guy Ritchie', 'Jake Gyllenhaal, Dar Salim', 'Action', 98, 5, 'Theo chân Trung sĩ Kinley và thông dịch viên Ahmed. Sau một cuộc phục kích, Ahmed đã dốc hết sức lực để cứu mạng Kinley. Khi Kinley biết Ahmed cùng gia đình không được đưa đến Mỹ an toàn như đã hứa , anh đã quyết định quay lại chiến sự để cứu họ', 'http://booking.bhdstar.vn/CDN/media/entity/get/FilmPosterGraphic/HO00002658?referenceScheme=HeadOffice&allowPlaceHolder=true&height=500', '', '2023-04-21', '2023-06-20'),
    (27, 'THE FLASH ', 'Andy  Muschietti', 'Ben  Affleck, Michael Shannon', 'Action', 120, 5, 'Mùa hè này, đa thế giới sẽ va chạm khốc liệt với những bước chạy của FLASH', 'http://booking.bhdstar.vn/CDN/media/entity/get/FilmPosterGraphic/HO00002648?referenceScheme=HeadOffice&allowPlaceHolder=true&height=500', 'https://www.youtube.com/watch?v=uXhf8LJq55Q', '2023-06-16', '2023-06-20'),
    (28, 'THE GHOST WITHIN', 'Lawrence Fowler', 'Michaela Longden, Rebecca Phillipson', 'Horror', 103, 5, 'Bí ẩn về cái chết của em gái Evie 20 năm trước, vào lúc 09:09 hằng đêm, hàng loạt cuộc chạm trán kinh hoàng xảy ra. Liệu Margot có biết được sự thật ai là kẻ giết em gái mình?\r\n', 'http://booking.bhdstar.vn/CDN/media/entity/get/FilmPosterGraphic/HO00002674?referenceScheme=HeadOffice&allowPlaceHolder=true&height=500', 'https://www.youtube.com/watch?v=p_Ppe-2_Vh8', '2023-04-14', '2023-06-20'),
    (29, 'TRANSFORMERS: RISE OF THE BEASTS', 'Steven Caple Jr.', 'Michelle Yeoh, Dominique Fishback', 'Action', 112, 5, 'Bộ phim dựa trên sự kiện Beast Wars trong loạt phim hoạt hình \"Transformers\", nơi mà các robot có khả năng biến thành động vật khổng lồ cùng chiến đấu chống lại một mối đe dọa tiềm tàng', 'http://booking.bhdstar.vn/CDN/media/entity/get/FilmPosterGraphic/HO00002678?referenceScheme=HeadOffice&allowPlaceHolder=true&height=500', 'https://www.youtube.com/watch?v=gR2pkm9XVAY', '2023-06-09', '2023-06-20'),
    (30, 'AIR', 'Ben  Affleck', 'Viola Davis', 'Drama', 112, 5, 'Bí mật trong mối quan hệ hợp tác lịch sử giữa Nike và một vận động viên bóng rổ vĩ đại.Cả hai đã cho ra mắt thương hiệu Air Jordan đình đám và theo chân Sonny Vaccaro- saleman của Nike trong hành trình tiếp cận và đánh cược cả sự nghiệp vào Michael Jordan', 'http://booking.bhdstar.vn/CDN/media/entity/get/FilmPosterGraphic/HO00002670?referenceScheme=HeadOffice&allowPlaceHolder=true&height=500', '', '2023-04-14', '2023-06-20'),
    (31, 'MY BEAUTIFUL MAN MOVIE: SPECIAL EDITION', '', 'Riku Hagiwara, Yusei Yagi', 'Drama', 132, 5, 'Hira, 17 tuổi, cố gắng ẩn mình ở trường, không bao giờ muốn phơi bày tật nói lắp của mình với các bạn cùng lớp. Anh ấy nhìn thế giới qua ống kính máy ảnh của mình, cho đến một ngày Kiyoi Sou bước qua cửa lớp...', 'http://booking.bhdstar.vn/CDN/media/entity/get/FilmPosterGraphic/HO00002651?referenceScheme=HeadOffice&allowPlaceHolder=true&height=500', '', '2023-04-14', '2023-06-20'),
    (32, 'RENFIELD', 'Chris McKay', 'Nicolas  Cage, Nicholas Hoult', 'Horror', 92, 5, 'Renfield bị buộc phải bắt con mồi về cho chủ nhân và thực hiện mọi mệnh lệnh, kể cả những việc nhục nhã. Nhưng giờ đây, sau nhiều thế kỷ làm nô lệ, Renfield đã sẵn sàng để khám phá cuộc sống bên ngoài cái bóng của Hoàng Tử Bóng Đêm...', 'http://booking.bhdstar.vn/CDN/media/entity/get/FilmPosterGraphic/HO00002656?referenceScheme=HeadOffice&allowPlaceHolder=true&height=500', 'https://www.youtube.com/watch?v=_hO0vGwqClM', '2023-04-14', '2023-06-20'),
    (33, 'THE POPES EXORCIST', 'Julius Avery', 'Russell Crowe, Daniel Zovatto', 'Horror', 104, 5, 'Từ những hồ sơ có thật của Cha Gabriele Amorth, Trưởng Trừ Tà của Vatican, \"The Popes Exorcist\" theo chân Amorth trong cuộc điều tra về vụ quỷ ám kinh hoàng của một cậu bé và dần khám phá ra những bí mật hàng thế kỉ mà Vatican đã cố giấu kín...', 'http://booking.bhdstar.vn/CDN/media/entity/get/FilmPosterGraphic/HO00002665?referenceScheme=HeadOffice&allowPlaceHolder=true&height=500', '', '2023-04-14', '2023-06-20');

    -- --------------------------------------------------------

    --
    -- Table structure for table `product`
    --

    CREATE TABLE `product` (
      `ID` int(11) NOT NULL,
      `NAME` varchar(50) DEFAULT NULL,
      `TYPE` varchar(20) DEFAULT NULL,
      `PRICE` float DEFAULT NULL,
      `QUANTITY` int(11) DEFAULT NULL,
      `Expiry_Date` date DEFAULT NULL
    ) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

    -- --------------------------------------------------------

    --
    -- Table structure for table `product_fcb`
    --

    CREATE TABLE `product_fcb` (
      `PRODUCT_ID` int(11) NOT NULL,
      `FCB_ID` int(11) NOT NULL
    ) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

    -- --------------------------------------------------------

    --
    -- Table structure for table `role`
    --

    CREATE TABLE `role` (
      `ID` int(11) NOT NULL,
      `NAME` varchar(50) DEFAULT NULL
    ) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

    --
    -- Dumping data for table `role`
    --

    INSERT INTO `role` (`ID`, `NAME`) VALUES
    (1, 'ADMIN'),
    (2, 'USER');

    -- --------------------------------------------------------

    --
    -- Table structure for table `schedule`
    --

    CREATE TABLE `schedule` (
      `ID` int(11) NOT NULL,
      `MOVIE_ID` int(11) NOT NULL,
      `start_time` datetime DEFAULT NULL,
      `end_time` datetime DEFAULT NULL,
      `THEATER_ID` int(11) NOT NULL
    ) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

    --
    -- Dumping data for table `schedule`
    --

    INSERT INTO `schedule` (`ID`, `MOVIE_ID`, `start_time`, `end_time`, `THEATER_ID`) VALUES
    (2, 25, '2023-04-13 16:40:00', '2023-04-13 18:28:00', 2),
    (3, 25, '2023-04-13 16:40:00', '2023-04-13 18:28:00', 2);

    -- --------------------------------------------------------

    --
    -- Table structure for table `seat`
    --

    CREATE TABLE `seat` (
      `ID` int(11) NOT NULL,
      `THEATER_ID` int(11) NOT NULL,
      `seat_number` int(11) NOT NULL,
      `seat_type` varchar(255) DEFAULT NULL
    ) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

    --
    -- Dumping data for table `seat`
    --

    INSERT INTO `seat` (`ID`, `THEATER_ID`, `seat_number`, `seat_type`) VALUES
    (81, 2, 1, 'Standard'),
    (82, 2, 2, 'Standard'),
    (83, 2, 3, 'Standard'),
    (84, 2, 4, 'Standard'),
    (85, 2, 5, 'Standard'),
    (86, 2, 6, 'Standard'),
    (87, 2, 7, 'Standard'),
    (88, 2, 8, 'Standard'),
    (89, 2, 9, 'Standard'),
    (90, 2, 10, 'Standard'),
    (91, 2, 11, 'Standard'),
    (92, 2, 12, 'Standard'),
    (93, 2, 13, 'Standard'),
    (94, 2, 14, 'Standard'),
    (95, 2, 15, 'Standard'),
    (96, 2, 16, 'Standard'),
    (97, 2, 17, 'Standard'),
    (98, 2, 18, 'Standard'),
    (99, 2, 19, 'Standard'),
    (100, 2, 20, 'Standard'),
    (101, 2, 21, 'Standard'),
    (102, 2, 22, 'Standard'),
    (103, 2, 23, 'Standard'),
    (104, 2, 24, 'Standard'),
    (105, 2, 25, 'Standard'),
    (106, 2, 26, 'Standard'),
    (107, 2, 27, 'Standard'),
    (108, 2, 28, 'Standard'),
    (109, 2, 29, 'Standard'),
    (110, 2, 30, 'Standard'),
    (111, 2, 31, 'Standard'),
    (112, 2, 32, 'Standard'),
    (113, 2, 33, 'Standard'),
    (114, 2, 34, 'Standard'),
    (115, 2, 35, 'Standard'),
    (116, 2, 36, 'Standard'),
    (117, 2, 37, 'Standard'),
    (118, 2, 38, 'Standard'),
    (119, 2, 39, 'Standard'),
    (120, 2, 40, 'Standard'),
    (121, 2, 41, 'Couple'),
    (122, 2, 42, 'Couple'),
    (123, 2, 43, 'Couple'),
    (124, 2, 44, 'Couple'),
    (125, 2, 45, 'Couple'),
    (126, 2, 46, 'Couple'),
    (127, 2, 47, 'Couple'),
    (128, 2, 48, 'Couple'),
    (129, 2, 49, 'Couple'),
    (130, 2, 50, 'Couple'),
    (131, 2, 51, 'Couple'),
    (132, 2, 52, 'Couple'),
    (133, 2, 53, 'Couple'),
    (134, 2, 54, 'Couple'),
    (135, 2, 55, 'Couple'),
    (136, 2, 56, 'Couple'),
    (137, 2, 57, 'Couple'),
    (138, 2, 58, 'Couple'),
    (139, 2, 59, 'Couple'),
    (140, 2, 60, 'Couple');

    -- --------------------------------------------------------

    --
    -- Table structure for table `showRoom`
    --

    CREATE TABLE `showRoom` (
      `ID` int(11) NOT NULL,
      `theater_number` int(11) NOT NULL,
      `seat_count` int(11) NOT NULL,
      `is_showing` int(11) NOT NULL,
      `CINEMA_ID` int(11) NOT NULL
    ) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

    --
    -- Dumping data for table `showRoom`
    --

    INSERT INTO `showRoom` (`ID`, `theater_number`, `seat_count`, `is_showing`, `CINEMA_ID`) VALUES
    (2, 1, 60, 0, 0);

    -- --------------------------------------------------------

    --
    -- Table structure for table `ticket`
    --

    CREATE TABLE `ticket` (
      `ID` int(11) NOT NULL,
      `BOOKING_ID` int(11) DEFAULT NULL,
      `PRICE` float NOT NULL,
      `schedule_id` int(11) DEFAULT NULL,
      `seat_id` int(11) DEFAULT NULL,
      `booked` int(11) NOT NULL
    ) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

    --
    -- Dumping data for table `ticket`
    --

    INSERT INTO `ticket` (`ID`, `BOOKING_ID`, `PRICE`, `schedule_id`, `seat_id`, `booked`) VALUES
    (1, NULL, 60000, 3, 81, 0),
    (2, NULL, 60000, 3, 82, 0),
    (3, NULL, 60000, 3, 83, 0),
    (4, NULL, 60000, 3, 84, 0),
    (5, NULL, 60000, 3, 85, 0),
    (6, NULL, 60000, 3, 86, 0),
    (7, NULL, 60000, 3, 87, 0),
    (8, NULL, 60000, 3, 88, 0),
    (9, NULL, 60000, 3, 89, 0),
    (10, NULL, 60000, 3, 90, 0),
    (11, NULL, 60000, 3, 91, 0),
    (12, NULL, 60000, 3, 92, 0),
    (13, NULL, 60000, 3, 93, 0),
    (14, NULL, 60000, 3, 94, 0),
    (15, NULL, 60000, 3, 95, 0),
    (16, NULL, 60000, 3, 96, 0),
    (17, NULL, 60000, 3, 97, 0),
    (18, NULL, 60000, 3, 98, 0),
    (19, NULL, 60000, 3, 99, 0),
    (20, NULL, 60000, 3, 100, 0),
    (21, NULL, 60000, 3, 101, 0),
    (22, NULL, 60000, 3, 102, 0),
    (23, NULL, 60000, 3, 103, 0),
    (24, NULL, 60000, 3, 104, 0),
    (25, NULL, 60000, 3, 105, 0),
    (26, NULL, 60000, 3, 106, 0),
    (27, NULL, 60000, 3, 107, 0),
    (28, NULL, 60000, 3, 108, 0),
    (29, NULL, 60000, 3, 109, 0),
    (30, NULL, 60000, 3, 110, 0),
    (31, NULL, 60000, 3, 111, 0),
    (32, NULL, 60000, 3, 112, 0),
    (33, NULL, 60000, 3, 113, 0),
    (34, NULL, 60000, 3, 114, 0),
    (35, NULL, 60000, 3, 115, 0),
    (36, NULL, 60000, 3, 116, 0),
    (37, NULL, 60000, 3, 117, 0),
    (38, NULL, 60000, 3, 118, 0),
    (39, NULL, 60000, 3, 119, 0),
    (40, NULL, 60000, 3, 120, 0),
    (41, NULL, 60000, 3, 121, 0),
    (42, NULL, 60000, 3, 122, 0),
    (43, NULL, 60000, 3, 123, 0),
    (44, NULL, 60000, 3, 124, 0),
    (45, NULL, 60000, 3, 125, 0),
    (46, NULL, 60000, 3, 126, 0),
    (47, NULL, 60000, 3, 127, 0),
    (48, NULL, 60000, 3, 128, 0),
    (49, NULL, 60000, 3, 129, 0),
    (50, NULL, 60000, 3, 130, 0),
    (51, NULL, 60000, 3, 131, 0),
    (52, NULL, 60000, 3, 132, 0),
    (53, NULL, 60000, 3, 133, 0),
    (54, NULL, 60000, 3, 134, 0),
    (55, NULL, 60000, 3, 135, 0),
    (56, NULL, 60000, 3, 136, 0),
    (57, NULL, 60000, 3, 137, 0),
    (58, NULL, 60000, 3, 138, 0),
    (59, NULL, 60000, 3, 139, 0),
    (60, NULL, 60000, 3, 140, 0);

    -- --------------------------------------------------------

    --
    -- Table structure for table `user`
    --

    CREATE TABLE `user` (
      `ID` int(11) NOT NULL,
      `NAME` varchar(50) DEFAULT NULL,
      `EMAIL` varchar(50) DEFAULT NULL,
      `ADDRESS` varchar(50) DEFAULT NULL,
      `SALARY` float NOT NULL,
      `PASSWORD` varchar(254) DEFAULT NULL,
      `CREATED` datetime DEFAULT NULL
    ) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

    --
    -- Dumping data for table `user`
    --

    INSERT INTO `user` (`ID`, `NAME`, `EMAIL`, `ADDRESS`, `SALARY`, `PASSWORD`, `CREATED`) VALUES
    (1, 'Lê Hoàng', 'admin@app.com', 'Q7, Thành phố Hồ Chí minh', 0, '$2a$10$8tRr2EOsqa7d/9lzbHSLJe492DBCmmNsSIRgahMultIZSqlvwUW/G', '2023-03-27 03:23:00'),
    (2, 'Võ Trọng Tình', 'admin', 'Lê Văn Sỹ, Q3, TP HCM', 0, '$2a$10$Z5ZISmvAipOONOzuEKKyp.wj6TfSJitJaPTOtzf.mG0ivx4QrTCFq', NULL),
    (3, 'Võ Trọng Tình', 'user', 'Lê Văn Sỹ, Q3, TP HCM', 0, '$2a$10$lFl7Sb12h44GUilkODFzAuzDBhbKkSN7EGU4L6WaqoJ56lsjMl0mW', '2023-03-28 08:31:33');

    -- --------------------------------------------------------

    --
    -- Table structure for table `users_roles`
    --

    CREATE TABLE `users_roles` (
      `USER_ID` int(11) NOT NULL,
      `ROLE_ID` int(11) NOT NULL
    ) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

    --
    -- Dumping data for table `users_roles`
    --

    INSERT INTO `users_roles` (`USER_ID`, `ROLE_ID`) VALUES
    (1, 1),
    (2, 1),
    (2, 2),
    (3, 2);

    --
    -- Indexes for dumped tables
    --

    --
    -- Indexes for table `booking`
    --
    ALTER TABLE `booking`
      ADD PRIMARY KEY (`ID`),
      ADD KEY `FK_BOOKING_CLIENT` (`USER_ID`);

    --
    -- Indexes for table `foodcombo`
    --
    ALTER TABLE `foodcombo`
      ADD PRIMARY KEY (`ID`);

    --
    -- Indexes for table `food_booking`
    --
    ALTER TABLE `food_booking`
      ADD PRIMARY KEY (`FOOD_ID`,`BOOKING_ID`),
      ADD KEY `FK_FCB_BOOKING` (`BOOKING_ID`);

    --
    -- Indexes for table `movie`
    --
    ALTER TABLE `movie`
      ADD PRIMARY KEY (`ID`);

    --
    -- Indexes for table `product`
    --
    ALTER TABLE `product`
      ADD PRIMARY KEY (`ID`);

    --
    -- Indexes for table `product_fcb`
    --
    ALTER TABLE `product_fcb`
      ADD PRIMARY KEY (`PRODUCT_ID`,`FCB_ID`),
      ADD KEY `FK_FCB_PRODUCT` (`FCB_ID`);

    --
    -- Indexes for table `role`
    --
    ALTER TABLE `role`
      ADD PRIMARY KEY (`ID`);

    --
    -- Indexes for table `schedule`
    --
    ALTER TABLE `schedule`
      ADD PRIMARY KEY (`ID`),
      ADD KEY `FK_Schedule_Movie` (`MOVIE_ID`),
      ADD KEY `FKfmo3obtsyl8xtr3n6ly5n1esl` (`THEATER_ID`);

    --
    -- Indexes for table `seat`
    --
    ALTER TABLE `seat`
      ADD PRIMARY KEY (`ID`),
      ADD KEY `FK_SEAT_THEATER` (`THEATER_ID`);

    --
    -- Indexes for table `showRoom`
    --
    ALTER TABLE `showRoom`
      ADD PRIMARY KEY (`ID`);

    --
    -- Indexes for table `ticket`
    --
    ALTER TABLE `ticket`
      ADD PRIMARY KEY (`ID`),
      ADD KEY `FKrg7x158t96nucwslhq2bad6qm` (`BOOKING_ID`),
      ADD KEY `FKqahao9a85drt47ikjp0b8syvh` (`seat_id`),
      ADD KEY `FKdmmaqgvu0kjjlpsivmgnvurl5` (`schedule_id`);

    --
    -- Indexes for table `user`
    --
    ALTER TABLE `user`
      ADD PRIMARY KEY (`ID`);

    --
    -- Indexes for table `users_roles`
    --
    ALTER TABLE `users_roles`
      ADD PRIMARY KEY (`USER_ID`,`ROLE_ID`),
      ADD KEY `FK_ROLES_USERS` (`ROLE_ID`);

    --
    -- AUTO_INCREMENT for dumped tables
    --

    --
    -- AUTO_INCREMENT for table `booking`
    --
    ALTER TABLE `booking`
      MODIFY `ID` int(11) NOT NULL AUTO_INCREMENT;

    --
    -- AUTO_INCREMENT for table `foodcombo`
    --
    ALTER TABLE `foodcombo`
      MODIFY `ID` int(11) NOT NULL AUTO_INCREMENT;

    --
    -- AUTO_INCREMENT for table `movie`
    --
    ALTER TABLE `movie`
      MODIFY `ID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=34;

    --
    -- AUTO_INCREMENT for table `product`
    --
    ALTER TABLE `product`
      MODIFY `ID` int(11) NOT NULL AUTO_INCREMENT;

    --
    -- AUTO_INCREMENT for table `schedule`
    --
    ALTER TABLE `schedule`
      MODIFY `ID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

    --
    -- AUTO_INCREMENT for table `seat`
    --
    ALTER TABLE `seat`
      MODIFY `ID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=141;

    --
    -- AUTO_INCREMENT for table `showRoom`
    --
    ALTER TABLE `showRoom`
      MODIFY `ID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

    --
    -- AUTO_INCREMENT for table `ticket`
    --
    ALTER TABLE `ticket`
      MODIFY `ID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=61;

    --
    -- Constraints for dumped tables
    --

    --
    -- Constraints for table `food_booking`
    --
    ALTER TABLE `food_booking`
      ADD CONSTRAINT `FK842h6awo74qxllo0mg5a1cmx` FOREIGN KEY (`BOOKING_ID`) REFERENCES `foodcombo` (`ID`),
      ADD CONSTRAINT `FK8sgf4xmqy2mfmxxa4967hjaf0` FOREIGN KEY (`FOOD_ID`) REFERENCES `booking` (`ID`);

    --
    -- Constraints for table `product_fcb`
    --
    ALTER TABLE `product_fcb`
      ADD CONSTRAINT `FKc7i22kucmq4j6k4ho5y6616dm` FOREIGN KEY (`PRODUCT_ID`) REFERENCES `product` (`ID`),
      ADD CONSTRAINT `FKrv1lcn6e5dpnskkoccriuqxj` FOREIGN KEY (`FCB_ID`) REFERENCES `foodcombo` (`ID`);

    --
    -- Constraints for table `schedule`
    --
    ALTER TABLE `schedule`
      ADD CONSTRAINT `FK_Schedule_Movie` FOREIGN KEY (`MOVIE_ID`) REFERENCES `movie` (`ID`) ON DELETE CASCADE ON UPDATE CASCADE,
      ADD CONSTRAINT `FKfmo3obtsyl8xtr3n6ly5n1esl` FOREIGN KEY (`THEATER_ID`) REFERENCES `showRoom` (`ID`);

    --
    -- Constraints for table `seat`
    --
    ALTER TABLE `seat`
      ADD CONSTRAINT `FKgik5885qsff01sxe7v3kqjrhx` FOREIGN KEY (`THEATER_ID`) REFERENCES `showRoom` (`ID`) ON DELETE CASCADE ON UPDATE CASCADE;

    --
    -- Constraints for table `ticket`
    --
    ALTER TABLE `ticket`
      ADD CONSTRAINT `FKdmmaqgvu0kjjlpsivmgnvurl5` FOREIGN KEY (`schedule_id`) REFERENCES `schedule` (`ID`),
      ADD CONSTRAINT `FKqahao9a85drt47ikjp0b8syvh` FOREIGN KEY (`seat_id`) REFERENCES `seat` (`ID`),
      ADD CONSTRAINT `FKrg7x158t96nucwslhq2bad6qm` FOREIGN KEY (`BOOKING_ID`) REFERENCES `booking` (`ID`);

    --
    -- Constraints for table `users_roles`
    --
    ALTER TABLE `users_roles`
      ADD CONSTRAINT `FK_USERS_ROLES` FOREIGN KEY (`USER_ID`) REFERENCES `user` (`ID`),
      ADD CONSTRAINT `FKt4v0rrweyk393bdgt107vdx0x` FOREIGN KEY (`ROLE_ID`) REFERENCES `role` (`ID`);
    COMMIT;

    /*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
    /*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
    /*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
