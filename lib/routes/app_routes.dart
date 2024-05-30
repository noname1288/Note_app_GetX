part of 'app_pages.dart';

abstract class Routes {
  Routes();

  static const HOMEPAGE = _Paths.HOMEPAGE;
  static const CREATEPAGE = _Paths.CREATEPAGE;
  static const EDITPAGE = _Paths.EDITPAGE;
  static const SEARCHPAGE = _Paths.SEARCHPAGE;

}

abstract class _Paths {

  static const HOMEPAGE = '/home';
  static const CREATEPAGE = '/create';
  static const EDITPAGE = '/edit';
  static const SEARCHPAGE = '/search';
  
}
