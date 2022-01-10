class Days {
  static const monday = "monday";
  static const tuesday = "tuesday";
  static const wednesday = "wednesday";
  static const thursday = "thursday";
  static const friday = "friday";
  static const saturday = "saturday";
  static const sunday = "sunday";

  static List<String> get all => const [
        monday,
        tuesday,
        wednesday,
        thursday,
        friday,
        saturday,
        sunday,
      ];

  static List<String> get withoutSunday => all.sublist(0, 6);

  static int weekday(String name) => all.indexOf(name);
}
