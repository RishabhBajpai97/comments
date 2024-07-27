import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:comments/features/auth/data/datasource/auth_remote_datasource.dart';
import 'package:comments/features/auth/data/repository/auth_repo_impl.dart';
import 'package:comments/features/auth/domain/repository/auth_repository.dart';
import 'package:comments/features/auth/domain/usecase/get_current_user.dart';
import 'package:comments/features/auth/domain/usecase/user_login.dart';
import 'package:comments/features/auth/domain/usecase/user_logout.dart';
import 'package:comments/features/auth/domain/usecase/user_signup.dart';
import 'package:comments/features/auth/presentation/provider/auth_provider.dart';
import 'package:comments/features/comments/data/datasource/remote_comments_datasource.dart';
import 'package:comments/features/comments/data/repository/comment_repo_impl.dart';
import 'package:comments/features/comments/domain/repository/comment_repository.dart';
import 'package:comments/features/comments/domain/usecase/fetch_remote_config.dart';
import 'package:comments/features/comments/domain/usecase/get_comments.dart';
import 'package:comments/features/comments/presentation/provider/comments_provider.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get_it/get_it.dart';
import "package:http/http.dart" as http;

GetIt serviceLocator = GetIt.instance;

Future<void> initDependencies() async {
  serviceLocator.registerLazySingleton(() => FirebaseAuth.instance);
  serviceLocator.registerLazySingleton(() => FirebaseFirestore.instance);
  serviceLocator.registerFactory<AuthRemoteDatasourceImpl>(
      () => AuthRemoteDatasourceImpl(serviceLocator(), serviceLocator()));
  serviceLocator.registerFactory<RemoteCommentsDatasource>(
      () => RemoteCommentsDatasourceImpl(http.Client()));
  serviceLocator
      .registerFactory<AuthRepository>(() => AuthRepoImpl(serviceLocator()));
  serviceLocator.registerFactory<CommentRepository>(
      () => CommentRepoImpl(serviceLocator()));
  serviceLocator
      .registerFactory<UserSignup>(() => UserSignup(serviceLocator()));
  serviceLocator.registerFactory<UserLogin>(() => UserLogin(serviceLocator()));
  serviceLocator
      .registerFactory<UserLogout>(() => UserLogout(serviceLocator()));
  serviceLocator.registerFactory(() => GetCommets(serviceLocator()));
  serviceLocator.registerFactory(() => GetCurrentUser(serviceLocator()));

  serviceLocator.registerLazySingleton(
    () => AuthenticationProvider(
        userLogin: serviceLocator<UserLogin>(),
        userLogout: serviceLocator<UserLogout>(),
        userSignup: serviceLocator<UserSignup>(),
        getcurruser: serviceLocator<GetCurrentUser>()),
  );
  serviceLocator.registerFactory(() => FetchRemoteConfig(serviceLocator()));
  serviceLocator.registerLazySingleton(
      () => CommentsProvider(serviceLocator(), serviceLocator()));
}
