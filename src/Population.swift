class Population : FileWriter{
  var people:[Subject];

  var currently_susceptibles:Int;
  var currently_infectus:Int;
  var currently_recevered:Int;

  init(N:Int){
    people = [];

    for _ in 0..<N{
      let sub = Subject();
      if Double.random(in:0..<1) < Config.AppUsage{
        sub.InstallApp();
      }

      if Double.random(in:0..<1) < Config.MaskUsage{
        sub.WearMask(fpp2: Double.random(in:0..<1) > 0.95);
      }

      people.append(sub);

    }
    currently_susceptibles = N;
    currently_infectus = 0;
    currently_recevered = 0;

    do{
      try  write("day,susceptible,infectus,recovered\n");
    }catch {
      print("Will not store Files");
    }
  }

  func Live()->Void{
    serialQueue.async{

      for person in self.people{
        switch person.state{
        case .susceptible:
          if Double.random(in:0..<1) < (Double(Config.beta) * Config.SI / Double(Config.N)){
            person.state = status.infectus;
            for device in person.dpi ?? []{
              if (device?.GetStatus() ?? false) && (Double.random(in:0..<1) > device?.GetEfficacyProbability() ?? 0.0){
                person.state = status.susceptible;
              }
            }
          }
        case .infectus:
          if Double.random(in:0..<1) < Double(Config.gamma){
            person.state = status.recovered;
          };
        case .recovered:
          continue;
        case .none:
          continue;
        }
      }
    }
  }

  func Diagnosis(){
    currently_susceptibles = 0;
    currently_infectus = 0;
    currently_recevered = 0;
    serialQueue.async{
      for person in self.people{
        switch person.state{
        case .susceptible:
          self.currently_susceptibles+=1;
        case .infectus:
          self.currently_infectus+=1;
        case .recovered:
          self.currently_recevered+=1;
        case .none:
          continue;
        }
      }
    }
  }

  func Update() -> Void{
    //new births
    for _ in 0..<Int(Double(people.count)*Config.birth_rate){
      people.append(Subject());
    }

    //new deaths
    for _ in 0..<Int(Double(people.count)*Config.death_rate){
      people.remove(at: Int.random(in: 0..<people.count));
    }
    Diagnosis();

  }

  func Bullettin()-> Void{
    Update();
    print("infectus: \(currently_infectus) of \(people.count)")
    print("recovered: \(currently_recevered)")
  }

  func ReadbleBullettin() -> [Int]{
    return [currently_susceptibles, currently_infectus, currently_recevered]
  }

  func Write(day: Int) throws{
    let read_bull = self.ReadbleBullettin();
    try write("\(day),\(read_bull[0]),\(read_bull[1]),\(read_bull[2])\n");
  }

}
