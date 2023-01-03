import 'dart:math';

class Images {
  /// Product Image Builder
  static String productDummy() {
    List<String> images = [
      'http://image.auction.co.kr/itemimage/1b/1e/5a/1b1e5a8fa6.jpg',
      'https://i.pinimg.com/originals/a5/29/f3/a529f3031ebdcba1e145fc5a44596bf6.jpg',
      'https://www.noblesse.com/shop/data/m/editor_new/2021/03/08/5196e8a9124e6bb61.jpg',
      'https://static.coupangcdn.com/image/vendor_inventory/9a82/75f0b8b4f21f0b66cf6f47e8ceaf183eeee2007b5a7e10ed3c9add248445.jpg',
      'https://contents.lotteon.com/itemimage/LO/15/88/30/49/33/_1/58/83/04/93/4/LO1588304933_1588304934_1.jpg',
      'https://img.freepik.com/free-photo/trendy-womens-shoes-fashion-style-concept_113876-2256.jpg',
      'https://t1.daumcdn.net/thumb/R720x0/?fname=http://t1.daumcdn.net/brunch/service/user/vkP/image/1S7sAkIdHhMvFAPqyBEARyOAPiQ.jpg',
      'https://i.pinimg.com/originals/43/75/09/4375096b0f55a20fcfc4d3be650f75ca.jpg',
      'https://static.coupangcdn.com/image/vendor_inventory/8cf1/5c406d232f0094f2358a9b5e9ea67e0d62bbf16369b908dd835fd03fa833.jpg',
    ];
    return images[Random().nextInt(images.length)];
  }

  /// Store Image Builder
  static String storeDummy() {
    List<String> images = [
      'https://c.static-nike.com/a/images/w_1920,c_limit/bzl2wmsfh7kgdkufrrjq/image.jpg',
      'https://upload.wikimedia.org/wikipedia/commons/thumb/2/20/Adidas_Logo.svg/1024px-Adidas_Logo.svg.png',
      'https://www.daangn.com/logo.png',
      'https://s3.amazonaws.com/thumbnails.venngage.com/template/fc8535df-be09-4c80-8ea5-a69a34b2318e.png',
      'https://i.fbcd.co/products/resized/resized-750-500/0f2f8ad0d905332243064cf29744861e6403452b8044b71488ef6cb79ab269b1.jpg',
      'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTGZvbSzJpL1DAcs1qQMEa-GXnNa6g1EX02RA&usqp=CAU',
      'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcROUg4AAGuBE1jC99w4lmL9kz6qsr_5RO_NxQ&usqp=CAU',
      'https://lp2.hm.com/hmgoepprod?set=quality%5B79%5D%2Csource%5B%2Fa4%2F78%2Fa478e80fad7029a0ccadcbf1e732bd2b4d4c2834.jpg%5D%2Corigin%5Bdam%5D%2Ccategory%5B%5D%2Ctype%5BLOOKBOOK%5D%2Cres%5Bm%5D%2Chmver%5B1%5D&call=url[file:/product/main]',
    ];
    return images[Random().nextInt(images.length)];
  }
}
