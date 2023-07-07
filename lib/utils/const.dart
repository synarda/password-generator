class Const {
  static const defaultQuestion = "pgenerator";

  static const charsets = [
    "ABCDEFGHIİJKLMNOPRSTUVYZXW",
    "abcdefghijklmnoprstuvyzxw",
    "0123456789",
    "*-+/.;:<>|?&%+^'!é",
  ];
  static const List<Map<String, dynamic>> welcomePageItems = [
    {"title": "Generate", "photographPath": "lib/assets/wel04.png", "description": "generate_passwords_description"},
    {"title": "Save", "photographPath": "lib/assets/wel03.png", "description": "save_description"},
    {"title": "Add_Category", "photographPath": "lib/assets/wel02.png", "description": "add_category_description"},
    {"title": "safe_passwords", "photographPath": "lib/assets/wel.png", "description": "safe_passwords_description"},
  ];

  static const emojis = [
    "👨‍💻",
    "🎮",
    "📱",
    "📧",
    "🏆",
    "🥇",
    "🥈",
    "🥉",
    "🎬",
    "🎧",
    "🏛️",
    "🏠",
    "🏥",
    "🏢",
    "🏦",
    "🏫",
    "🚗",
    "💵",
    "🗺️",
    "⌚",
    "🕹️",
    "🧸",
    "☎️",
    "💿",
    "🔔",
    "🗝️",
    "🔑",
    "🔒",
    "📅",
    "🖊️",
  ];

  static const questions = [
    'In_what_city_were_you_born?',
    'What_is_the_name_of_your_favorite_pet?',
    "What_high_school_did_you_attend?",
    "What_was_your_favorite_food_as_a_child?"
  ];
}
