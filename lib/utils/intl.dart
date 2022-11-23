import 'package:tempoloco/utils/helper.dart';

class Str {
  static String get(String key) => translations[key]![Helper.getLanguage()]!;

  // Common
  static String get giveFeedback => get('giveFeedback');
  static String get accept => get('accept');
  static String get deny => get('deny');
  static String get continueStr => get('continue');
  static String get addFriend => get('addFriend');
  static String get close => get('close');
  static String get purchase => get('purchase');
  static String get empty => get('empty');

  // On boarding
  static String get register => get('register');
  static String get login => get('login');
  static String get username => get('username');
  static String get password => get('password');
  static String get forgotPwd => get('forgotPwd');
  static String get kindOfMusic => get('kindOfMusic');
  static String get pick2Genres => get('pick2Genres');
  static String get finish => get('finish');
  static String get pwdReset => get('pwdReset');
  static String get pwdResetEmail => get('pwdResetEmail');
  static String get usernameTooShort => get('usernameTooShort');
  static String get usernameMinChar => get('usernameMinChar');
  static String get usernameWeird => get('usernameWeird');
  static String get enterValidUsername => get('enterValidUsername');

  static String get emailNotValid => get('emailNotValid');
  static String get enterValidEmail => get('enterValidEmail');

  static String get pwdTooShort => get('pwdTooShort');
  static String get pwdMinChar => get('pwdMinChar');

  static String get pwdRefused => get('pwdRefused');
  static String get pwdNotGoodIdea => get('pwdNotGoodIdea');

  // TabView
  static String get songs => get('songs');
  static String get artists => get('artists');
  static String get favorite => get('favorite');
  static String get quickPlay => get('quickPlay');
  static String get noHistory => get('noHistory');
  static String get noResults => get('noResults');

  // Settings
  static String get settings => get('settings');
  static String get vibrations => get('vibrations');
  static String get language => get('language');

  // Profile
  static String get signOut => get('signOut');
  static String get checkFriendHighscores => get('checkFriendHighscores');
  static String get typeUsername => get('typeUsername');
  static String get friendHasNotTempoloco => get('friendHasNotTempoloco');
  static String get friendSendLink => get('friendSendLink');

  // Game
  static String get songBpm => get('songBpm');
  static String get playerBpm => get('playerBpm');
  static String get precision => get('precision');

  // Achievements
  static String get achievements => get('achievements');
  static String get strikes => get('strikes');
  static String get comeBackTomorrow => get('comeBackTomorrow');
  static String get strikesCollect => get('strikesCollect');
}

