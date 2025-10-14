INSERT INTO LoaiHang (id_loai, tenloai, tinhtrang) VALUES
(1, N'Điện thoại', N'Hoạt động'),
(2, N'Laptop', N'Hoạt động'),
(3, N'Máy tính bảng', N'Hoạt động'),
(4, N'Tai nghe', N'Hoạt động'),
(5, N'Phụ kiện', N'Hoạt động');
-- Script SQL để chèn 100 sản phẩm mẫu vào bảng MatHang
-- Đảm bảo bạn đã XÓA DỮ LIỆU CŨ trong bảng MatHang nếu có, hoặc sử dụng câu lệnh INSERT IGNORE/ON DUPLICATE KEY UPDATE nếu hệ quản trị CSDL của bạn hỗ trợ.

-- Loại 1: Điện thoại (id_loai = 1)
INSERT INTO MatHang (id_hang, id_loai, tenhang, donvitinh, dongia, soluongton, mota, hinhanh, tinhtrang) VALUES
(1, 1, N'iPhone 16 Pro Max 256GB', N'Cái', 32000000, 50, N'Điện thoại cao cấp nhất của Apple với chip A18 Bionic.', N'Images_DB/Loai_1/1.jpg', N'Còn hàng'),
(2, 1, N'Samsung Galaxy S25 Ultra 512GB', N'Cái', 28000000, 45, N'Flagship Android với camera 200MP và bút S-Pen.', N'Images_DB/Loai_1/2.jpg', N'Còn hàng'),
(3, 1, N'Google Pixel 10 Pro', N'Cái', 20000000, 30, N'Điện thoại Android thuần Google, camera AI đỉnh cao.', N'Images_DB/Loai_1/3.jpg', N'Còn hàng'),
(4, 1, N'Xiaomi 15 Pro', N'Cái', 17000000, 60, N'Hiệu năng mạnh mẽ, sạc siêu nhanh 120W.', N'Images_DB/Loai_1/4.jpg', N'Còn hàng'),
(5, 1, N'Oppo Find X7 Pro', N'Cái', 19000000, 35, N'Thiết kế độc đáo, camera Hasselblad ấn tượng.', N'Images_DB/Loai_1/5.jpg', N'Còn hàng'),
(6, 1, N'Vivo X100 Pro', N'Cái', 18500000, 40, N'Camera Zeiss, hiệu năng mạnh mẽ.', N'Images_DB/Loai_1/6.jpg', N'Còn hàng'),
(7, 1, N'OnePlus 13', N'Cái', 16000000, 55, N'Trải nghiệm OxygenOS mượt mà, sạc nhanh.', N'Images_DB/Loai_1/7.jpg', N'Còn hàng'),
(8, 1, N'Honor Magic6 Pro', N'Cái', 21000000, 25, N'Công nghệ AI tiên tiến, màn hình sắc nét.', N'Images_DB/Loai_1/8.jpg', N'Còn hàng'),
(9, 1, N'Sony Xperia 1 VI', N'Cái', 23000000, 20, N'Điện thoại dành cho nhiếp ảnh gia, màn hình 4K.', N'Images_DB/Loai_1/9.jpg', N'Còn hàng'),
(10, 1, N'ASUS ROG Phone 9', N'Cái', 24000000, 15, N'Điện thoại chuyên game với tản nhiệt và phụ kiện chơi game.', N'Images_DB/Loai_1/10.jpg', N'Còn hàng'),
(11, 1, N'Realme GT 6', N'Cái', 10000000, 70, N'Điện thoại hiệu năng cao trong tầm giá.', N'https://yourwebsite.com/images/realme_gt_6.jpg', N'Còn hàng'),
(12, 1, N'POCO F7', N'Cái', 8000000, 80, N'Cấu hình mạnh, pin lớn, sạc nhanh.', N'https://yourwebsite.com/images/poco_f7.jpg', N'Còn hàng'),
(13, 1, N'Redmi Note 15 Pro', N'Cái', 7000000, 90, N'Điện thoại tầm trung bán chạy, pin bền.', N'https://yourwebsite.com/images/redmi_note_15_pro.jpg', N'Còn hàng'),
(14, 1, N'Infinix Note 40 Pro', N'Cái', 5000000, 100, N'Giá phải chăng, màn hình lớn, camera tốt.', N'https://yourwebsite.com/images/infinix_note_40_pro.jpg', N'Còn hàng'),
(15, 1, N'Tecno Camon 30 Pro', N'Cái', 6000000, 85, N'Camera selfie chất lượng, thiết kế đẹp.', N'https://yourwebsite.com/images/tecno_camon_30_pro.jpg', N'Còn hàng'),
(16, 1, N'Nokia X30', N'Cái', 9000000, 40, N'Bền bỉ, cập nhật phần mềm lâu dài.', N'https://yourwebsite.com/images/nokia_x30.jpg', N'Còn hàng'),
(17, 1, N'Fairphone 6', N'Cái', 15000000, 10, N'Điện thoại thân thiện môi trường, dễ sửa chữa.', N'https://yourwebsite.com/images/fairphone_6.jpg', N'Còn hàng'),
(18, 1, N'Zenfone 11', N'Cái', 14000000, 20, N'Thiết kế nhỏ gọn, hiệu năng cao.', N'https://yourwebsite.com/images/zenfone_11.jpg', N'Còn hàng'),
(19, 1, N'Motorola Edge 50 Ultra', N'Cái', 17500000, 25, N'Camera AI, thiết kế sang trọng.', N'https://yourwebsite.com/images/motorola_edge_50_ultra.jpg', N'Còn hàng'),
(20, 1, N'Samsung Galaxy Z Fold 7', N'Cái', 45000000, 10, N'Điện thoại gập cao cấp, đa nhiệm.', N'https://yourwebsite.com/images/samsung_z_fold_7.jpg', N'Còn hàng');

