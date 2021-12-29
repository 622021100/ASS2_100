class Food {
  String? thName;
  String? enName;
  String? foodValue;
  int? price;

  //constructor
  Food(this.enName, this.thName, this.foodValue, this.price);

  static List<Food> getFood() {
    return [
      Food('Pizza', 'พิซซ่า', 'pizza', 59),
      Food('Steak', 'สเต็ก', 'steak', 239),
      Food('Salad', 'สลัด', 'salad', 79),
      Food('Shabu', 'ชาบู', 'shabu', 399),
    ];
  }
}