const translations = {
  // Common
  "giveFeedback": {
    "en": "Give feedback",
    "fr": "Donner son feedback",
    "es": "",
  },
  "accept": {
    "en": "Accept",
    "fr": "Accepter",
    "es": "",
  },
  "deny": {
    "en": "Deny",
    "fr": "Refuser",
    "es": "",
  },
  "continue": {
    "en": "Continue",
    "fr": "Continuer",
    "es": "Continuar",
  },
  "addFriend": {
    "en": "Add friend",
    "fr": "Ajouter un ami",
    "es": "Añadir un amigo",
  },
  "close": {
    "en": "Close",
    "fr": "Fermer",
    "es": "Cerrar",
  },
  "purchase": {
    "en": "Purchase",
    "fr": "Acheter",
    "es": "Comprar",
  },
  "empty": {
    "en": "Empty",
    "fr": "Vide",
    "es": "",
  },
  // On boarding
  "register": {
    "en": "Register",
    "fr": "Inscription",
    "es": "",
  },
  "login": {
    "en": "Already have an account? Log in",
    "fr": "Déjà inscrit ? Connectez-vous",
    "es": "",
  },
  "username": {
    "en": "Username",
    "fr": "Nom d'utilisateur",
    "es": "Nombre de usuario",
  },
  "password": {
    "en": "Password",
    "fr": "Mot de passe",
    "es": "Contraseña",
  },
  "forgotPwd": {
    "en": "Forgot your password ?",
    "fr": "Mot de passe oublié ?",
    "es": "",
  },
  "kindOfMusic": {
    "en": "What kind of music do you like ?",
    "fr": "Qu'est-ce qui vous fait vibrer ?",
    "es": "",
  },
  "pick2Genres": {
    "en": "Pick at least two genres.",
    "fr": "Choisissez au moins 2 genres",
    "es": "",
  },
  "finish": {
    "en": "Finish",
    "fr": "Terminer",
    "es": "",
  },
  "pwdReset": {
    "en": "Password reset",
    "fr": "",
    "es": "",
  },
  "pwdResetEmail": {
    "en": "An email has been sent to",
    "fr": "",
    "es": "",
  },
  "usernameTooShort": {
    "en": "Username is too short",
    "fr": "Nom d'utilisateur trop court",
    "es": "",
  },
  "usernameMinChar": {
    "en": "It should be at least 2 characters",
    "fr": "Au moins 2 caractères",
    "es": "",
  },
  "usernameWeird": {
    "en": "Your username contains weird characters",
    "fr": "Ton nom contient des caractères bizarres",
    "es": "",
  },
  "enterValidUsername": {
    "en": "Please enter a valid username",
    "fr": "Entre un nom valide",
    "es": "",
  },
  "emailNotValid": {
    "en": "Email is not valid",
    "fr": "Email non valide",
    "es": "",
  },
  "enterValidEmail": {
    "en": "Please use a valid email address",
    "fr": "Utilise un email valide",
    "es": "",
  },
  "pwdTooShort": {
    "en": "Password is too short",
    "fr": "Mot de passe trop court",
    "es": "",
  },
  "pwdMinChar": {
    "en": "It should be at least 6 characters",
    "fr": "Entre au moins 6 caractères",
    "es": "",
  },
  "pwdRefused": {
    "en": "Password refused",
    "fr": "Mot de passe refusé",
    "es": "",
  },
  "pwdNotGoodIdea": {
    "en": "Using \$ as password is not a good idea",
    "fr": "\$ n'est pas un mot de passe valide",
    "es": "",
  },
  // TabView
  "songs": {
    "en": "Songs",
    "fr": "Chansons",
    "es": "",
  },
  "artists": {
    "en": "Artists",
    "fr": "Artistes",
    "es": "Artistas",
  },
  "favorite": {
    "en": "Favorite",
    "fr": "Favoris",
    "es": "",
  },
  "quickPlay": {
    "en": "Quick play",
    "fr": "Jeu rapide",
    "es": "Artistas",
  },
  "noHistory": {
    "en": "No history",
    "fr": "Pas encore d'historique",
    "es": "",
  },
  "noResults": {
    "en": "No results",
    "fr": "Aucun résultat",
    "es": "",
  },
  // Settings
  "settings": {
    "en": "Settings",
    "fr": "Réglages",
    "es": "Ajustes",
  },
  "vibrations": {
    "en": "Vibrations",
    "fr": "Vibrations",
    "es": "Vibraciones",
  },
  "language": {
    "en": "Language",
    "fr": "Langue",
    "es": "",
  },
  // Profile
  "signOut": {
    "en": "Sign out",
    "fr": "Déconnexion",
    "es": "",
  },
  "checkFriendHighscores": {
    "en": "Checkout your friend's highscores",
    "fr": "",
    "es": "",
  },
  "typeUsername": {
    "en": "Type username",
    "fr": "",
    "es": "",
  },
  "friendHasNotTempoloco": {
    "en": "Or if your friend doesn't have tempoloco",
    "fr": "Ou si ton ami n'a pas tempoloco",
    "es": "",
  },
  "friendSendLink": {
    "en": "Or send link",
    "fr": "Ou envoie un lien",
    "es": "",
  },
  // Game
  "songBpm": {
    "en": "Song's bpm",
    "fr": "Bpm de la chanson",
    "es": "",
  },
  "playerBpm": {
    "en": "Your bpm",
    "fr": "Votre bpm",
    "es": "",
  },
  "precision": {
    "en": "Precision",
    "fr": "Précision",
    "es": "",
  },
  // Achievements
  "achievements": {
    "en": "Achievements",
    "fr": "Accomplissements",
    "es": "",
  },
  "strikes": {
    "en": "You played \$ day(s) in a row",
    "fr": "Tu as joué \$ jour(s) à la suite",
    "es": "",
  },
  "comeBackTomorrow": {
    "en": "Come back tomorrow",
    "fr": "Reviens demain",
    "es": "",
  },
  "strikesCollect": {
    "en": "Collect \$ stars",
    "fr": "Récupère \$ étoiles",
    "es": "",
  },
};