-- Loại 2: Laptop (id_loai = 2)
INSERT INTO MatHang (id_hang, id_loai, tenhang, donvitinh, dongia, soluongton, mota, hinhanh, tinhtrang) VALUES
(21, 2, N'MacBook Air M3 13 inch', N'Chiếc', 28000000, 40, N'Laptop siêu mỏng nhẹ, hiệu năng mạnh mẽ từ chip M3.', N'https://yourwebsite.com/images/macbook_air_m3.jpg', N'Còn hàng'),
(22, 2, N'Dell XPS 15 (Core Ultra 9)', N'Chiếc', 35000000, 30, N'Laptop cao cấp cho công việc sáng tạo, màn hình OLED.', N'https://yourwebsite.com/images/dell_xps_15.jpg', N'Còn hàng'),
(23, 2, N'HP Spectre x360 14', N'Chiếc', 29000000, 25, N'Laptop 2-in-1 sang trọng, màn hình cảm ứng xoay gập.', N'https://yourwebsite.com/images/hp_spectre_x360_14.jpg', N'Còn hàng'),
(24, 2, N'Lenovo ThinkPad X1 Carbon Gen 12', N'Chiếc', 33000000, 20, N'Laptop doanh nhân siêu bền, bảo mật cao.', N'https://yourwebsite.com/images/lenovo_x1_carbon.jpg', N'Còn hàng'),
(25, 2, N'ASUS ROG Zephyrus G16 (RTX 4070)', N'Chiếc', 40000000, 15, N'Laptop gaming mạnh mẽ, thiết kế mỏng nhẹ.', N'https://yourwebsite.com/images/asus_rog_g16.jpg', N'Còn hàng'),
(26, 2, N'MSI Katana 17 (RTX 4060)', N'Chiếc', 25000000, 30, N'Laptop gaming hiệu năng tốt trong tầm giá.', N'https://yourwebsite.com/images/msi_katana_17.jpg', N'Còn hàng'),
(27, 2, N'Acer Predator Helios Neo 16', N'Chiếc', 27000000, 25, N'Laptop gaming màn hình lớn, tản nhiệt hiệu quả.', N'https://yourwebsite.com/images/acer_helios_neo_16.jpg', N'Còn hàng'),
(28, 2, N'Gigabyte AORUS 17H', N'Chiếc', 38000000, 10, N'Laptop gaming chuyên nghiệp, hiệu năng đỉnh cao.', N'https://yourwebsite.com/images/gigabyte_aorus_17h.jpg', N'Còn hàng'),
(29, 2, N'Microsoft Surface Laptop 6', N'Chiếc', 26000000, 35, N'Laptop mỏng nhẹ của Microsoft, tích hợp AI.', N'https://yourwebsite.com/images/surface_laptop_6.jpg', N'Còn hàng'),
(30, 2, N'LG Gram 17 (2025)', N'Chiếc', 30000000, 20, N'Laptop siêu nhẹ với màn hình 17 inch.', N'https://yourwebsite.com/images/lg_gram_17.jpg', N'Còn hàng'),
(31, 2, N'Samsung Galaxy Book 5 Pro', N'Chiếc', 24000000, 30, N'Thiết kế thanh lịch, tích hợp hệ sinh thái Samsung.', N'https://yourwebsite.com/images/samsung_galaxy_book_5_pro.jpg', N'Còn hàng'),
(32, 2, N'Razer Blade 15 (RTX 4080)', N'Chiếc', 42000000, 10, N'Laptop gaming thiết kế tối giản, hiệu năng cao.', N'https://yourwebsite.com/images/razer_blade_15.jpg', N'Còn hàng'),
(33, 2, N'Xiaomi Laptop Pro X 2025', N'Chiếc', 21000000, 25, N'Laptop cấu hình tốt, màn hình đẹp trong tầm giá.', N'https://yourwebsite.com/images/xiaomi_laptop_pro_x.jpg', N'Còn hàng'),
(34, 2, N'Huawei MateBook X Pro (2025)', N'Chiếc', 27000000, 18, N'Màn hình cảm ứng 3K, thiết kế cao cấp.', N'https://yourwebsite.com/images/huawei_matebook_x_pro.jpg', N'Còn hàng'),
(35, 2, N'Acer Swift Go 14', N'Chiếc', 17000000, 45, N'Laptop ultrabook mỏng nhẹ, hiệu năng ổn định.', N'https://yourwebsite.com/images/acer_swift_go_14.jpg', N'Còn hàng'),
(36, 2, N'Dell Inspiron 16', N'Chiếc', 15000000, 50, N'Laptop đa năng cho học tập và làm việc.', N'https://yourwebsite.com/images/dell_inspiron_16.jpg', N'Còn hàng'),
(37, 2, N'HP Pavilion 15', N'Chiếc', 13000000, 60, N'Laptop phổ thông, đáp ứng tốt nhu cầu cơ bản.', N'https://yourwebsite.com/images/hp_pavilion_15.jpg', N'Còn hàng'),
(38, 2, N'Lenovo IdeaPad Slim 5', N'Chiếc', 14000000, 55, N'Laptop mỏng nhẹ, pin tốt, giá phải chăng.', N'https://yourwebsite.com/images/lenovo_ideapad_slim_5.jpg', N'Còn hàng'),
(39, 2, N'ASUS Vivobook 14', N'Chiếc', 12000000, 65, N'Laptop sinh viên, nhân viên văn phòng.', N'https://yourwebsite.com/images/asus_vivobook_14.jpg', N'Còn hàng'),
(40, 2, N'Chromebook HP x360', N'Chiếc', 8000000, 70, N'Chromebook linh hoạt, nhanh chóng.', N'https://yourwebsite.com/images/chromebook_hp_x360.jpg', N'Còn hàng');

