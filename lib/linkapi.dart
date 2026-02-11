class AppLink {
  // Base Url
  static const baseURL = 'http://10.0.2.2:8000/api';
  // Images
  static const baseImagesURL = 'http://10.0.2.2:8000/images';
  static const categoriesImages = baseImagesURL + '/categories';
  static const itemsImages = baseImagesURL + '/items';
  static const usersImages = baseImagesURL + '/users';
  
  // Auth
  static const loginURL = baseURL + '/customer/login';
  static const getUser = baseURL + '/user';
  static const updateUserImage = baseURL + '/image/update';
  static const registerURL = baseURL + '/register';
  static const verifyEmail = baseURL + '/verifyEmail';
  static const sendCode = baseURL + '/sendCode';
  static const resetPassword = baseURL + '/resetPassword';

  static const logoutURL = baseURL + '/logout';

  // Home Page
  static const categories = baseURL + '/categories';
  static const items = baseURL + '/items';
  static const favItems = baseURL + '/items/favorites';
  static const discountItems = baseURL + '/items/discount';
  static const toggleItem = baseURL + '/items/toggle';
  static const itemsSearch = baseURL + '/items/search';
  static const itemsOffersSearch = baseURL + '/items/offers/search';
  static const itemsTopSelling = baseURL + '/items/topSelling';


  //settings
  static const settings = baseURL + "/settings";


  // cart Page
  static const cart = baseURL + '/cart';
  static const cartDelete = baseURL + '/cart/remove';
  static const cartDecrease = baseURL + '/cart/decrease';
  static const cartClear = baseURL + '/cart/clear';
  static const cartItemCount = baseURL + "/cart/count";

  static const coupon = baseURL + "/coupon";




  //addresses

  static const address = baseURL + "/address";
  static const addressView = baseURL + "/addresses";


  // orders
  static const orders = baseURL + "/orders";
  static const pendingOrders = baseURL + "/orders/pending";
  static const archivedOrders = baseURL + "/orders/archive";
  static const orderData = baseURL + "/orders";
  static const rateOrder = baseURL + "/orders/rate";

  //notifications
  static const notifications = baseURL + "/notifications";

  static const serverError = 'error';

  static const unauthorized = 'Unauthorized';
  static const somethingWentwrong = 'something went wrong';
}
