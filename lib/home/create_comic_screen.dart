import 'dart:io'; // Dùng để làm việc với File ảnh
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart'; // Thư viện chọn ảnh
import '../models/comic_model.dart';
import '../data/mock_data.dart';

class CreateComicScreen extends StatefulWidget {
  const CreateComicScreen({super.key});

  @override
  State<CreateComicScreen> createState() => _CreateComicScreenState();
}

class _CreateComicScreenState extends State<CreateComicScreen> {
  final _formKey = GlobalKey<FormState>();

  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _authorController = TextEditingController(text: "Bui Van Nguyen K17 HL");
  final TextEditingController _tagsController = TextEditingController();
  final TextEditingController _descController = TextEditingController();

  String _selectedStatus = 'Tiếp tục cập nhật';
  final List<String> _statusOptions = ['Tiếp tục cập nhật', 'Đã hoàn thành', 'Tạm ngưng'];

  final List<String> _availableGenres = ['Hành động', 'Truyện hài', 'Kinh dị', 'Huyền huyễn', 'Người đóng góp', 'Bí ẩn', 'Mạo hiểm', 'Xuyên không', 'Lãng mạn', 'Học đường'];
  final List<String> _selectedGenres = [];

  bool _confirmOwnership = false;
  bool _agreeTerms = false;

  // --- THÊM PHẦN XỬ LÝ ẢNH TẠI ĐÂY ---
  File? _thumbnailImage;
  File? _posterImage;
  final ImagePicker _picker = ImagePicker();

  Future<void> _pickImage(bool isThumbnail) async {
    // Mở thư viện ảnh
    final XFile? pickedFile = await _picker.pickImage(source: ImageSource.gallery);
    
    if (pickedFile != null) {
      setState(() {
        if (isThumbnail) {
          _thumbnailImage = File(pickedFile.path);
        } else {
          _posterImage = File(pickedFile.path);
        }
      });
    }
  }
  // -----------------------------------

  @override
  void dispose() {
    _titleController.dispose();
    _authorController.dispose();
    _tagsController.dispose();
    _descController.dispose();
    super.dispose();
  }

  void _submitComic() {
    if (_formKey.currentState!.validate()) {
      if (_selectedGenres.isEmpty) {
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Vui lòng chọn ít nhất 1 thể loại!')));
        return;
      }
      if (_thumbnailImage == null) {
         ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Vui lòng chọn ảnh Thumbnail!')));
        return;
      }
      if (!_confirmOwnership || !_agreeTerms) {
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Vui lòng đồng ý với các điều khoản!')));
        return;
      }

      // Lưu ý: Trong thực tế, bạn sẽ phải upload File ảnh (_thumbnailImage) lên Firebase Storage hoặc server 
      // để lấy về cái Link (URL) rồi mới lưu vào Database.
      // Ở đây dùng Mock Data nên ta tạm dùng một Link ảnh ngẫu nhiên để không bị lỗi màn Chi tiết.
      final newComic = Comic(
        id: 'comic_${DateTime.now().millisecondsSinceEpoch}',
        title: _titleController.text,
        description: _descController.text,
        coverImage: 'https://images.unsplash.com/photo-1544716278-ca5e3f4abd8c?auto=format&fit=crop&w=800&q=80', // Ảnh mock
        author: _authorController.text,
        status: _selectedStatus == 'Tiếp tục cập nhật' ? 'Đang ra' : 'Đã Full',
        genres: _selectedGenres,
        viewCount: 0,
        rating: 0.0,
        chapters: [],
      );

      setState(() {
        mockComics.insert(0, newComic);
      });

      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Tạo truyện thành công!')));
      Navigator.pop(context);
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
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  _buildStepIndicator("1", "Tạo tác phẩm", isActive: true),
                  _buildStepIndicator("2", "Thêm chapter", isActive: false),
                  _buildStepIndicator("3", "Nộp chờ", isActive: false),
                ],
              ),
              const SizedBox(height: 32),

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

              // BƯỚC 5: KHU VỰC CHỌN ẢNH ĐÃ ĐƯỢC CẬP NHẬT
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(child: _buildImageUploadArea('* Ảnh thumbnail:', true, _thumbnailImage)),
                  const SizedBox(width: 16),
                  Expanded(child: _buildImageUploadArea('* Ảnh poster:', false, _posterImage)),
                ],
              ),
              const SizedBox(height: 24),

              _buildLabel('* Mô tả truyện:'),
              TextFormField(
                controller: _descController,
                maxLines: 5,
                decoration: _inputDecoration('Nhập mô tả truyện của bạn...'),
                validator: (val) => val == null || val.isEmpty ? 'Không được để trống' : null,
              ),
              const SizedBox(height: 24),

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

              SizedBox(
                width: double.infinity,
                height: 50,
                child: ElevatedButton(
                  onPressed: _submitComic,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFFE94057),
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

  Widget _buildLabel(String text) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0),
      child: Text(text, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500, color: Colors.black87)),
    );
  }

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

  // --- HÀM VẼ KHU VỰC ẢNH MỚI CÓ THỂ BẤM VÀO ĐƯỢC ---
  Widget _buildImageUploadArea(String label, bool isThumbnail, File? imageFile) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildLabel(label),
        GestureDetector(
          onTap: () => _pickImage(isThumbnail), // Bấm vào sẽ mở thư viện
          child: Container(
            height: 160,
            width: double.infinity,
            decoration: BoxDecoration(
              border: Border.all(color: Colors.grey.shade300, style: BorderStyle.solid),
              borderRadius: BorderRadius.circular(8),
              color: Colors.grey.shade50,
            ),
            // Nếu có ảnh thì hiển thị ảnh, nếu null thì hiển thị khung Icon
            child: imageFile != null
                ? ClipRRect(
                    borderRadius: BorderRadius.circular(8),
                    child: Image.file(
                      imageFile,
                      fit: BoxFit.cover,
                    ),
                  )
                : const Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.add_photo_alternate_outlined, size: 40, color: Colors.grey),
                      SizedBox(height: 8),
                      Text('Chọn file', style: TextStyle(color: Colors.redAccent, fontWeight: FontWeight.w500)),
                    ],
                  ),
          ),
        )
      ],
    );
  }

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