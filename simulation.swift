import Foundation

struct Config{
  static let beta = 150; //average number of contacts
  static let N = 5000; //population
  static let days = 180;
  static let SI = 0.9; //probability to infect
  static let gamma = Double(1)/20; //probability to recover
  static let R0 = Double(beta)/gamma;
  static let AppUsage = 0.1; //fraction of people with app
  static let MaskUsage = 0.3;

  static let birth_rate = 0.0001;
  static let death_rate = 0.00008;
}

print("Reading config")
print(CommandLine.arguments)

print("Creating population");

let population = Population(N: Config.N);

print(population.people.count);

print("creating File")


try population.Write(day: 0);

print("starting with R0=\(Config.R0)")

for day in 1...Config.days{
  print("\nday \(day)")

  population.Live();
  population.Bullettin();
  try population.Write(day: day);
}
