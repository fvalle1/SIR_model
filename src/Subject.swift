enum status{
case susceptible,  infectus,  recovered;
} ;

class Subject{
  var state:status?;
  var name:String;
  var dpi:[DPI?]?;

  init(name:  String="defalut"){
    self.name=name;
    self.state = status.susceptible;
  }

  func repr(){
    guard state==nil else{
      print("name: \(name)");
      print("status: \(self.GetStatusString())");
      return;
    }
  }

  func GetStatusString() -> String{
    guard self.state==nil else{
      switch state{
      case .susceptible:
        return "Susceptible";
      case .infectus:
        return "Infectus";
      case .recovered:
        return "Recovered";
      case .none:
        return "Unknown";
      }
    }
    return "Unknown";
  }

  func InstallApp(){
    if self.dpi==nil {
      self.dpi = [];
    }
    self.dpi!.append(ExposureApp(activate: true));
  }

  func WearMask(fpp2: Bool?){
    if self.dpi==nil {
      self.dpi = [];
    }
    self.dpi!.append(Mask(fpp2: fpp2));
  }
}
