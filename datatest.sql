-- phpMyAdmin SQL Dump
-- version 5.2.0
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Apr 30, 2023 at 06:08 AM
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
-- Database: `datatest`
--

-- --------------------------------------------------------

--
-- Table structure for table `booking`
--

CREATE TABLE `booking` (
  `id` int(11) NOT NULL,
  `created_at` datetime(6) DEFAULT current_timestamp(6),
  `food_price` double NOT NULL,
  `ticket_price` double NOT NULL,
  `user_id` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `booking`
--

INSERT INTO `booking` (`id`, `created_at`, `food_price`, `ticket_price`, `user_id`) VALUES
(1, '2023-04-12 04:40:48.000000', 0, 180000, 2),
(2, '2023-04-29 21:33:12.000000', 0, 270000, 3);

-- --------------------------------------------------------

--
-- Table structure for table `cinema`
--

CREATE TABLE `cinema` (
  `id` bigint(20) NOT NULL,
  `address` varchar(255) DEFAULT NULL,
  `phone` varchar(255) DEFAULT NULL,
  `name` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `cinema`
--

INSERT INTO `cinema` (`id`, `address`, `phone`, `name`) VALUES
(1, 'Quận 7 , Thành Phố Hồ Chí Minh', '037255620', 'LOTTE Quận 7'),
(3, 'Q4', '01234567', 'Lotte Q4');

-- --------------------------------------------------------

--
-- Table structure for table `foodcombo`
--

CREATE TABLE `foodcombo` (
  `id` int(11) NOT NULL,
  `images` varchar(255) DEFAULT NULL,
  `name` varchar(255) DEFAULT NULL,
  `price` float NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `foodcombo`
--

INSERT INTO `foodcombo` (`id`, `images`, `name`, `price`) VALUES
(1, 'image/combo1.png', 'Không mua', 0);

-- --------------------------------------------------------

--
-- Table structure for table `food_booking`
--

CREATE TABLE `food_booking` (
  `food_id` int(11) NOT NULL,
  `booking_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Triggers `food_booking`
--
DELIMITER $$
CREATE TRIGGER `delete_food_booking` AFTER DELETE ON `food_booking` FOR EACH ROW UPDATE booking
SET booking.FOOD_PRICE = (SELECT SUM(foodcombo.PRICE) 
FROM foodcombo, food_booking
WHERE food_booking.FOOD_ID = foodcombo.ID
AND food_booking.BOOKING_ID =Old.BOOKING_ID)
WHERE booking.ID = Old.BOOKING_ID
$$
DELIMITER ;
DELIMITER $$
CREATE TRIGGER `insert_fb` AFTER INSERT ON `food_booking` FOR EACH ROW UPDATE booking
SET booking.FOOD_PRICE = (SELECT SUM(foodcombo.PRICE) 
FROM foodcombo, food_booking
WHERE 
food_booking.FOOD_ID = foodcombo.ID
AND food_booking.BOOKING_ID =New.BOOKING_ID)
WHERE booking.ID = New.BOOKING_ID
$$
DELIMITER ;
DELIMITER $$
CREATE TRIGGER `update_fb` AFTER UPDATE ON `food_booking` FOR EACH ROW UPDATE booking
SET booking.FOOD_PRICE = (SELECT SUM(foodcombo.PRICE) 
FROM foodcombo, food_booking
WHERE food_booking.FOOD_ID = foodcombo.ID
AND food_booking.BOOKING_ID =New.BOOKING_ID)
WHERE booking.ID = New.BOOKING_ID
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Table structure for table `movie`
--

CREATE TABLE `movie` (
  `id` bigint(20) NOT NULL,
  `actors` varchar(255) DEFAULT NULL,
  `closing_day` datetime(6) DEFAULT NULL,
  `director` varchar(255) DEFAULT NULL,
  `duration` int(11) NOT NULL,
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
  `id` int(11) NOT NULL,
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
  `id` int(11) NOT NULL,
  `end_time` datetime(6) DEFAULT NULL,
  `start_time` datetime(6) DEFAULT NULL,
  `movie_id` bigint(20) DEFAULT NULL,
  `showroom_id` bigint(20) DEFAULT NULL,
  `price` float NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `schedule`
--

INSERT INTO `schedule` (`id`, `end_time`, `start_time`, `movie_id`, `showroom_id`, `price`) VALUES
(4, '2023-04-30 08:25:00.000000', '2023-04-30 06:00:00.000000', 1, 5, 100000),
(5, '2023-04-29 09:25:00.000000', '2023-04-29 07:00:00.000000', 1, 5, 90000),
(6, '2023-04-29 09:25:00.000000', '2023-04-29 07:00:00.000000', 1, 6, 100000);

-- --------------------------------------------------------

--
-- Table structure for table `seat`
--

CREATE TABLE `seat` (
  `id` int(11) NOT NULL,
  `seat_number` varchar(3) NOT NULL,
  `seat_type` varchar(255) DEFAULT NULL,
  `showroom_id` bigint(20) DEFAULT NULL
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
(180, 'J5', 'Couple', 5),
(181, 'A1', 'Standard', 6),
(182, 'A2', 'Standard', 6),
(183, 'A3', 'Standard', 6),
(184, 'A4', 'Standard', 6),
(185, 'A5', 'Standard', 6),
(186, 'A6', 'Standard', 6),
(187, 'A7', 'Standard', 6),
(188, 'A8', 'Standard', 6),
(189, 'A9', 'Standard', 6),
(190, 'A10', 'Standard', 6),
(191, 'B1', 'Standard', 6),
(192, 'B2', 'Standard', 6),
(193, 'B3', 'Standard', 6),
(194, 'B4', 'Standard', 6),
(195, 'B5', 'Standard', 6),
(196, 'B6', 'Standard', 6),
(197, 'B7', 'Standard', 6),
(198, 'B8', 'Standard', 6),
(199, 'B9', 'Standard', 6),
(200, 'B10', 'Standard', 6),
(201, 'C1', 'Standard', 6),
(202, 'C2', 'Standard', 6),
(203, 'C3', 'Standard', 6),
(204, 'C4', 'Standard', 6),
(205, 'C5', 'Standard', 6),
(206, 'C6', 'Standard', 6),
(207, 'C7', 'Standard', 6),
(208, 'C8', 'Standard', 6),
(209, 'C9', 'Standard', 6),
(210, 'C10', 'Standard', 6),
(211, 'D1', 'Standard', 6),
(212, 'D2', 'Standard', 6),
(213, 'D3', 'Standard', 6),
(214, 'D4', 'Standard', 6),
(215, 'D5', 'Standard', 6),
(216, 'D6', 'Standard', 6),
(217, 'D7', 'Standard', 6),
(218, 'D8', 'Standard', 6),
(219, 'D9', 'Standard', 6),
(220, 'D10', 'Standard', 6),
(221, 'E1', 'Standard', 6),
(222, 'E2', 'Standard', 6),
(223, 'E3', 'Standard', 6),
(224, 'E4', 'Standard', 6),
(225, 'E5', 'Standard', 6),
(226, 'E6', 'Standard', 6),
(227, 'E7', 'Standard', 6),
(228, 'E8', 'Standard', 6),
(229, 'E9', 'Standard', 6),
(230, 'E10', 'Standard', 6),
(231, 'F1', 'Standard', 6),
(232, 'F2', 'Standard', 6),
(233, 'F3', 'Standard', 6),
(234, 'F4', 'Standard', 6),
(235, 'F5', 'Standard', 6),
(236, 'F6', 'Standard', 6),
(237, 'F7', 'Standard', 6),
(238, 'F8', 'Standard', 6),
(239, 'F9', 'Standard', 6),
(240, 'F10', 'Standard', 6),
(241, 'G1', 'Standard', 6),
(242, 'G2', 'Standard', 6),
(243, 'G3', 'Standard', 6),
(244, 'G4', 'Standard', 6),
(245, 'G5', 'Standard', 6),
(246, 'G6', 'Standard', 6),
(247, 'G7', 'Standard', 6),
(248, 'G8', 'Standard', 6),
(249, 'G9', 'Standard', 6),
(250, 'G10', 'Standard', 6),
(251, 'H1', 'Standard', 6),
(252, 'H2', 'Standard', 6),
(253, 'H3', 'Standard', 6),
(254, 'H4', 'Standard', 6),
(255, 'H5', 'Standard', 6),
(256, 'H6', 'Standard', 6),
(257, 'H7', 'Standard', 6),
(258, 'H8', 'Standard', 6),
(259, 'H9', 'Standard', 6),
(260, 'H10', 'Standard', 6),
(261, 'I1', 'Couple', 6),
(262, 'I2', 'Couple', 6),
(263, 'I3', 'Couple', 6),
(264, 'I4', 'Couple', 6),
(265, 'I5', 'Couple', 6),
(266, 'J1', 'Couple', 6),
(267, 'J2', 'Couple', 6),
(268, 'J3', 'Couple', 6),
(269, 'J4', 'Couple', 6),
(270, 'J5', 'Couple', 6);

-- --------------------------------------------------------

--
-- Table structure for table `showroom`
--

CREATE TABLE `showroom` (
  `id` bigint(20) NOT NULL,
  `seat_count` int(11) NOT NULL,
  `showroom_number` int(11) NOT NULL,
  `cinema_id` bigint(20) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `showroom`
--

INSERT INTO `showroom` (`id`, `seat_count`, `showroom_number`, `cinema_id`) VALUES
(5, 90, 6, 1),
(6, 90, 1, 3);

-- --------------------------------------------------------

--
-- Table structure for table `spring_session`
--

CREATE TABLE `spring_session` (
  `PRIMARY_ID` char(36) NOT NULL,
  `SESSION_ID` char(36) NOT NULL,
  `CREATION_TIME` bigint(20) NOT NULL,
  `LAST_ACCESS_TIME` bigint(20) NOT NULL,
  `MAX_INACTIVE_INTERVAL` int(11) NOT NULL,
  `EXPIRY_TIME` bigint(20) NOT NULL,
  `PRINCIPAL_NAME` varchar(100) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci ROW_FORMAT=DYNAMIC;

--
-- Dumping data for table `spring_session`
--

INSERT INTO `spring_session` (`PRIMARY_ID`, `SESSION_ID`, `CREATION_TIME`, `LAST_ACCESS_TIME`, `MAX_INACTIVE_INTERVAL`, `EXPIRY_TIME`, `PRINCIPAL_NAME`) VALUES
('0ddc57a5-14ba-4830-9380-1f5389801a57', 'bc9f1f9f-3153-4794-abfb-bcc9744db53d', 1682827641315, 1682827642286, 1800, 1682829442286, 'a@gmasail.com');

-- --------------------------------------------------------

--
-- Table structure for table `spring_session_attributes`
--

CREATE TABLE `spring_session_attributes` (
  `SESSION_PRIMARY_ID` char(36) NOT NULL,
  `ATTRIBUTE_NAME` varchar(200) NOT NULL,
  `ATTRIBUTE_BYTES` blob NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci ROW_FORMAT=DYNAMIC;

--
-- Dumping data for table `spring_session_attributes`
--

INSERT INTO `spring_session_attributes` (`SESSION_PRIMARY_ID`, `ATTRIBUTE_NAME`, `ATTRIBUTE_BYTES`) VALUES
('0ddc57a5-14ba-4830-9380-1f5389801a57', 'SPRING_SECURITY_CONTEXT', 0xaced00057372003d6f72672e737072696e676672616d65776f726b2e73656375726974792e636f72652e636f6e746578742e5365637572697479436f6e74657874496d706c00000000000002580200014c000e61757468656e7469636174696f6e7400324c6f72672f737072696e676672616d65776f726b2f73656375726974792f636f72652f41757468656e7469636174696f6e3b78707372004f6f72672e737072696e676672616d65776f726b2e73656375726974792e61757468656e7469636174696f6e2e557365726e616d6550617373776f726441757468656e7469636174696f6e546f6b656e00000000000002580200024c000b63726564656e7469616c737400124c6a6176612f6c616e672f4f626a6563743b4c00097072696e636970616c71007e0004787200476f72672e737072696e676672616d65776f726b2e73656375726974792e61757468656e7469636174696f6e2e416273747261637441757468656e7469636174696f6e546f6b656ed3aa287e6e47640e0200035a000d61757468656e746963617465644c000b617574686f7269746965737400164c6a6176612f7574696c2f436f6c6c656374696f6e3b4c000764657461696c7371007e0004787001737200266a6176612e7574696c2e436f6c6c656374696f6e7324556e6d6f6469666961626c654c697374fc0f2531b5ec8e100200014c00046c6973747400104c6a6176612f7574696c2f4c6973743b7872002c6a6176612e7574696c2e436f6c6c656374696f6e7324556e6d6f6469666961626c65436f6c6c656374696f6e19420080cb5ef71e0200014c00016371007e00067870737200136a6176612e7574696c2e41727261794c6973747881d21d99c7619d03000149000473697a65787000000001770400000001737200426f72672e737072696e676672616d65776f726b2e73656375726974792e636f72652e617574686f726974792e53696d706c654772616e746564417574686f7269747900000000000002580200014c0004726f6c657400124c6a6176612f6c616e672f537472696e673b7870740004555345527871007e000d737200486f72672e737072696e676672616d65776f726b2e73656375726974792e7765622e61757468656e7469636174696f6e2e57656241757468656e7469636174696f6e44657461696c7300000000000002580200024c000d72656d6f74654164647265737371007e000f4c000973657373696f6e496471007e000f787074000f303a303a303a303a303a303a303a317070737200326f72672e737072696e676672616d65776f726b2e73656375726974792e636f72652e7573657264657461696c732e5573657200000000000002580200075a00116163636f756e744e6f6e457870697265645a00106163636f756e744e6f6e4c6f636b65645a001563726564656e7469616c734e6f6e457870697265645a0007656e61626c65644c000b617574686f72697469657374000f4c6a6176612f7574696c2f5365743b4c000870617373776f726471007e000f4c0008757365726e616d6571007e000f787001010101737200256a6176612e7574696c2e436f6c6c656374696f6e7324556e6d6f6469666961626c65536574801d92d18f9b80550200007871007e000a737200116a6176612e7574696c2e54726565536574dd98509395ed875b0300007870737200466f72672e737072696e676672616d65776f726b2e73656375726974792e636f72652e7573657264657461696c732e5573657224417574686f72697479436f6d70617261746f720000000000000258020000787077040000000171007e0010787074000d6140676d617361696c2e636f6d);

-- --------------------------------------------------------

--
-- Table structure for table `ticket`
--

CREATE TABLE `ticket` (
  `id` int(11) NOT NULL,
  `price` float NOT NULL,
  `booking_id` int(11) DEFAULT NULL,
  `schedule_id` int(11) DEFAULT NULL,
  `seat_id` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `ticket`
--

INSERT INTO `ticket` (`id`, `price`, `booking_id`, `schedule_id`, `seat_id`) VALUES
(1, 90000, 1, 4, 91),
(2, 90000, 2, 4, 92),
(3, 90000, 2, 4, 93),
(4, 90000, 2, 4, 94),
(5, 90000, 3, 4, 95),
(6, 90000, 3, 4, 96),
(7, 90000, NULL, 4, 97),
(8, 90000, 1, 4, 98),
(9, 90000, NULL, 4, 99),
(10, 90000, NULL, 4, 100),
(11, 90000, NULL, 4, 101),
(12, 90000, NULL, 4, 102),
(13, 90000, 4, 4, 103),
(14, 90000, 4, 4, 104),
(15, 90000, NULL, 4, 105),
(16, 90000, NULL, 4, 106),
(17, 90000, NULL, 4, 107),
(18, 90000, NULL, 4, 108),
(19, 90000, NULL, 4, 109),
(20, 90000, NULL, 4, 110),
(21, 90000, NULL, 4, 111),
(22, 90000, NULL, 4, 112),
(23, 90000, NULL, 4, 113),
(24, 90000, NULL, 4, 114),
(25, 90000, NULL, 4, 115),
(26, 90000, NULL, 4, 116),
(27, 90000, NULL, 4, 117),
(28, 90000, NULL, 4, 118),
(29, 90000, NULL, 4, 119),
(30, 90000, NULL, 4, 120),
(31, 90000, NULL, 4, 121),
(32, 90000, NULL, 4, 122),
(33, 90000, NULL, 4, 123),
(34, 90000, NULL, 4, 124),
(35, 90000, NULL, 4, 125),
(36, 90000, NULL, 4, 126),
(37, 90000, NULL, 4, 127),
(38, 90000, NULL, 4, 128),
(39, 90000, NULL, 4, 129),
(40, 90000, NULL, 4, 130),
(41, 90000, NULL, 4, 131),
(42, 90000, NULL, 4, 132),
(43, 90000, NULL, 4, 133),
(44, 90000, NULL, 4, 134),
(45, 90000, NULL, 4, 135),
(46, 90000, NULL, 4, 136),
(47, 90000, NULL, 4, 137),
(48, 90000, NULL, 4, 138),
(49, 90000, NULL, 4, 139),
(50, 90000, NULL, 4, 140),
(51, 90000, NULL, 4, 141),
(52, 90000, NULL, 4, 142),
(53, 90000, NULL, 4, 143),
(54, 90000, NULL, 4, 144),
(55, 90000, NULL, 4, 145),
(56, 90000, NULL, 4, 146),
(57, 90000, NULL, 4, 147),
(58, 90000, NULL, 4, 148),
(59, 90000, NULL, 4, 149),
(60, 90000, NULL, 4, 150),
(61, 90000, NULL, 4, 151),
(62, 90000, NULL, 4, 152),
(63, 90000, NULL, 4, 153),
(64, 90000, NULL, 4, 154),
(65, 90000, NULL, 4, 155),
(66, 90000, NULL, 4, 156),
(67, 90000, NULL, 4, 157),
(68, 90000, NULL, 4, 158),
(69, 90000, NULL, 4, 159),
(70, 90000, NULL, 4, 160),
(71, 90000, NULL, 4, 161),
(72, 90000, NULL, 4, 162),
(73, 90000, NULL, 4, 163),
(74, 90000, NULL, 4, 164),
(75, 90000, NULL, 4, 165),
(76, 90000, NULL, 4, 166),
(77, 90000, NULL, 4, 167),
(78, 90000, NULL, 4, 168),
(79, 90000, NULL, 4, 169),
(80, 90000, NULL, 4, 170),
(81, 90000, NULL, 4, 171),
(82, 90000, NULL, 4, 172),
(83, 90000, NULL, 4, 173),
(84, 90000, NULL, 4, 174),
(85, 90000, NULL, 4, 175),
(86, 90000, NULL, 4, 176),
(87, 90000, NULL, 4, 177),
(88, 90000, NULL, 4, 178),
(89, 90000, NULL, 4, 179),
(90, 90000, NULL, 4, 180),
(91, 90000, NULL, 5, 91),
(92, 90000, NULL, 5, 92),
(93, 90000, NULL, 5, 93),
(94, 90000, NULL, 5, 94),
(95, 90000, NULL, 5, 95),
(96, 90000, NULL, 5, 96),
(97, 90000, NULL, 5, 97),
(98, 90000, NULL, 5, 98),
(99, 90000, NULL, 5, 99),
(100, 90000, NULL, 5, 100),
(101, 90000, NULL, 5, 101),
(102, 90000, NULL, 5, 102),
(103, 90000, NULL, 5, 103),
(104, 90000, NULL, 5, 104),
(105, 90000, NULL, 5, 105),
(106, 90000, NULL, 5, 106),
(107, 90000, NULL, 5, 107),
(108, 90000, NULL, 5, 108),
(109, 90000, NULL, 5, 109),
(110, 90000, NULL, 5, 110),
(111, 90000, NULL, 5, 111),
(112, 90000, NULL, 5, 112),
(113, 90000, NULL, 5, 113),
(114, 90000, NULL, 5, 114),
(115, 90000, NULL, 5, 115),
(116, 90000, NULL, 5, 116),
(117, 90000, NULL, 5, 117),
(118, 90000, NULL, 5, 118),
(119, 90000, NULL, 5, 119),
(120, 90000, NULL, 5, 120),
(121, 90000, NULL, 5, 121),
(122, 90000, NULL, 5, 122),
(123, 90000, NULL, 5, 123),
(124, 90000, NULL, 5, 124),
(125, 90000, NULL, 5, 125),
(126, 90000, NULL, 5, 126),
(127, 90000, NULL, 5, 127),
(128, 90000, NULL, 5, 128),
(129, 90000, NULL, 5, 129),
(130, 90000, NULL, 5, 130),
(131, 90000, NULL, 5, 131),
(132, 90000, NULL, 5, 132),
(133, 90000, NULL, 5, 133),
(134, 90000, NULL, 5, 134),
(135, 90000, NULL, 5, 135),
(136, 90000, NULL, 5, 136),
(137, 90000, NULL, 5, 137),
(138, 90000, NULL, 5, 138),
(139, 90000, NULL, 5, 139),
(140, 90000, NULL, 5, 140),
(141, 90000, NULL, 5, 141),
(142, 90000, NULL, 5, 142),
(143, 90000, NULL, 5, 143),
(144, 90000, NULL, 5, 144),
(145, 90000, NULL, 5, 145),
(146, 90000, NULL, 5, 146),
(147, 90000, NULL, 5, 147),
(148, 90000, NULL, 5, 148),
(149, 90000, NULL, 5, 149),
(150, 90000, NULL, 5, 150),
(151, 90000, NULL, 5, 151),
(152, 90000, NULL, 5, 152),
(153, 90000, NULL, 5, 153),
(154, 90000, NULL, 5, 154),
(155, 90000, NULL, 5, 155),
(156, 90000, NULL, 5, 156),
(157, 90000, NULL, 5, 157),
(158, 90000, NULL, 5, 158),
(159, 90000, NULL, 5, 159),
(160, 90000, NULL, 5, 160),
(161, 90000, NULL, 5, 161),
(162, 90000, NULL, 5, 162),
(163, 90000, NULL, 5, 163),
(164, 90000, NULL, 5, 164),
(165, 90000, NULL, 5, 165),
(166, 90000, NULL, 5, 166),
(167, 90000, NULL, 5, 167),
(168, 90000, NULL, 5, 168),
(169, 90000, NULL, 5, 169),
(170, 90000, NULL, 5, 170),
(171, 90000, NULL, 5, 171),
(172, 90000, NULL, 5, 172),
(173, 90000, NULL, 5, 173),
(174, 90000, NULL, 5, 174),
(175, 90000, NULL, 5, 175),
(176, 90000, NULL, 5, 176),
(177, 90000, NULL, 5, 177),
(178, 90000, NULL, 5, 178),
(179, 90000, NULL, 5, 179),
(180, 90000, NULL, 5, 180),
(181, 0, NULL, 6, 181),
(182, 0, NULL, 6, 182),
(183, 0, 1, 6, 183),
(184, 0, 1, 6, 184),
(185, 0, NULL, 6, 185),
(186, 0, NULL, 6, 186),
(187, 0, NULL, 6, 187),
(188, 0, NULL, 6, 188),
(189, 0, NULL, 6, 189),
(190, 0, NULL, 6, 190),
(191, 0, NULL, 6, 191),
(192, 0, NULL, 6, 192),
(193, 0, NULL, 6, 193),
(194, 0, NULL, 6, 194),
(195, 0, NULL, 6, 195),
(196, 0, NULL, 6, 196),
(197, 0, NULL, 6, 197),
(198, 0, NULL, 6, 198),
(199, 0, NULL, 6, 199),
(200, 0, NULL, 6, 200),
(201, 0, NULL, 6, 201),
(202, 0, NULL, 6, 202),
(203, 0, NULL, 6, 203),
(204, 0, NULL, 6, 204),
(205, 0, NULL, 6, 205),
(206, 0, NULL, 6, 206),
(207, 0, NULL, 6, 207),
(208, 0, NULL, 6, 208),
(209, 0, NULL, 6, 209),
(210, 0, NULL, 6, 210),
(211, 0, NULL, 6, 211),
(212, 0, NULL, 6, 212),
(213, 0, NULL, 6, 213),
(214, 0, NULL, 6, 214),
(215, 0, NULL, 6, 215),
(216, 0, NULL, 6, 216),
(217, 0, NULL, 6, 217),
(218, 0, NULL, 6, 218),
(219, 0, NULL, 6, 219),
(220, 0, NULL, 6, 220),
(221, 0, NULL, 6, 221),
(222, 0, NULL, 6, 222),
(223, 0, NULL, 6, 223),
(224, 0, NULL, 6, 224),
(225, 0, NULL, 6, 225),
(226, 0, NULL, 6, 226),
(227, 0, NULL, 6, 227),
(228, 0, NULL, 6, 228),
(229, 0, NULL, 6, 229),
(230, 0, NULL, 6, 230),
(231, 0, NULL, 6, 231),
(232, 0, NULL, 6, 232),
(233, 0, NULL, 6, 233),
(234, 0, NULL, 6, 234),
(235, 0, NULL, 6, 235),
(236, 0, NULL, 6, 236),
(237, 0, NULL, 6, 237),
(238, 0, NULL, 6, 238),
(239, 0, NULL, 6, 239),
(240, 0, NULL, 6, 240),
(241, 0, NULL, 6, 241),
(242, 0, NULL, 6, 242),
(243, 0, NULL, 6, 243),
(244, 0, NULL, 6, 244),
(245, 0, NULL, 6, 245),
(246, 0, NULL, 6, 246),
(247, 0, NULL, 6, 247),
(248, 0, NULL, 6, 248),
(249, 0, NULL, 6, 249),
(250, 0, NULL, 6, 250),
(251, 0, NULL, 6, 251),
(252, 0, NULL, 6, 252),
(253, 0, NULL, 6, 253),
(254, 0, NULL, 6, 254),
(255, 0, NULL, 6, 255),
(256, 0, NULL, 6, 256),
(257, 0, NULL, 6, 257),
(258, 0, NULL, 6, 258),
(259, 0, NULL, 6, 259),
(260, 0, NULL, 6, 260),
(261, 0, NULL, 6, 261),
(262, 0, NULL, 6, 262),
(263, 0, NULL, 6, 263),
(264, 0, NULL, 6, 264),
(265, 0, NULL, 6, 265),
(266, 0, NULL, 6, 266),
(267, 0, NULL, 6, 267),
(268, 0, NULL, 6, 268),
(269, 0, NULL, 6, 269),
(270, 0, NULL, 6, 270);

--
-- Triggers `ticket`
--
DELIMITER $$
CREATE TRIGGER `update_ticket` AFTER UPDATE ON `ticket` FOR EACH ROW UPDATE booking
SET booking.TICKET_PRICE = (SELECT SUM(ticket.price) 
FROM ticket
WHERE ticket.booking_id =New.BOOKING_ID)
WHERE booking.ID = New.BOOKING_ID
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Table structure for table `user`
--

CREATE TABLE `user` (
  `id` int(11) NOT NULL,
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
(2, 'Lê Văn Sỹ, Q3, TP HCM', '2023-04-13 10:46:11.000000', 'admin', 'Võ Trọng Tình admin', '$2a$10$PorULG8O9YsghWpAShvBs.gEQde2vlP3xAxyJOCbbqHsmvvRMll7S'),
(3, 'Lê Văn Sỹ, Q3, TP HCM', '2023-03-28 08:31:33.000000', 'user', 'Võ Trọng Tình', '$2a$10$ND46UkjkLdIh62u/1ezyEe.eLLQ26akBAUDptXhB51Trxj3Bcu1nm'),
(6, 'LongAn Kingdom', '2023-04-27 00:14:23.923000', 'DucCong', 'DucCong', '$2a$10$A3QxsY2U8IMLM2WTQoA9/OrHRfxlm1.rUnVobyOrsV2JFEbTn3u6i'),
(11, 'Dong Nai', '2023-04-30 11:07:10.000000', 'a@gmasail.com', 'Trọng Tình Võ', '$2a$10$44Af.WxQAZZSd2wwXENeiuOEyxMYm02la/lQ9DKwpj24NNsc5cpnG');

-- --------------------------------------------------------

--
-- Table structure for table `users_roles`
--

CREATE TABLE `users_roles` (
  `user_id` int(11) NOT NULL,
  `role_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `users_roles`
--

INSERT INTO `users_roles` (`user_id`, `role_id`) VALUES
(1, 1),
(2, 1),
(2, 2),
(3, 2),
(6, 1),
(11, 2);

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
  ADD PRIMARY KEY (`food_id`,`booking_id`),
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
-- Indexes for table `spring_session`
--
ALTER TABLE `spring_session`
  ADD PRIMARY KEY (`PRIMARY_ID`),
  ADD UNIQUE KEY `SPRING_SESSION_IX1` (`SESSION_ID`),
  ADD KEY `SPRING_SESSION_IX2` (`EXPIRY_TIME`),
  ADD KEY `SPRING_SESSION_IX3` (`PRINCIPAL_NAME`);

--
-- Indexes for table `spring_session_attributes`
--
ALTER TABLE `spring_session_attributes`
  ADD PRIMARY KEY (`SESSION_PRIMARY_ID`,`ATTRIBUTE_NAME`);

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
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT for table `cinema`
--
ALTER TABLE `cinema`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT for table `foodcombo`
--
ALTER TABLE `foodcombo`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=10;

--
-- AUTO_INCREMENT for table `movie`
--
ALTER TABLE `movie`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=36;

--
-- AUTO_INCREMENT for table `role`
--
ALTER TABLE `role`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT for table `schedule`
--
ALTER TABLE `schedule`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- AUTO_INCREMENT for table `seat`
--
ALTER TABLE `seat`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=271;

--
-- AUTO_INCREMENT for table `showroom`
--
ALTER TABLE `showroom`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- AUTO_INCREMENT for table `ticket`
--
ALTER TABLE `ticket`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=271;

--
-- AUTO_INCREMENT for table `user`
--
ALTER TABLE `user`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=12;

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
-- Constraints for table `spring_session_attributes`
--
ALTER TABLE `spring_session_attributes`
  ADD CONSTRAINT `SPRING_SESSION_ATTRIBUTES_FK` FOREIGN KEY (`SESSION_PRIMARY_ID`) REFERENCES `spring_session` (`PRIMARY_ID`) ON DELETE CASCADE;

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
