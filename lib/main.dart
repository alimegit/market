import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:market/screens/auth/login_screen.dart';
import 'package:market/screens/permissions/permission_screen.dart';
import 'package:market/screens/splash/splash_screen.dart';
import 'package:market/services/local_notification_services.dart';
import 'package:market/view_models/image_view_model.dart';
import 'package:market/view_models/notification_view_model.dart';
import 'package:market/view_models/product_viewmodel.dart';
import 'package:provider/provider.dart';
import 'bloc/auth_bloc.dart';
import 'services/firebase_options.dart';
import 'screens/routes.dart';
import 'view_models/auth_view_model.dart';
import 'view_models/tab_view_model.dart';

Future<void> onBackgroundMessageHandler(RemoteMessage message) async {
  debugPrint("BACKGROUND MODEDA PUSH NOTIFICATION KELDI:${message.notification!.title}");
}

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // await configureLocalTimeZone();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  FirebaseMessaging.onBackgroundMessage((onBackgroundMessageHandler));

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(
    MultiBlocProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => TabViewModel()),
        ChangeNotifierProvider(create: (_) => AuthViewModel()),
        ChangeNotifierProvider(create: (_) => ProductsViewModel()),
        ChangeNotifierProvider(create: (_) => NotificationViewModel()),
        ChangeNotifierProvider(create: (_) => ImageViewModel()),
        BlocProvider(create: (_) => AuthBloc()),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();
    LocalNotificationService.localNotificationService.init(navigatorKey);
    return ScreenUtilInit(
      designSize: const Size(375, 812),
      builder: (context, child) {
        ScreenUtil.init(context);
        return MaterialApp(
          initialRoute: RouteNames.loginRoute,
          onGenerateRoute: AppRoutes.generateRoute,
          debugShowCheckedModeBanner: false,
          theme: ThemeData(useMaterial3: false),
          home: child,
        );
      },

      child: const LoginScreen(),
    );
  }
}
