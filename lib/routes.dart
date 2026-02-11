import 'package:ecommerce_app/controller/item_details_controller.dart';
import 'package:ecommerce_app/core/middleware/mymiddleware.dart';
import 'package:ecommerce_app/data/dataSource/static/app_routes.dart';
import 'package:ecommerce_app/view/address/add.dart';
import 'package:ecommerce_app/view/address/adddetails.dart';
import 'package:ecommerce_app/view/address/edit.dart';
import 'package:ecommerce_app/view/address/view.dart';
import 'package:ecommerce_app/view/screen/about_us.dart';
import 'package:ecommerce_app/view/screen/cart.dart';
import 'package:ecommerce_app/view/screen/checkout.dart';
import 'package:ecommerce_app/view/screen/contact_us.dart';
import 'package:ecommerce_app/view/screen/favorites_screen.dart';
import 'package:ecommerce_app/view/screen/home_screen.dart';
import 'package:ecommerce_app/view/screen/home.dart';
import 'package:ecommerce_app/view/screen/auth/forgetpassword/forgetpassword.dart';
import 'package:ecommerce_app/view/screen/auth/forgetpassword/success_resetpassword.dart';
import 'package:ecommerce_app/view/screen/auth/login.dart';
import 'package:ecommerce_app/view/screen/auth/forgetpassword/resetpassword.dart';
import 'package:ecommerce_app/view/screen/auth/signup.dart';
import 'package:ecommerce_app/view/screen/auth/forgetpassword/verifyemail.dart';
import 'package:ecommerce_app/view/screen/auth/signup_success.dart';
import 'package:ecommerce_app/view/screen/auth/signupverifyemail.dart';
import 'package:ecommerce_app/view/screen/items_screen.dart';
import 'package:ecommerce_app/view/screen/language_screen.dart';
import 'package:ecommerce_app/view/screen/offers_screen.dart';
import 'package:ecommerce_app/view/screen/onboarding_screen.dart';
import 'package:ecommerce_app/view/screen/orders/archive.dart';
import 'package:ecommerce_app/view/screen/orders/details.dart';
import 'package:ecommerce_app/view/screen/orders/pending.dart';
import 'package:ecommerce_app/view/screen/itemdetails_screen.dart';
import 'package:ecommerce_app/view/screen/user_profile.dart';
import 'package:get/get_instance/get_instance.dart';
import 'package:get/get_navigation/src/routes/get_route.dart';
import 'package:get/utils.dart';

List<GetPage<dynamic>> routes = [
 
  GetPage(
    name: "/", 
    page: () => const Language(),
    middlewares: [Mymiddleware()],
  ),
  GetPage(name: appRoute.homeScreen, page: () => const HomeScreen()),
  GetPage(name: appRoute.login, page: () => const Login()),
  GetPage(name: appRoute.onboarding, page: () => const OnBoarding()),
  GetPage(name: appRoute.signup, page: () => const Signup()),
  GetPage(name: appRoute.forgetpassword, page: () => const ForgetPassword()),
  GetPage(name: appRoute.verifyemail, page: () => const VerifyEmail()),
  GetPage(name: appRoute.resetpassword, page: () => const ResetPassword()),
  GetPage(
    name: appRoute.successresetpassword,
    page: () => const SuccessResetPassword(),
  ),
  GetPage(name: appRoute.successsignup, page: () => const SignupSuccess()),
  GetPage(
    name: appRoute.signupverifyemail,
    page: () => const SignupVerifyEmail(),
  ),

  GetPage(name: appRoute.home, page: () => const Home()),
  GetPage(name: appRoute.homeScreen, page: () => const HomeScreen()),

  GetPage(name: appRoute.items, page: () => const ItemsScreen()),
  GetPage(name: appRoute.favItems, page: () => const FavoritesScreen()),
  GetPage(
    name: appRoute.prodcutdetails,
    page: () => const ProductDetails(),
    binding: BindingsBuilder(() {
      Get.put(ProductDetailsControllerImp());
    }),
  ),

  GetPage(name: appRoute.cart, page: () => const Cart()),

  GetPage(name: appRoute.addressView, page: () => const AddressView()),
  GetPage(name: appRoute.addressAdd, page: () => const AddressAdd()),
  GetPage(
    name: appRoute.addressDetailsAdd,
    page: () => const AddressDetailsAdd(),
  ),
  GetPage(name: appRoute.addressEdit, page: () => const AddressEdit()),
  GetPage(name: appRoute.checkout, page: () => const Checkout()),

  GetPage(name: appRoute.pendingOrders, page: () => const PendingOrders()),
  GetPage(name: appRoute.archivedOrders, page: () => const ArchivedOrders()),
  GetPage(name: appRoute.orderDetails, page: () => const OrderDetailsScreen()),
  GetPage(name: appRoute.offers, page: () => const OffersScreen()),

  
  GetPage(name: appRoute.userProfile, page: () => const UserProfile()),
  GetPage(
  name: appRoute.contact,
  page: () => const ContactUs(),
),
  GetPage(
  name: appRoute.aboutus,
  page: () => const AboutUs(),
),
];


