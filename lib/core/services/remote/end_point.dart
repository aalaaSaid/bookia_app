class AppEndPoint {
  static const String baseUrl = 'https://codingarabic.online/api';
  //auth
  static const String register = '/register';
  static const String login = '/login';
  //password
  static const String forgotPassword ='/forget-password';
  static const String checkOtp='/check-forget-password';
  static const String resetNewPassword = '/reset-password';
  //home
  static const String slider = '/sliders';
  static const String getBooks = '/products-new-arrivals';
  static const String search = '/products-search';
  //wishlist
  static const String showWishlist = '/wishlist';
  static const String addToWishlist ='/add-to-wishlist';
  static const String removeFromWishlist='/remove-from-wishlist';
//cart
static const String showCart ='/cart';
static const String addToCart='/add-to-cart';
static const String removeFromCart ='/remove-from-cart';
static const String updateCard ='/update-cart';
//profile
static const String showProfile = '/profile';
static const String updateProfile ='/update-profile';
static const String resetPassword = '/update-password';
static const String logout = '/logout';
static const String contact = '/contact-us';
//checkout
static const String getCheckout = '/checkout';
}
