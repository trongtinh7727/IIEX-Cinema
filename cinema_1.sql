-- phpMyAdmin SQL Dump
-- version 5.2.0
-- https://www.phpmyadmin.net/
--
-- Host: localhost:3306
-- Generation Time: Apr 26, 2023 at 10:52 PM
-- Server version: 8.0.30
-- PHP Version: 8.1.10

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `cinema`
--

-- --------------------------------------------------------

--
-- Table structure for table `booking`
--

CREATE TABLE `booking` (
  `id` int NOT NULL,
  `created_at` datetime(6) DEFAULT NULL,
  `food_price` double NOT NULL,
  `ticket_price` double NOT NULL,
  `user_id` int DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `booking`
--

INSERT INTO `booking` (`id`, `created_at`, `food_price`, `ticket_price`, `user_id`) VALUES
(1, '2023-04-19 00:55:13.000000', 20000, 20000, 3);

-- --------------------------------------------------------

--
-- Table structure for table `cinema`
--

CREATE TABLE `cinema` (
  `id` bigint NOT NULL,
  `address` varchar(255) DEFAULT NULL,
  `phone` varchar(255) DEFAULT NULL,
  `name` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `cinema`
--

INSERT INTO `cinema` (`id`, `address`, `phone`, `name`) VALUES
(1, 'Quận 7 , Thành Phố Hồ Chí Minh', '037255620', 'LOTTE Quận 7');

-- --------------------------------------------------------

--
-- Table structure for table `foodcombo`
--

CREATE TABLE `foodcombo` (
  `id` int NOT NULL,
  `images` varchar(255) DEFAULT NULL,
  `name` varchar(255) DEFAULT NULL,
  `price` float NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `foodcombo`
--

INSERT INTO `foodcombo` (`id`, `images`, `name`, `price`) VALUES
(1, 'image/combo1.png', 'Bột + SiGUM + Bật lửa', 2000);

-- --------------------------------------------------------

--
-- Table structure for table `food_booking`
--

CREATE TABLE `food_booking` (
  `food_id` int NOT NULL,
  `booking_id` int NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `food_booking`
--

INSERT INTO `food_booking` (`food_id`, `booking_id`) VALUES
(1, 1),
(1, 1);

-- --------------------------------------------------------

--
-- Table structure for table `movie`
--

CREATE TABLE `movie` (
  `id` bigint NOT NULL,
  `actors` varchar(255) DEFAULT NULL,
  `closing_day` datetime(6) DEFAULT NULL,
  `director` varchar(255) DEFAULT NULL,
  `duration` int NOT NULL,
  `genre` varchar(255) DEFAULT NULL,
  `opening_day` datetime(6) DEFAULT NULL,
  `poster` varchar(255) DEFAULT NULL,
  `rating` float NOT NULL,
  `story` varchar(255) DEFAULT NULL,
  `title` varchar(255) DEFAULT NULL,
  `trailer` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `movie`
--

INSERT INTO `movie` (`id`, `actors`, `closing_day`, `director`, `duration`, `genre`, `opening_day`, `poster`, `rating`, `story`, `title`, `trailer`) VALUES
(1, 'Greg Han Hsu, Gingle Wang', '2023-06-20 00:00:00.000000', 'Wei Hao Cheng', 130, 'Drama', '2023-04-07 00:00:00.000000', 'http://booking.bhdstar.vn/CDN/media/entity/get/FilmPosterGraphic/HO00002654?referenceScheme=HeadOffice&allowPlaceHolder=true&height=500', 5, 'Ming-Han, một sĩ quan cảnh sát nhiệt huyết, trong quá trình truy bắt tội phạm đã tìm thấy một phong bì cưới màu đỏ và chủ nhân của nó là hồn ma Mao-Mao với nguyện vọng phải được kết hôn với một sĩ quan cảnh sát trước khi tái sinh...', 'MARRY MY DEAD ', 'https://www.youtube.com/embed/S2kymv60ndQ'),
(2, 'Henry Golding, Noomi Repace', '2023-06-20 00:00:00.000000', 'Camille Delamarre', 109, 'Action', '2023-04-07 00:00:00.000000', 'http://booking.bhdstar.vn/CDN/media/entity/get/FilmPosterGraphic/HO00002661?referenceScheme=HeadOffice&allowPlaceHolder=true&height=500', 5, 'Bảy tên sát thủ vô tình bị thiết lập trong một trò chơi sống còn. Morgan Gaines- một sát thủ chuyên nghiệp có nhiệm vụ phải giết bảy người,Morgan phát hiện ra bảy \"mục tiêu\" cũng là bảy sát thủ nặng ký. Lối thoát duy nhất cho Morgan là tìm ra kẻ chủ mưu..', 'ASSASSIN CLUB', 'https://www.youtube.com/embed/usYcScx3yMk'),
(3, 'Chris Pratt, Anya Taylor-Joy', '2023-06-20 00:00:00.000000', 'Aaron Horvath', 93, 'Animation', '2023-04-07 00:00:00.000000', 'http://booking.bhdstar.vn/CDN/media/entity/get/FilmPosterGraphic/HO00002631?referenceScheme=HeadOffice&allowPlaceHolder=true&height=500', 5, 'Theo chân anh chàng thợ sửa ống nước tên Mario cùng công chúa Peach của Vương quốc Nấm trong cuộc phiêu lưu giải cứu anh trai Luigi đang bị bắt cóc và ngăn chặn tên độc tài Bowser, kẻ đang âm mưu thôn tính thế giới', 'THE SUPER MARIO BROS. MOVIE', 'https://www.youtube.com/embed/wODah30-agA'),
(4, 'Baipor Thitiya Jirapornsilp, Tony Anthony Buisseret', '2023-06-20 00:00:00.000000', 'Waew Waewwan Hongvivatana', 121, 'Drama', '2023-04-07 00:00:00.000000', 'http://booking.bhdstar.vn/CDN/media/entity/get/FilmPosterGraphic/HO00002669?referenceScheme=HeadOffice&allowPlaceHolder=true&height=500', 5, 'Hai chị em sinh đôi \"You\" và \"Me\"có ngoại hình và sở thích giống hệt nhau,thân thiết đến mức họ có thể chia sẻ mọi khía cạnh trong cuộc sống,cho đến khi một cậu bé - \"mối tình đầu\" của họ xuất hiện và đặt ra những thử thách khó khăn cho mối quan hệ của họ', 'YOU & ME & ME ', 'https://www.youtube.com/embed/S2kymv60ndQ'),
(5, 'Amelia Henderson, Alif Satar', '2023-06-20 00:00:00.000000', 'Eu  Ho', 112, 'Horror', '2023-03-31 00:00:00.000000', 'http://booking.bhdstar.vn/CDN/media/entity/get/FilmPosterGraphic/HO00002673?referenceScheme=HeadOffice&allowPlaceHolder=true&height=500', 5, 'Kỳ nghỉ của nhóm bạn trẻ biến thành cơn ác mộng kinh hoàng sau khi họ thua một cuộc cá cược,họ buộc phải qua đêm tại một đảo hoang, khi tình cờ đến một ngôi làng bị bỏ hoang bí ẩn ở đó, họ đã phá vỡ câu thần chú cũ được đặt để kiềm chế một linh hồn tàn ác', 'PULAU ', 'https://www.youtube.com/embed/S2kymv60ndQ'),
(6, 'Võ Tấn Phát, Hoàng  Oanh', '2023-06-20 00:00:00.000000', 'Tạ Nguyên Hiệp', 104, 'Comedy', '2023-03-31 00:00:00.000000', 'http://booking.bhdstar.vn/CDN/media/entity/get/FilmPosterGraphic/HO00002633?referenceScheme=HeadOffice&allowPlaceHolder=true&height=500', 5, 'Xoay quanh bộ đôi Khuê và Phong. Sau lần chạm trán tình cờ, bộ đôi lôi kéo gia đình Bảy Cục tham gia vào phi vụ đặc biệt: Đánh tráo chiếc vòng đính hôn bằng kim cương quí giá và lật tẩy bộ mặt thật của Tuấn-chồng cũ của Khuê...', 'BIỆT ĐỘI RẤT ỔN', 'https://www.youtube.com/embed/6qZbBiL65cI'),
(7, 'Nadezhda Kaleganova, Viktor Dobronravov', '2023-06-20 00:00:00.000000', 'Dmitriy Suvorov', 96, 'Drama', '2023-03-31 00:00:00.000000', 'http://booking.bhdstar.vn/CDN/media/entity/get/FilmPosterGraphic/HO00002580?referenceScheme=HeadOffice&allowPlaceHolder=true&height=500', 5, 'Cặp vợ chồng mới cưới Larisa và Vladimir trở về nhà từ tuần trăng mật ở Blagoveshchensk và bị va chạm máy bay, Larisa phải vật lộn với cái đói cái lạnh và động vật hoang dã săn mồi. Liệu Larisa có tìm được vị hôn phu và cùng sống sót trở về ?', 'THE ONE', 'https://www.youtube.com/embed/S2kymv60ndQ'),
(8, 'Kim Da-Mi, Woo-Seok Byeon', '2023-06-20 00:00:00.000000', 'Young-Keun Min', 124, 'Drama', '2023-03-24 00:00:00.000000', 'http://booking.bhdstar.vn/CDN/media/entity/get/FilmPosterGraphic/HO00002611?referenceScheme=HeadOffice&allowPlaceHolder=true&height=500', 5, 'Mi So và Ha Eun trong một mối quan hệ chồng chéo chất chứa những hạnh phúc, rung động và biệt ly. Từ giây phút gặp nhau , hai cô gái đã hình thành sợi dây liên kết đặc biệt nhưng mối quan hệ của họ rạn nứt khi một chàng trai xuất hiện...', 'SOULMATE', 'https://www.youtube.com/embed/pGAFcV97dpw'),
(9, 'Má Thị Di', '2023-06-20 00:00:00.000000', 'Hà Lệ Diễm', 93, 'Documentary', '2023-03-17 00:00:00.000000', 'http://booking.bhdstar.vn/CDN/media/entity/get/FilmPosterGraphic/HO00002676?referenceScheme=HeadOffice&allowPlaceHolder=true&height=500', 5, 'Di, một cô gái trẻ nhiệt huyết đến từ cộng đồng người Mông bị mắc kẹt giữa truyền thống \"kéo vợ\" và mong muốn được tiếp tục sống thời thơ ấu và đến trường đi học , liệu với trái tim trong sáng ấy , Di sẽ đối diện với xã hội ấy như thế nào...?\r\n', 'NHỮNG ĐỨA TRẺ TRONG SƯƠNG', 'https://www.youtube.com/embed/S2kymv60ndQ'),
(10, 'Mạc Văn Khoa, Anh Tú', '2023-06-20 00:00:00.000000', 'Võ Thanh Hòa', 112, 'Comedy', '2023-03-03 00:00:00.000000', 'http://booking.bhdstar.vn/CDN/media/entity/get/FilmPosterGraphic/HO00002593?referenceScheme=HeadOffice&allowPlaceHolder=true&height=500', 5, 'Khoa, một tên lừa đảo tới Phú Quốc với mục tiêu đổi đời. Không ngờ đây là sân nhà của Tú, một tên lừa đảo chuyên nghiệp, cả hai bắt tay cùng thực hiện một phi vụ siêu lớn và mục tiêu là các quý bà giàu có và đam mê sự nổi tiếng', 'SIÊU LỪA GẶP SIÊU LẦY', 'https://www.youtube.com/embed/xy8RznX_uyM'),
(11, 'Viola Davis', '2023-06-20 00:00:00.000000', 'Ben  Affleck', 112, 'Drama', '2023-04-14 00:00:00.000000', 'http://booking.bhdstar.vn/CDN/media/entity/get/FilmPosterGraphic/HO00002670?referenceScheme=HeadOffice&allowPlaceHolder=true&height=500', 5, 'Bí mật trong mối quan hệ hợp tác lịch sử giữa Nike và một vận động viên bóng rổ vĩ đại.Cả hai đã cho ra mắt thương hiệu Air Jordan đình đám và theo chân Sonny Vaccaro- saleman của Nike trong hành trình tiếp cận và đánh cược cả sự nghiệp vào Michael Jordan', 'AIR', 'https://www.youtube.com/embed/S2kymv60ndQ'),
(12, 'Thái Hòa, Thu  Trang', '2023-06-20 00:00:00.000000', 'Vũ  Ngọc Đãng', 100, '', '2023-04-28 00:00:00.000000', 'http://booking.bhdstar.vn/CDN/media/entity/get/FilmPosterGraphic/HO00002650?referenceScheme=HeadOffice&allowPlaceHolder=true&height=500', 5, 'Là câu chuyện của Nhót - Người phụ nữ \"chưa kịp già\" đã sắp bị mãn kinh, vội vàng đi tìm chồng. Nhưng sâu thẳm trong cô là khao khát muốn có một đứa con và luôn muốn hàn gắn với người cha suốt ngày say xỉn của mình', 'CHUYỆN XÓM TUI : CON NHÓT MÓT CHỒNG', 'https://www.youtube.com/embed/qehxOMR-rFQ'),
(13, 'Chris Pine, Michelle Rodriguez', '2023-06-20 00:00:00.000000', 'John Francis Daley', 134, 'Adventure', '2023-04-21 00:00:00.000000', 'http://booking.bhdstar.vn/CDN/media/entity/get/FilmPosterGraphic/HO00002629?referenceScheme=HeadOffice&allowPlaceHolder=true&height=500', 5, 'Theo chân một tên trộm quyến rũ và một nhóm những kẻ bịp bợm nghiệp dư thực hiện vụ trộm sử thi nhằm lấy lại một di vật đã mất, nhưng mọi thứ trở nên nguy hiểm khó lường hơn bao giờ hết khi họ đã chạm trám nhầm người...', 'DUNGEONS & DRAGONS: HONOR AMONG THIEVES ', 'https://www.youtube.com/embed/iTZJ-uwIZxg'),
(14, 'Leah Lewis, Mamoudou Athie', '2023-06-20 00:00:00.000000', 'Peter Sohn', 93, 'Animation', '2023-06-16 00:00:00.000000', 'http://booking.bhdstar.vn/CDN/media/entity/get/FilmPosterGraphic/HO00002677?referenceScheme=HeadOffice&allowPlaceHolder=true&height=500', 5, 'Ember, một cô nàng cá tính, thông minh, mạnh mẽ và đầy sức hút. Tuy nhiên mối quan hệ của cô với Wade- một anh chàng hài hước, luôn thuận thế đẩy dòng - khiến Ember cảm thấy ngờ vực với thế giới này...', 'ELEMENTAL', 'https://www.youtube.com/embed/K19bf6ButD4'),
(15, 'Chris  Pratt, Zoe Saldana', '2023-06-20 00:00:00.000000', 'James  Gunn', 119, 'Adventure', '2023-05-03 00:00:00.000000', 'http://booking.bhdstar.vn/CDN/media/entity/get/FilmPosterGraphic/HO00002647?referenceScheme=HeadOffice&allowPlaceHolder=true&height=500', 5, 'Cho dù vũ trụ này có bao la đến đâu, các Vệ Binh của chúng ta cũng không thể trốn chạy mãi mãi...', 'GUARDIANS OF THE GALAXY 3', 'https://www.youtube.com/watch?v=Pp6reH8bpZ8'),
(16, 'Duy Khánh, Quốc Cường', '2023-06-20 00:00:00.000000', 'Lý  Hải', 132, 'Action', '2023-04-28 00:00:00.000000', 'http://booking.bhdstar.vn/CDN/media/entity/get/FilmPosterGraphic/HO00002653?referenceScheme=HeadOffice&allowPlaceHolder=true&height=500', 5, 'Nhóm bạn thân lâu năm bất ngờ nhận được cơ hội đổi đời khi biết tấm vé của cả nhóm trúng giải độc đắc 136.8 tỷ. Đột nhiên An,người giữ tấm vé bất ngờ qua đời, liệu trong hành trình tìm kiếm và chia chác món tiền trong mơ béo bở này sẽ đưa cả nhóm đến đâu?', 'LẬT MẶT 6', 'https://www.youtube.com/watch?v=tpjjd7usfnA'),
(17, 'Riku Hagiwara, Yusei Yagi', '2023-06-20 00:00:00.000000', '', 98, 'Drama', '2023-04-14 00:00:00.000000', 'http://booking.bhdstar.vn/CDN/media/entity/get/FilmPosterGraphic/HO00002651?referenceScheme=HeadOffice&allowPlaceHolder=true&height=500', 5, 'Hira, 17 tuổi, cố gắng ẩn mình ở trường, không bao giờ muốn phơi bày tật nói lắp của mình với các bạn cùng lớp. Anh ấy nhìn thế giới qua ống kính máy ảnh của mình, cho đến một ngày Kiyoi Sou bước qua cửa lớp...', 'MY BEAUTIFUL MAN MOVIE: SPECIAL EDITION', 'https://www.youtube.com/embed/S2kymv60ndQ'),
(18, 'Nicolas  Cage, Nicholas Hoult', '2023-06-20 00:00:00.000000', 'Chris McKay', 95, 'Horror', '2023-04-14 00:00:00.000000', 'http://booking.bhdstar.vn/CDN/media/entity/get/FilmPosterGraphic/HO00002656?referenceScheme=HeadOffice&allowPlaceHolder=true&height=500', 5, 'Renfield bị buộc phải bắt con mồi về cho chủ nhân và thực hiện mọi mệnh lệnh, kể cả những việc nhục nhã. Nhưng giờ đây, sau nhiều thế kỷ làm nô lệ, Renfield đã sẵn sàng để khám phá cuộc sống bên ngoài cái bóng của Hoàng Tử Bóng Đêm...', 'RENFIELD', 'https://www.youtube.com/watch?v=_hO0vGwqClM'),
(19, 'Daniel Lascar', '2023-06-20 00:00:00.000000', 'Alessandro Antonaci', 93, 'Horror', '2023-04-21 00:00:00.000000', 'http://booking.bhdstar.vn/CDN/media/entity/get/FilmPosterGraphic/HO00002666?referenceScheme=HeadOffice&allowPlaceHolder=true&height=500', 5, 'Trở về nhà sau mất mát của cha mẹ, Emma vô tình giải phóng những linh hồn quá khứ mắc kẹt trong chiếc radio cổ. Vô số câu chuyện bí ẩn lần lượt được vạch trần, liệu Emma sẽ tỉnh táo đối mặt hay cô sẽ bị nhấn chìm bởi quỹ dữ ?', 'SOUND OF SILENCE', 'https://www.youtube.com/embed/S2kymv60ndQ'),
(20, 'Ben  Affleck, Michael Shannon', '2023-06-20 00:00:00.000000', 'Andy  Muschietti', 120, 'Action', '2023-06-16 00:00:00.000000', 'http://booking.bhdstar.vn/CDN/media/entity/get/FilmPosterGraphic/HO00002648?referenceScheme=HeadOffice&allowPlaceHolder=true&height=500', 5, 'Mùa hè này, đa thế giới sẽ va chạm khốc liệt với những bước chạy của FLASH', 'THE FLASH ', 'https://www.youtube.com/watch?v=uXhf8LJq55Q'),
(21, 'Michaela Longden, Rebecca Phillipson', '2023-06-20 00:00:00.000000', 'Lawrence Fowler', 103, 'Horror', '2023-04-14 00:00:00.000000', 'http://booking.bhdstar.vn/CDN/media/entity/get/FilmPosterGraphic/HO00002674?referenceScheme=HeadOffice&allowPlaceHolder=true&height=500', 5, 'Bí ẩn về cái chết của em gái Evie 20 năm trước, vào lúc 09:09 hằng đêm, hàng loạt cuộc chạm trán kinh hoàng xảy ra. Liệu Margot có biết được sự thật ai là kẻ giết em gái mình?\r\n', 'THE GHOST WITHIN', 'https://www.youtube.com/watch?v=p_Ppe-2_Vh8'),
(22, 'Michelle Yeoh, Dominique Fishback', '2023-06-20 00:00:00.000000', 'Steven Caple Jr.', 112, 'Action', '2023-06-09 00:00:00.000000', 'http://booking.bhdstar.vn/CDN/media/entity/get/FilmPosterGraphic/HO00002678?referenceScheme=HeadOffice&allowPlaceHolder=true&height=500', 5, 'Bộ phim dựa trên sự kiện Beast Wars trong loạt phim hoạt hình \"Transformers\", nơi mà các robot có khả năng biến thành động vật khổng lồ cùng chiến đấu chống lại một mối đe dọa tiềm tàng', 'TRANSFORMERS: RISE OF THE BEASTS', 'https://www.youtube.com/watch?v=gR2pkm9XVAY'),
(23, 'Russell Crowe, Daniel Zovatto', '2023-06-20 00:00:00.000000', 'Julius Avery', 104, 'Horror', '2023-04-14 00:00:00.000000', 'http://booking.bhdstar.vn/CDN/media/entity/get/FilmPosterGraphic/HO00002665?referenceScheme=HeadOffice&allowPlaceHolder=true&height=500', 5, 'Từ những hồ sơ có thật của Cha Gabriele Amorth, Trưởng Trừ Tà của Vatican, \"The Popes Exorcist\" theo chân Amorth trong cuộc điều tra về vụ quỷ ám kinh hoàng của một cậu bé và dần khám phá ra những bí mật hàng thế kỉ mà Vatican đã cố giấu kín...', 'THE POPES EXORCIST', 'https://www.youtube.com/embed/S2kymv60ndQ'),
(24, 'Ca sĩ Mỹ Tâm', '2023-06-20 00:00:00.000000', 'MỸ TÂM', 106, 'Musical', '2023-04-08 00:00:00.000000', 'http://booking.bhdstar.vn/CDN/media/entity/get/FilmPosterGraphic/HO00002663?referenceScheme=HeadOffice&allowPlaceHolder=true&height=500', 0, 'Mỹ Tâm sẽ phác họa chân thực toàn bộ những diễn biến tâm lý và cảm xúc thăng trầm cùng những thăng hoa trong suốt quá trình thực hiện Liveshow \"Tri Âm\" lịch sử bằng những thước phim quý giá được quay lại trong 2 năm...', 'NGƯỜI GIỮ THỜI GIAN : TRI ÂM ', 'https://www.youtube.com/embed/8BdO_M8bUZo');

-- --------------------------------------------------------

--
-- Table structure for table `role`
--

CREATE TABLE `role` (
  `id` int NOT NULL,
  `name` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `role`
--

INSERT INTO `role` (`id`, `name`) VALUES
(1, 'ADMIN'),
(2, 'USER');

-- --------------------------------------------------------

--
-- Table structure for table `schedule`
--

CREATE TABLE `schedule` (
  `id` int NOT NULL,
  `end_time` datetime(6) DEFAULT NULL,
  `start_time` datetime(6) DEFAULT NULL,
  `movie_id` bigint DEFAULT NULL,
  `showroom_id` bigint DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `seat`
--

CREATE TABLE `seat` (
  `id` int NOT NULL,
  `seat_number` varchar(3) NOT NULL,
  `seat_type` varchar(255) DEFAULT NULL,
  `showroom_id` bigint DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `seat`
--

INSERT INTO `seat` (`id`, `seat_number`, `seat_type`, `showroom_id`) VALUES
(91, 'A1', 'Standard', 5),
(92, 'A2', 'Standard', 5),
(93, 'A3', 'Standard', 5),
(94, 'A4', 'Standard', 5),
(95, 'A5', 'Standard', 5),
(96, 'A6', 'Standard', 5),
(97, 'A7', 'Standard', 5),
(98, 'A8', 'Standard', 5),
(99, 'A9', 'Standard', 5),
(100, 'A10', 'Standard', 5),
(101, 'B1', 'Standard', 5),
(102, 'B2', 'Standard', 5),
(103, 'B3', 'Standard', 5),
(104, 'B4', 'Standard', 5),
(105, 'B5', 'Standard', 5),
(106, 'B6', 'Standard', 5),
(107, 'B7', 'Standard', 5),
(108, 'B8', 'Standard', 5),
(109, 'B9', 'Standard', 5),
(110, 'B10', 'Standard', 5),
(111, 'C1', 'Standard', 5),
(112, 'C2', 'Standard', 5),
(113, 'C3', 'Standard', 5),
(114, 'C4', 'Standard', 5),
(115, 'C5', 'Standard', 5),
(116, 'C6', 'Standard', 5),
(117, 'C7', 'Standard', 5),
(118, 'C8', 'Standard', 5),
(119, 'C9', 'Standard', 5),
(120, 'C10', 'Standard', 5),
(121, 'D1', 'Standard', 5),
(122, 'D2', 'Standard', 5),
(123, 'D3', 'Standard', 5),
(124, 'D4', 'Standard', 5),
(125, 'D5', 'Standard', 5),
(126, 'D6', 'Standard', 5),
(127, 'D7', 'Standard', 5),
(128, 'D8', 'Standard', 5),
(129, 'D9', 'Standard', 5),
(130, 'D10', 'Standard', 5),
(131, 'E1', 'Standard', 5),
(132, 'E2', 'Standard', 5),
(133, 'E3', 'Standard', 5),
(134, 'E4', 'Standard', 5),
(135, 'E5', 'Standard', 5),
(136, 'E6', 'Standard', 5),
(137, 'E7', 'Standard', 5),
(138, 'E8', 'Standard', 5),
(139, 'E9', 'Standard', 5),
(140, 'E10', 'Standard', 5),
(141, 'F1', 'Standard', 5),
(142, 'F2', 'Standard', 5),
(143, 'F3', 'Standard', 5),
(144, 'F4', 'Standard', 5),
(145, 'F5', 'Standard', 5),
(146, 'F6', 'Standard', 5),
(147, 'F7', 'Standard', 5),
(148, 'F8', 'Standard', 5),
(149, 'F9', 'Standard', 5),
(150, 'F10', 'Standard', 5),
(151, 'G1', 'Standard', 5),
(152, 'G2', 'Standard', 5),
(153, 'G3', 'Standard', 5),
(154, 'G4', 'Standard', 5),
(155, 'G5', 'Standard', 5),
(156, 'G6', 'Standard', 5),
(157, 'G7', 'Standard', 5),
(158, 'G8', 'Standard', 5),
(159, 'G9', 'Standard', 5),
(160, 'G10', 'Standard', 5),
(161, 'H1', 'Standard', 5),
(162, 'H2', 'Standard', 5),
(163, 'H3', 'Standard', 5),
(164, 'H4', 'Standard', 5),
(165, 'H5', 'Standard', 5),
(166, 'H6', 'Standard', 5),
(167, 'H7', 'Standard', 5),
(168, 'H8', 'Standard', 5),
(169, 'H9', 'Standard', 5),
(170, 'H10', 'Standard', 5),
(171, 'I1', 'Couple', 5),
(172, 'I2', 'Couple', 5),
(173, 'I3', 'Couple', 5),
(174, 'I4', 'Couple', 5),
(175, 'I5', 'Couple', 5),
(176, 'J1', 'Couple', 5),
(177, 'J2', 'Couple', 5),
(178, 'J3', 'Couple', 5),
(179, 'J4', 'Couple', 5),
(180, 'J5', 'Couple', 5);

-- --------------------------------------------------------

--
-- Table structure for table `showroom`
--

CREATE TABLE `showroom` (
  `id` bigint NOT NULL,
  `seat_count` int NOT NULL,
  `showroom_number` int NOT NULL,
  `cinema_id` bigint DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `showroom`
--

INSERT INTO `showroom` (`id`, `seat_count`, `showroom_number`, `cinema_id`) VALUES
(3, 0, 4, 1),
(5, 90, 6, 1);

-- --------------------------------------------------------

--
-- Table structure for table `ticket`
--

CREATE TABLE `ticket` (
  `id` int NOT NULL,
  `price` float NOT NULL,
  `booking_id` int DEFAULT NULL,
  `schedule_id` int DEFAULT NULL,
  `seat_id` int DEFAULT NULL,
  `booked` int NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `user`
--

CREATE TABLE `user` (
  `id` int NOT NULL,
  `address` varchar(255) DEFAULT NULL,
  `created` datetime(6) DEFAULT NULL,
  `email` varchar(255) DEFAULT NULL,
  `name` varchar(255) DEFAULT NULL,
  `password` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `user`
--

INSERT INTO `user` (`id`, `address`, `created`, `email`, `name`, `password`) VALUES
(1, 'Q7, Thành phố Hồ Chí minh', '2023-03-27 03:23:00.000000', 'admin@app.com', 'Lê Hoàng', '$2a$10$8tRr2EOsqa7d/9lzbHSLJe492DBCmmNsSIRgahMultIZSqlvwUW/G'),
(2, 'Lê Văn Sỹ, Q3, TP HCM', NULL, 'admin', 'Võ Trọng Tình admin', '$2a$10$Z5ZISmvAipOONOzuEKKyp.wj6TfSJitJaPTOtzf.mG0ivx4QrTCFq'),
(3, 'Lê Văn Sỹ, Q3, TP HCM', '2023-03-28 08:31:33.000000', 'user', 'Võ Trọng Tình', '$2a$10$lFl7Sb12h44GUilkODFzAuzDBhbKkSN7EGU4L6WaqoJ56lsjMl0mW'),
(4, 'Haf tingx', NULL, 'phuc', 'Le Hoang Phuc', '$2a$10$bTuOfRfN2f5TVEbSiEK2JO7HjU49hKfrqkjDxKvFLlivjDTLtV31O'),
(5, 'SDKVONSDOK', '2023-04-27 00:01:47.368000', 'phuc12', 'LEIOSNVIO', '$2a$10$ryihrBdBUe6mH4uF/TRHquk61KP4Gxs.FakDepFVek0Z5wgKWx1Dy'),
(6, 'LongAn Kingdom', '2023-04-27 00:14:23.923000', 'DucCong', 'DucCong', '$2a$10$A3QxsY2U8IMLM2WTQoA9/OrHRfxlm1.rUnVobyOrsV2JFEbTn3u6i');

-- --------------------------------------------------------

--
-- Table structure for table `users_roles`
--

CREATE TABLE `users_roles` (
  `user_id` int NOT NULL,
  `role_id` int NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `users_roles`
--

INSERT INTO `users_roles` (`user_id`, `role_id`) VALUES
(1, 1),
(2, 1),
(2, 2),
(3, 2),
(4, 2),
(5, 2),
(6, 1);

--
-- Indexes for dumped tables
--

--
-- Indexes for table `booking`
--
ALTER TABLE `booking`
  ADD PRIMARY KEY (`id`),
  ADD KEY `FKkgseyy7t56x7lkjgu3wah5s3t` (`user_id`);

--
-- Indexes for table `cinema`
--
ALTER TABLE `cinema`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `foodcombo`
--
ALTER TABLE `foodcombo`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `food_booking`
--
ALTER TABLE `food_booking`
  ADD KEY `FK842h6awo74qxllo0mg5a1cmx` (`booking_id`),
  ADD KEY `FK8sgf4xmqy2mfmxxa4967hjaf0` (`food_id`);

--
-- Indexes for table `movie`
--
ALTER TABLE `movie`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `role`
--
ALTER TABLE `role`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `schedule`
--
ALTER TABLE `schedule`
  ADD PRIMARY KEY (`id`),
  ADD KEY `FKa6hosaihwhtb3scvamdyh9mlv` (`movie_id`),
  ADD KEY `FKfmo3obtsyl8xtr3n6ly5n1esl` (`showroom_id`);

--
-- Indexes for table `seat`
--
ALTER TABLE `seat`
  ADD PRIMARY KEY (`id`),
  ADD KEY `FKgik5885qsff01sxe7v3kqjrhx` (`showroom_id`);

--
-- Indexes for table `showroom`
--
ALTER TABLE `showroom`
  ADD PRIMARY KEY (`id`),
  ADD KEY `FKjur3k2m1ybr25xrs62nyg21rv` (`cinema_id`);

--
-- Indexes for table `ticket`
--
ALTER TABLE `ticket`
  ADD PRIMARY KEY (`id`),
  ADD KEY `FKrg7x158t96nucwslhq2bad6qm` (`booking_id`),
  ADD KEY `FKdmmaqgvu0kjjlpsivmgnvurl5` (`schedule_id`),
  ADD KEY `FKqahao9a85drt47ikjp0b8syvh` (`seat_id`);

--
-- Indexes for table `user`
--
ALTER TABLE `user`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `users_roles`
--
ALTER TABLE `users_roles`
  ADD KEY `FKt4v0rrweyk393bdgt107vdx0x` (`role_id`),
  ADD KEY `FKgd3iendaoyh04b95ykqise6qh` (`user_id`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `booking`
--
ALTER TABLE `booking`
  MODIFY `id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `cinema`
--
ALTER TABLE `cinema`
  MODIFY `id` bigint NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT for table `foodcombo`
--
ALTER TABLE `foodcombo`
  MODIFY `id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `movie`
--
ALTER TABLE `movie`
  MODIFY `id` bigint NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=36;

--
-- AUTO_INCREMENT for table `role`
--
ALTER TABLE `role`
  MODIFY `id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT for table `schedule`
--
ALTER TABLE `schedule`
  MODIFY `id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT for table `seat`
--
ALTER TABLE `seat`
  MODIFY `id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=181;

--
-- AUTO_INCREMENT for table `showroom`
--
ALTER TABLE `showroom`
  MODIFY `id` bigint NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT for table `ticket`
--
ALTER TABLE `ticket`
  MODIFY `id` int NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `user`
--
ALTER TABLE `user`
  MODIFY `id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `booking`
--
ALTER TABLE `booking`
  ADD CONSTRAINT `FKkgseyy7t56x7lkjgu3wah5s3t` FOREIGN KEY (`user_id`) REFERENCES `user` (`id`);

--
-- Constraints for table `food_booking`
--
ALTER TABLE `food_booking`
  ADD CONSTRAINT `FK842h6awo74qxllo0mg5a1cmx` FOREIGN KEY (`booking_id`) REFERENCES `foodcombo` (`id`),
  ADD CONSTRAINT `FK8sgf4xmqy2mfmxxa4967hjaf0` FOREIGN KEY (`food_id`) REFERENCES `booking` (`id`);

--
-- Constraints for table `schedule`
--
ALTER TABLE `schedule`
  ADD CONSTRAINT `FKa6hosaihwhtb3scvamdyh9mlv` FOREIGN KEY (`movie_id`) REFERENCES `movie` (`id`),
  ADD CONSTRAINT `FKfmo3obtsyl8xtr3n6ly5n1esl` FOREIGN KEY (`showroom_id`) REFERENCES `showroom` (`id`);

--
-- Constraints for table `seat`
--
ALTER TABLE `seat`
  ADD CONSTRAINT `FK_seat_showroom` FOREIGN KEY (`showroom_id`) REFERENCES `showroom` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `showroom`
--
ALTER TABLE `showroom`
  ADD CONSTRAINT `FKjur3k2m1ybr25xrs62nyg21rv` FOREIGN KEY (`cinema_id`) REFERENCES `cinema` (`id`);

--
-- Constraints for table `ticket`
--
ALTER TABLE `ticket`
  ADD CONSTRAINT `FKdmmaqgvu0kjjlpsivmgnvurl5` FOREIGN KEY (`schedule_id`) REFERENCES `schedule` (`id`),
  ADD CONSTRAINT `FKqahao9a85drt47ikjp0b8syvh` FOREIGN KEY (`seat_id`) REFERENCES `seat` (`id`),
  ADD CONSTRAINT `FKrg7x158t96nucwslhq2bad6qm` FOREIGN KEY (`booking_id`) REFERENCES `booking` (`id`);

--
-- Constraints for table `users_roles`
--
ALTER TABLE `users_roles`
  ADD CONSTRAINT `FKgd3iendaoyh04b95ykqise6qh` FOREIGN KEY (`user_id`) REFERENCES `user` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `FKt4v0rrweyk393bdgt107vdx0x` FOREIGN KEY (`role_id`) REFERENCES `role` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
