class Time {
   int? hour;
   int? minute;

  Time({ this.hour,  this.minute});
}

class Drug {
   String title;
   String? description;
   String? date;
   String? time;
   String frequencyOfIntake;

  Drug({
    required this.title,
     this.description,
     this.date,
     this.time,
    required this.frequencyOfIntake,
  });
}