class ImageTools {

  static String getCategoryImage(String category) {
    switch(category) {
      case "burger": return "assets/images/icons/burger_category_icon.png";
      case "pizza": return "assets/images/icons/pizza_category_icon.png";
      case "sushi": return "assets/images/icons/sushi_category_icon.png";
      case "drinks": return "assets/images/icons/water_category_icon.png";
    }

    return "assets/images/icons/burger_category_icon.jpg";
  }
}