-- Loại 3: Máy tính bảng (id_loai = 3)
INSERT INTO MatHang (id_hang, id_loai, tenhang, donvitinh, dongia, soluongton, mota, hinhanh, tinhtrang) VALUES
(41, 3, N'iPad Pro M4 13 inch', N'Cái', 38000000, 30, N'Máy tính bảng mạnh nhất của Apple với chip M4.', N'https://yourwebsite.com/images/ipad_pro_m4_13.jpg', N'Còn hàng'),
(42, 3, N'Samsung Galaxy Tab S10 Ultra', N'Cái', 25000000, 25, N'Máy tính bảng Android lớn nhất, màn hình AMOLED.', N'https://yourwebsite.com/images/galaxy_tab_s10_ultra.jpg', N'Còn hàng'),
(43, 3, N'Microsoft Surface Pro 11', N'Cái', 22000000, 20, N'Máy tính bảng 2-in-1 chạy Windows, hiệu năng mạnh.', N'https://yourwebsite.com/images/surface_pro_11.jpg', N'Còn hàng'),
(44, 3, N'Xiaomi Pad 7 Pro', N'Cái', 12000000, 40, N'Máy tính bảng Android cấu hình cao, màn hình 120Hz.', N'https://yourwebsite.com/images/xiaomi_pad_7_pro.jpg', N'Còn hàng'),
(45, 3, N'Lenovo Tab P12 Pro', N'Cái', 15000000, 35, N'Máy tính bảng giải trí cao cấp, màn hình OLED.', N'https://yourwebsite.com/images/lenovo_tab_p12_pro.jpg', N'Còn hàng'),
(46, 3, N'Google Pixel Tablet 2', N'Cái', 13000000, 30, N'Máy tính bảng tích hợp loa đế sạc, trải nghiệm Google thuần.', N'https://yourwebsite.com/images/pixel_tablet_2.jpg', N'Còn hàng'),
(47, 3, N'OnePlus Pad 2', N'Cái', 11000000, 45, N'Máy tính bảng hiệu năng tốt, thiết kế đẹp.', N'https://yourwebsite.com/images/oneplus_pad_2.jpg', N'Còn hàng'),
(48, 3, N'iPad Air 11 inch M3', N'Cái', 18000000, 50, N'Máy tính bảng mạnh mẽ trong phân khúc tầm trung cao.', N'https://yourwebsite.com/images/ipad_air_m3.jpg', N'Còn hàng'),
(49, 3, N'Samsung Galaxy Tab A9+', N'Cái', 6000000, 70, N'Máy tính bảng giá phải chăng cho giải trí và học tập.', N'https://yourwebsite.com/images/galaxy_tab_a9_plus.jpg', N'Còn hàng'),
(50, 3, N'Huawei MatePad Pro 13.2', N'Cái', 19000000, 20, N'Máy tính bảng màn hình lớn, công nghệ hiển thị đỉnh cao.', N'https://yourwebsite.com/images/huawei_matepad_pro_13_2.jpg', N'Còn hàng'),
(51, 3, N'Amazon Fire Max 11', N'Cái', 5000000, 80, N'Máy tính bảng giá rẻ, giải trí tốt với hệ sinh thái Amazon.', N'https://yourwebsite.com/images/fire_max_11.jpg', N'Còn hàng'),
(52, 3, N'TCL Tab 10s Gen 2', N'Cái', 4000000, 90, N'Máy tính bảng cơ bản cho gia đình.', N'https://yourwebsite.com/images/tcl_tab_10s_gen2.jpg', N'Còn hàng'),
(53, 3, N'Realme Pad 2', N'Cái', 7000000, 60, N'Máy tính bảng màn hình lớn, pin trâu.', N'https://yourwebsite.com/images/realme_pad_2.jpg', N'Còn hàng'),
(54, 3, N'OPPO Pad Neo', N'Cái', 8000000, 55, N'Thiết kế đẹp, màn hình 2K.', N'https://yourwebsite.com/images/oppo_pad_neo.jpg', N'Còn hàng'),
(55, 3, N'Vivo Pad 3 Pro', N'Cái', 16000000, 25, N'Máy tính bảng hiệu năng cao, âm thanh chất lượng.', N'https://yourwebsite.com/images/vivo_pad_3_pro.jpg', N'Còn hàng'),
(56, 3, N'Redmi Pad Pro', N'Cái', 9000000, 40, N'Máy tính bảng mạnh trong phân khúc tầm trung.', N'https://yourwebsite.com/images/redmi_pad_pro.jpg', N'Còn hàng'),
(57, 3, N'Alldocube iPlay 50 Mini Pro', N'Cái', 3500000, 100, N'Máy tính bảng mini giá rẻ, tiện lợi.', N'https://yourwebsite.com/images/alldocube_iplay_50_mini_pro.jpg', N'Còn hàng'),
(58, 3, N'Lenovo Tab M10 Plus Gen 3', N'Cái', 5500000, 75, N'Máy tính bảng giải trí gia đình.', N'https://yourwebsite.com/images/lenovo_tab_m10_plus_gen3.jpg', N'Còn hàng'),
(59, 3, N'Blackview Tab 18', N'Cái', 6500000, 65, N'Máy tính bảng pin lớn, thiết kế bền bỉ.', N'https://yourwebsite.com/images/blackview_tab_18.jpg', N'Còn hàng'),
(60, 3, N'Chuwi HiPad Air', N'Cái', 4800000, 80, N'Máy tính bảng mỏng nhẹ, hiệu năng đủ dùng.', N'https://yourwebsite.com/images/chuwi_hipad_air.jpg', N'Còn hàng');

