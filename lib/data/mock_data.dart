import '../models/comic_model.dart';

final List<Comic> mockComics = [
  Comic(
    id: 'comic_1',
    title: 'Hầm Ngục Tối (Solo Leveling)',
    description: 'Mười năm trước, sau khi "Cổng" kết nối thế giới thực với thế giới quái vật mở ra, một số người bình thường nhận được sức mạnh thức tỉnh để săn lùng quái vật. Họ được gọi là các Thợ săn. Sung Jin-Woo, một thợ săn hạng E yếu kém, đã tìm thấy một hầm ngục kép bí mật và nhận được sức mạnh "Hệ thống" độc nhất vô nhị...',
    coverImage: 'https://images.unsplash.com/photo-1612487528505-d2338264c821?ixlib=rb-4.0.3&auto=format&fit=crop&w=800&q=80', // Ảnh bìa minh họa
    author: 'Chu-Gong',
    status: 'Đang ra',
    genres: ['Hành động', 'Huyền huyễn', 'Mạo hiểm'],
    viewCount: 1540000,
    rating: 4.9,
    chapters: [
      Chapter(
        id: 'chap_1',
        comicId: 'comic_1',
        chapterNumber: 1,
        title: 'Thợ săn yếu nhất',
        isPremium: false,
        unlockPrice: 0,
        pages: [
          ChapterPage(id: 'p1', chapterId: 'chap_1', pageNumber: 1, imageUrl: 'https://picsum.photos/seed/page1/800/1200'),
          ChapterPage(id: 'p2', chapterId: 'chap_1', pageNumber: 2, imageUrl: 'https://picsum.photos/seed/page2/800/1600'),
          ChapterPage(id: 'p3', chapterId: 'chap_1', pageNumber: 3, imageUrl: 'https://picsum.photos/seed/page3/800/1400'),
        ],
      ),
      Chapter(
        id: 'chap_2',
        comicId: 'comic_1',
        chapterNumber: 2,
        title: 'Hầm ngục kép',
        isPremium: false,
        unlockPrice: 0,
        pages: [
          ChapterPage(id: 'p4', chapterId: 'chap_2', pageNumber: 1, imageUrl: 'https://picsum.photos/seed/page4/800/1500'),
          ChapterPage(id: 'p5', chapterId: 'chap_2', pageNumber: 2, imageUrl: 'https://picsum.photos/seed/page5/800/1200'),
        ],
      ),
      Chapter(
        id: 'chap_3',
        comicId: 'comic_1',
        chapterNumber: 3,
        title: 'Bàn thờ hiến tế',
        isPremium: true, // Chương này cần trả phí
        unlockPrice: 200,
        pages: [], // Giấu trang vì chưa mua
      ),
    ],
  ),
  Comic(
    id: 'comic_2',
    title: 'Kẻ Cắp Tình Yêu',
    description: 'Một câu chuyện tình cảm lãng mạn chốn học đường giữa cô nàng lớp trưởng nghiêm túc và cậu nam sinh cá biệt. Liệu sự trái ngược này có tạo nên một tình yêu đẹp?',
    coverImage: 'https://images.unsplash.com/photo-1580477667995-2b94f01c9516?ixlib=rb-4.0.3&auto=format&fit=crop&w=800&q=80',
    author: 'MangaToon',
    status: 'Đã Full',
    genres: ['Ngôn tình', 'Romance', 'School'],
    viewCount: 850000,
    rating: 4.5,
    chapters: [
      Chapter(
        id: 'chap_2_1',
        comicId: 'comic_2',
        chapterNumber: 1,
        title: 'Oan gia ngõ hẹp',
        isPremium: false,
        unlockPrice: 0,
        pages: [
          ChapterPage(id: 'c2_p1', chapterId: 'chap_2_1', pageNumber: 1, imageUrl: 'https://picsum.photos/seed/love1/800/1200'),
          ChapterPage(id: 'c2_p2', chapterId: 'chap_2_1', pageNumber: 2, imageUrl: 'https://picsum.photos/seed/love2/800/1400'),
        ],
      ),
    ],
  ),
  Comic(
    id: 'comic_3',
    title: 'Thám Tử Lừng Danh',
    description: 'Những vụ án hóc búa nhất đang chờ đợi được giải đáp...',
    coverImage: 'https://images.unsplash.com/photo-1585366119957-e9730b6d0f60?ixlib=rb-4.0.3&auto=format&fit=crop&w=800&q=80',
    author: 'Gosho Aoyama',
    status: 'Đang ra',
    genres: ['Bí ẩn', 'Hành động', 'Kinh dị'],
    viewCount: 3000000,
    rating: 4.8,
    chapters: [], // Truyện này cố tình để rỗng chương để test thông báo lỗi "Chưa có chương nào"
  ),
];