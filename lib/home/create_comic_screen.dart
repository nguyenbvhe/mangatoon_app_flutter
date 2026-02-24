import 'package:flutter/material.dart';
import '../models/comic_model.dart';
import '../data/mock_data.dart'; // Để add truyện mới vào danh sách giả

class CreateComicScreen extends StatefulWidget {
  const CreateComicScreen({super.key});

  @override
  State<CreateComicScreen> createState() => _CreateComicScreenState();
}

class _CreateComicScreenState extends State<CreateComicScreen> {
  final _formKey = GlobalKey<FormState>();

  // Controllers cho các trường nhập liệu
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _authorController = TextEditingController(text: "Bui Van Nguyen K17 HL"); // Mặc định theo ảnh
  final TextEditingController _tagsController = TextEditingController();
  final TextEditingController _descController = TextEditingController();

  // Biến lưu trạng thái
  String _selectedStatus = 'Tiếp tục cập nhật'; // Tình trạng
  final List<String> _statusOptions = ['Tiếp tục cập nhật', 'Đã hoàn thành', 'Tạm ngưng'];

  // Danh sách Thể loại (Genres) để chọn
  final List<String> _availableGenres = ['Hành động', 'Truyện hài', 'Kinh dị', 'Huyền huyễn', 'Người đóng góp', 'Bí ẩn', 'Mạo hiểm', 'Xuyên không', 'Lãng mạn', 'Học đường'];
  final List<String> _selectedGenres = [];

  // Checkbox Xác nhận
  bool _confirmOwnership = false;
  bool _agreeTerms = false;

  @override
  void dispose() {
    _titleController.dispose();
    _authorController.dispose();
    _tagsController.dispose();
    _descController.dispose();
    super.dispose();
  }