-- Loại 4: Tai nghe (id_loai = 4)
INSERT INTO MatHang (id_hang, id_loai, tenhang, donvitinh, dongia, soluongton, mota, hinhanh, tinhtrang) VALUES
(61, 4, N'AirPods Pro 3', N'Chiếc', 6000000, 150, N'Tai nghe không dây chống ồn chủ động, âm thanh không gian.', N'https://yourwebsite.com/images/airpods_pro_3.jpg', N'Còn hàng'),
(62, 4, N'Sony WH-1000XM6', N'Chiếc', 7500000, 80, N'Tai nghe chụp tai chống ồn hàng đầu, chất lượng âm thanh tuyệt vời.', N'https://yourwebsite.com/images/sony_wh_1000xm6.jpg', N'Còn hàng'),
(63, 4, N'Bose QuietComfort Ultra Earbuds', N'Chiếc', 6800000, 90, N'Tai nghe nhét tai chống ồn hiệu quả, thoải mái đeo.', N'https://yourwebsite.com/images/bose_qc_ultra_earbuds.jpg', N'Còn hàng'),
(64, 4, N'Samsung Galaxy Buds 4 Pro', N'Chiếc', 3500000, 120, N'Tai nghe không dây tích hợp hệ sinh thái Samsung.', N'https://yourwebsite.com/images/galaxy_buds_4_pro.jpg', N'Còn hàng'),
(65, 4, N'Jabra Elite 10', N'Chiếc', 4000000, 100, N'Tai nghe đàm thoại xuất sắc, âm thanh rõ ràng.', N'https://yourwebsite.com/images/jabra_elite_10.jpg', N'Còn hàng'),
(66, 4, N'Sennheiser Momentum True Wireless 4', N'Chiếc', 7000000, 60, N'Tai nghe cao cấp, chất âm Audiophile.', N'https://yourwebsite.com/images/sennheiser_mtw_4.jpg', N'Còn hàng'),
(67, 4, N'Audio-Technica ATH-M50xBT2', N'Chiếc', 4500000, 70, N'Tai nghe kiểm âm không dây, âm thanh trung thực.', N'https://yourwebsite.com/images/audio_technica_m50xbt2.jpg', N'Còn hàng'),
(68, 4, N'Beats Studio Pro', N'Chiếc', 8000000, 50, N'Tai nghe chụp tai của Beats, âm bass mạnh mẽ.', N'https://yourwebsite.com/images/beats_studio_pro.jpg', N'Còn hàng'),
(69, 4, N'Anker Soundcore Liberty 50', N'Chiếc', 2000000, 180, N'Tai nghe giá tốt, chất lượng âm thanh vượt tầm.', N'https://yourwebsite.com/images/anker_liberty_50.jpg', N'Còn hàng'),
(70, 4, N'Marshall Major V', N'Chiếc', 3000000, 90, N'Tai nghe chụp tai phong cách cổ điển, âm thanh đặc trưng.', N'https://yourwebsite.com/images/marshall_major_v.jpg', N'Còn hàng'),
(71, 4, N'HyperX Cloud Alpha Wireless', N'Chiếc', 3800000, 70, N'Tai nghe gaming không dây, pin siêu trâu.', N'https://yourwebsite.com/images/hyperx_cloud_alpha_wireless.jpg', N'Còn hàng'),
(72, 4, N'Logitech G Pro X 2 LIGHTSPEED', N'Chiếc', 4200000, 65, N'Tai nghe gaming chuyên nghiệp, công nghệ LIGHTSPEED.', N'https://yourwebsite.com/images/logitech_g_pro_x_2.jpg', N'Còn hàng'),
(73, 4, N'Razer BlackShark V2 Pro', N'Chiếc', 3200000, 80, N'Tai nghe gaming âm thanh sống động, micro rõ ràng.', N'https://yourwebsite.com/images/razer_blackshark_v2_pro.jpg', N'Còn hàng'),
(74, 4, N'SteelSeries Arctis Nova 7', N'Chiếc', 4500000, 55, N'Tai nghe gaming đa nền tảng, thoải mái khi đeo.', N'https://yourwebsite.com/images/steelseries_arctis_nova_7.jpg', N'Còn hàng'),
(75, 4, N'Xiaomi Buds 5 Pro', N'Chiếc', 1800000, 130, N'Tai nghe không dây giá phải chăng, chống ồn tốt.', N'https://yourwebsite.com/images/xiaomi_buds_5_pro.jpg', N'Còn hàng'),
(76, 4, N'Oppo Enco X3', N'Chiếc', 2500000, 110, N'Tai nghe không dây hợp tác với Dynaudio, chất âm cao.', N'https://yourwebsite.com/images/oppo_enco_x3.jpg', N'Còn hàng'),
(77, 4, N'Soundpeats H2', N'Chiếc', 1000000, 200, N'Tai nghe TWS giá rẻ, chất âm ổn định.', N'https://yourwebsite.com/images/soundpeats_h2.jpg', N'Còn hàng'),
(78, 4, N'Edifier W800BT Plus', N'Chiếc', 1200000, 140, N'Tai nghe chụp tai giá phổ thông, pin lâu.', N'https://yourwebsite.com/images/edifier_w800bt_plus.jpg', N'Còn hàng'),
(79, 4, N'Realme Buds Air 6 Pro', N'Chiếc', 1600000, 160, N'Tai nghe không dây tầm trung, nhiều tính năng.', N'https://yourwebsite.com/images/realme_buds_air_6_pro.jpg', N'Còn hàng'),
(80, 4, N'Philips Fidelio L4', N'Chiếc', 5500000, 40, N'Tai nghe chụp tai cao cấp, âm thanh chi tiết.', N'https://yourwebsite.com/images/philips_fidelio_l4.jpg', N'Còn hàng');

