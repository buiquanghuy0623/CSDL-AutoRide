# Nhật ký Tương tác AI (AI Prompt Log)

## Prompt 1: Tìm hiểu kiểu dữ liệu tài chính
- **Câu hỏi**: "Khi thiết kế các cột lưu trữ tiền cọc, phí phạt trễ, phí đền bù hư hỏng trong MySQL, nên chọn kiểu float, double hay decimal? Tại sao?"
- **Mục đích**: Hiểu rõ lý do chọn `DECIMAL(10,2)` để tránh lỗi làm tròn số thực.

## Prompt 2: Phân tích mối quan hệ bảng Kiểm tra xe
- **Câu hỏi**: "Phân tích ưu/nhược điểm giữa việc nhồi cột `damage_description` vào bảng `Rentals` và việc tách riêng bảng `Inspections` theo quan hệ 1-N hoặc 1-1."
- **Mục đích**: Đánh giá chuẩn hóa CSDL (Normalization) và tính mở rộng khi một chuyến thuê xe có thể kiểm tra nhiều lần (lúc nhận và lúc trả).

## Prompt 3: Kiểm tra xử lý giá trị NULL khi tính toán
- **Câu hỏi**: "Nếu các cột `late_fee` hoặc `damage_fee` nhận giá trị NULL thì câu lệnh `security_deposit - late_fee - damage_fee` trong MySQL sẽ cho ra kết quả gì? Cách khắc phục?"
- **Mục đích**: Áp dụng `DEFAULT 0.00` hoặc hàm `COALESCE` để tránh kết quả truy vấn bị gán thành NULL.
