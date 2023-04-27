-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Apr 27, 2023 at 12:07 AM
-- Server version: 10.4.28-MariaDB
-- PHP Version: 8.0.28

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

--
-- Indexes for dumped tables
--

--
-- Indexes for table `movie`
--
ALTER TABLE `movie`
  ADD PRIMARY KEY (`id`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `movie`
--
ALTER TABLE `movie`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=25;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
