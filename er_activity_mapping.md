# Phân tích Tính Toàn vẹn Dữ liệu giữa Activity Diagram và ERD

Trong quy trình nghiệp vụ "Thuê và Trả xe" của AutoRide, Activity Diagram định nghĩa các nhánh rẽ quan trọng như xử lý vi phạm trễ giờ và hư hỏng xe. Trường `damage_fee` trong bảng `Rentals` là yếu tố bắt buộc để đảm bảo sự toàn vẹn hệ thống vì các lý do sau:

1. **Khớp nối nghiệp vụ & CSDL**: Thiếu `damage_fee`, cơ sở dữ liệu không thể lưu vết quyết định đền bù từ biên bản kiểm tra (`Inspections`), dẫn đến sự đứt gãy giữa quy trình thực tế và dữ liệu lưu trữ.
2. **Minh bạch tài chính**: Tiền hoàn trả được tính theo công thức `Tiền hoàn = Tiền cọc - Phí trễ - Phí hư hỏng`. Việc thiếu cột này làm bất lực công thức tính tự động, buộc kế toán xử lý thủ công gây thất thoát tài chính.
3. **Lưu vết pháp lý**: Lưu trữ trực tiếp số tiền phạt trong hợp đồng giúp đối soát hóa đơn và giải quyết tranh chấp khách hàng minh bạch.
