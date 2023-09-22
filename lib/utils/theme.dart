part of 'utils.dart';

class AppTheme {
  AppTheme._();

  static ThemeData darkTheme({
    required BuildContext context,
  }) {
    return ThemeData(
      scaffoldBackgroundColor: backgroundColor,
      textButtonTheme: TextButtonThemeData(
        style: TextButton.styleFrom(
          foregroundColor: whiteColor,
          backgroundColor: Colors.transparent,
          elevation: 0.0,
        ),
      ),
      textSelectionTheme: TextSelectionThemeData(
        selectionHandleColor: spotifyColor,
        cursorColor: spotifyColor,
        selectionColor: spotifyColor,
      ),
      inputDecorationTheme: InputDecorationTheme(
        focusedBorder: UnderlineInputBorder(
          borderSide: BorderSide(
            width: 1.5,
            color: spotifyColor,
          ),
        ),
      ),
      listTileTheme: ListTileThemeData(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(7.0),
        ),
      ),
      visualDensity: VisualDensity.adaptivePlatformDensity,
      brightness: Brightness.dark,
      appBarTheme: AppBarTheme(
        color: spotifyColor,
        foregroundColor: whiteColor,
      ),
      canvasColor: spotifyColor,
      cardColor: cardColor,
      cardTheme: CardTheme(
        clipBehavior: Clip.antiAlias,
        elevation: 5,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(7.0),
        ),
      ),
      dialogBackgroundColor: cardColor,
      progressIndicatorTheme: const ProgressIndicatorThemeData().copyWith(
        color: spotifyColor,
      ),
      iconTheme: IconThemeData(
        color: whiteColor,
        opacity: 1.0,
        size: 24.0,
      ),
      indicatorColor: spotifyColor,
      colorScheme: Theme.of(context).colorScheme.copyWith(
            primary: Colors.white,
            secondary: spotifyColor,
            brightness: Brightness.dark,
          ),
    );
  }
}