  // Hàm xử lý khi bấm nút TẠO
  void _submitComic() {
    if (_formKey.currentState!.validate()) {
      if (_selectedGenres.isEmpty) {
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Vui lòng chọn ít nhất 1 thể loại!')));
        return;
      }
      if (!_confirmOwnership || !_agreeTerms) {
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Vui lòng đồng ý với các điều khoản!')));
        return;
      }

      // Tạo đối tượng Comic mới
      final newComic = Comic(
        id: 'comic_${DateTime.now().millisecondsSinceEpoch}', // ID ngẫu nhiên
        title: _titleController.text,
        description: _descController.text,
        // Dùng ảnh tạm vì chưa tích hợp thư viện chọn ảnh thật
        coverImage: 'https://images.unsplash.com/photo-1544716278-ca5e3f4abd8c?auto=format&fit=crop&w=800&q=80', 
        author: _authorController.text,
        status: _selectedStatus == 'Tiếp tục cập nhật' ? 'Đang ra' : 'Đã Full',
        genres: _selectedGenres,
        viewCount: 0,
        rating: 0.0,
        chapters: [],
      );

      // Thêm vào mock data (Sau này sẽ gọi API để lưu vào Database ở đây)
      setState(() {
        mockComics.insert(0, newComic); // Cho lên đầu danh sách
      });

      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Tạo truyện thành công!')));
      Navigator.pop(context); // Quay lại màn hình trước đó
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text('Tạo tác phẩm', style: TextStyle(color: Colors.black87, fontWeight: FontWeight.bold)),
        backgroundColor: Colors.white,
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.black87),
      ),
      body: Form(
        key: _formKey,
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // BƯỚC 1: HEADER TIẾN TRÌNH (Tạo tác phẩm -> Thêm chapter -> Nộp chờ)
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  _buildStepIndicator("1", "Tạo tác phẩm", isActive: true),
                  _buildStepIndicator("2", "Thêm chapter", isActive: false),
                  _buildStepIndicator("3", "Nộp chờ", isActive: false),
                ],
              ),
              const SizedBox(height: 32),

              // BƯỚC 2: FORM NHẬP LIỆU
              _buildLabel('* Tên truyện:'),
              TextFormField(
                controller: _titleController,
                decoration: _inputDecoration('Nhập tên truyện'),
                validator: (val) => val == null || val.isEmpty ? 'Không được để trống' : null,
              ),
              const SizedBox(height: 16),

              _buildLabel('* Tên tác giả:'),
              TextFormField(
                controller: _authorController,
                decoration: _inputDecoration('Tên tác giả'),
                validator: (val) => val == null || val.isEmpty ? 'Không được để trống' : null,
              ),
              const SizedBox(height: 16),

              _buildLabel('* Tags:'),
              TextFormField(
                controller: _tagsController,
                decoration: _inputDecoration('Nhập tags, ví dụ: hành động, tình cảm...'),
              ),
              const SizedBox(height: 24),

              // BƯỚC 3: CHECKBOX THỂ LOẠI
              _buildLabel('* Thể loại:'),
              Wrap(
                spacing: 10,
                runSpacing: 0,
                children: _availableGenres.map((genre) {
                  final isSelected = _selectedGenres.contains(genre);
                  return FilterChip(
                    label: Text(genre),
                    selected: isSelected,
                    selectedColor: Colors.redAccent.withOpacity(0.2),
                    checkmarkColor: Colors.redAccent,
                    onSelected: (bool selected) {
                      setState(() {
                        if (selected) {
                          _selectedGenres.add(genre);
                        } else {
                          _selectedGenres.remove(genre);
                        }
                      });
                    },
                  );
                }).toList(),
              ),
              const SizedBox(height: 24),

              // BƯỚC 4: DROPDOWN TÌNH TRẠNG CẬP NHẬT
              _buildLabel('* Tình trạng cập nhật:'),
              DropdownButtonFormField<String>(
                value: _selectedStatus,
                decoration: _inputDecoration(''),
                items: _statusOptions.map((status) => DropdownMenuItem(value: status, child: Text(status))).toList(),
                onChanged: (val) {
                  setState(() => _selectedStatus = val!);
                },
              ),
              const SizedBox(height: 24),

              // BƯỚC 5: KHU VỰC CHỌN ẢNH (Mock UI)
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(child: _buildImageUploadArea('* Ảnh thumbnail:')),
                  const SizedBox(width: 16),
                  Expanded(child: _buildImageUploadArea('* Ảnh poster:')),
                ],
              ),
              const SizedBox(height: 24),

              // BƯỚC 6: MÔ TẢ TRUYỆN
              _buildLabel('* Mô tả truyện:'),
              TextFormField(
                controller: _descController,
                maxLines: 5,
                decoration: _inputDecoration('Nhập mô tả truyện của bạn...'),
                validator: (val) => val == null || val.isEmpty ? 'Không được để trống' : null,
              ),
              const SizedBox(height: 24),

              // BƯỚC 7: XÁC NHẬN ĐIỀU KHOẢN
              CheckboxListTile(
                value: _confirmOwnership,
                title: const Text('Tôi xác nhận truyện tiểu thuyết là do tôi sáng tác và thuộc sở hữu của tôi', style: TextStyle(fontSize: 13)),
                onChanged: (val) => setState(() => _confirmOwnership = val!),
                controlAffinity: ListTileControlAffinity.leading,
                contentPadding: EdgeInsets.zero,
                activeColor: Colors.redAccent,
              ),
              CheckboxListTile(
                value: _agreeTerms,
                title: const Text('Tôi đồng ý với "Đăng ký tác giả và thỏa thuận đăng tải truyện" của MangaToon', style: TextStyle(fontSize: 13)),
                onChanged: (val) => setState(() => _agreeTerms = val!),
                controlAffinity: ListTileControlAffinity.leading,
                contentPadding: EdgeInsets.zero,
                activeColor: Colors.redAccent,
              ),
              const SizedBox(height: 32),

              // NÚT SUBMIT
              SizedBox(
                width: double.infinity,
                height: 50,
                child: ElevatedButton(
                  onPressed: _submitComic,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFFE94057), // Màu đỏ hồng giống ảnh
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                  ),
                  child: const Text('Tạo', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.white)),
                ),
              ),
              const SizedBox(height: 40),
            ],
          ),
        ),
      ),
    );
  }

  // Tiện ích vẽ chữ Nhãn (Label)
  Widget _buildLabel(String text) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0),
      child: Text(text, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500, color: Colors.black87)),
    );
  }

  // Tiện ích viền TextField
  InputDecoration _inputDecoration(String hint) {
    return InputDecoration(
      hintText: hint,
      hintStyle: const TextStyle(color: Colors.grey),
      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      border: OutlineInputBorder(borderRadius: BorderRadius.circular(8), borderSide: BorderSide(color: Colors.grey.shade300)),
      enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(8), borderSide: BorderSide(color: Colors.grey.shade300)),
      focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(8), borderSide: const BorderSide(color: Colors.redAccent)),
    );
  }

  // Tiện ích vẽ cục upload ảnh giả
  Widget _buildImageUploadArea(String label) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildLabel(label),
        Container(
          height: 160,
          width: double.infinity,
          decoration: BoxDecoration(
            border: Border.all(color: Colors.grey.shade300, style: BorderStyle.solid),
            borderRadius: BorderRadius.circular(8),
            color: Colors.grey.shade50,
          ),
          child: const Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.add_photo_alternate_outlined, size: 40, color: Colors.grey),
              SizedBox(height: 8),
              Text('Chọn file', style: TextStyle(color: Colors.redAccent, fontWeight: FontWeight.w500)),
            ],
          ),
        )
      ],
    );
  }

  // Tiện ích vẽ Progress Step (1 - 2 - 3)
  Widget _buildStepIndicator(String number, String title, {required bool isActive}) {
    return Column(
      children: [
        CircleAvatar(
          radius: 14,
          backgroundColor: isActive ? Colors.redAccent : Colors.grey.shade400,
          child: Text(number, style: const TextStyle(color: Colors.white, fontSize: 12)),
        ),
        const SizedBox(height: 4),
        Text(title, style: TextStyle(fontSize: 12, color: isActive ? Colors.black87 : Colors.grey)),
      ],
    );
  }
}