-- Loại 5: Phụ kiện (id_loai = 5)
INSERT INTO MatHang (id_hang, id_loai, tenhang, donvitinh, dongia, soluongton, mota, hinhanh, tinhtrang) VALUES
(81, 5, N'Sạc nhanh GaN 100W', N'Cái', 800000, 250, N'Cục sạc nhỏ gọn, sạc đa thiết bị công suất cao.', N'https://yourwebsite.com/images/sac_gan_100w.jpg', N'Còn hàng'),
(82, 5, N'Pin dự phòng 20000mAh PD 45W', N'Cái', 1200000, 180, N'Sạc dự phòng dung lượng lớn, hỗ trợ sạc nhanh.', N'https://yourwebsite.com/images/pin_duphong_20k_pd45w.jpg', N'Còn hàng'),
(83, 5, N'Bao da iPad Pro 13 inch có bàn phím', N'Cái', 3500000, 70, N'Bao da tích hợp bàn phím cho iPad.', N'https://yourwebsite.com/images/baoda_ipad_pro_13_keyboard.jpg', N'Còn hàng'),
(84, 5, N'Miếng dán màn hình cường lực iPhone 16 Pro Max', N'Cái', 150000, 500, N'Bảo vệ màn hình điện thoại khỏi trầy xước, va đập.', N'https://yourwebsite.com/images/miengdan_iphone_16_pro_max.jpg', N'Còn hàng'),
(85, 5, N'Chuột không dây Logitech MX Master 4', N'Chiếc', 2000000, 100, N'Chuột cao cấp cho công việc, thoải mái sử dụng.', N'https://yourwebsite.com/images/chuot_mx_master_4.jpg', N'Còn hàng'),
(86, 5, N'Bàn phím cơ DareU EK87', N'Cái', 1500000, 120, N'Bàn phím cơ giá phải chăng, cảm giác gõ tốt.', N'https://yourwebsite.com/images/banphim_dareu_ek87.jpg', N'Còn hàng'),
(87, 5, N'USB Flash Drive 128GB USB 3.2', N'Cái', 300000, 300, N'USB dung lượng cao, tốc độ truyền tải nhanh.', N'https://yourwebsite.com/images/usb_128gb_3_2.jpg', N'Còn hàng'),
(88, 5, N'Thẻ nhớ MicroSDXC SanDisk Extreme 256GB', N'Cái', 700000, 200, N'Thẻ nhớ tốc độ cao cho điện thoại, camera.', N'https://yourwebsite.com/images/the_microsd_sandisk_256gb.jpg', N'Còn hàng'),
(89, 5, N'Hub USB-C 7 trong 1', N'Cái', 600000, 150, N'Bộ chuyển đổi đa năng cho laptop, tablet.', N'https://yourwebsite.com/images/hub_usb_c_7in1.jpg', N'Còn hàng'),
(90, 5, N'Đế tản nhiệt laptop Cooler Master', N'Cái', 450000, 90, N'Đế tản nhiệt giúp laptop mát hơn khi sử dụng.', N'https://yourwebsite.com/images/de_tannhiet_coolermaster.jpg', N'Còn hàng'),
(91, 5, N'Túi chống sốc laptop 15.6 inch', N'Cái', 200000, 250, N'Túi bảo vệ laptop khỏi va đập.', N'https://yourwebsite.com/images/tui_chong_soc_15_6.jpg', N'Còn hàng'),
(92, 5, N'Cáp sạc Type-C to Type-C 100W 2m', N'Sợi', 180000, 400, N'Cáp sạc nhanh bền bỉ, độ dài tiện lợi.', N'https://yourwebsite.com/images/cap_type_c_100w_2m.jpg', N'Còn hàng'),
(93, 5, N'Bộ vệ sinh màn hình điện tử', N'Bộ', 90000, 350, N'Dụng cụ làm sạch màn hình, lens.', N'https://yourwebsite.com/images/bo_vesinh_manhinh.jpg', N'Còn hàng'),
(94, 5, N'Giá đỡ điện thoại/máy tính bảng để bàn', N'Cái', 120000, 300, N'Giá đỡ tiện lợi khi xem phim, làm việc.', N'https://yourwebsite.com/images/giado_dienthoai_maytinhbang.jpg', N'Còn hàng'),
(95, 5, N'Bộ chuyển đổi Type-C sang 3.5mm', N'Cái', 80000, 450, N'Chuyển đổi cổng sạc sang cổng tai nghe.', N'https://yourwebsite.com/images/chuyendoi_type_c_3_5mm.jpg', N'Còn hàng'),
(96, 5, N'Túi đựng phụ kiện du lịch', N'Cái', 250000, 150, N'Túi nhỏ gọn đựng sạc, cáp, tai nghe.', N'https://yourwebsite.com/images/tui_dung_phukien.jpg', N'Còn hàng'),
(97, 5, N'Đầu đọc thẻ nhớ đa năng', N'Cái', 100000, 200, N'Đọc được nhiều loại thẻ nhớ khác nhau.', N'https://yourwebsite.com/images/daudoc_thenho.jpg', N'Còn hàng'),
(98, 5, N'Ổ cắm điện đa năng có USB', N'Cái', 300000, 100, N'Ổ cắm tích hợp cổng sạc USB tiện lợi.', N'https://yourwebsite.com/images/ocam_danang_usb.jpg', N'Còn hàng'),
(99, 5, N'Kính cường lực cho Laptop 14 inch', N'Cái', 400000, 80, N'Bảo vệ màn hình laptop.', N'https://yourwebsite.com/images/kinh_cuongluc_laptop_14.jpg', N'Còn hàng'),
(100, 5, N'Bao da AirTag', N'Cái', 50000, 600, N'Bảo vệ và trang trí AirTag.', N'https://yourwebsite.com/images/baoda_airtag.jpg', N'Còn hàng');