class ExposureApp: DPI{
  var status:Bool?;

  init(activate:Bool?){
    status=activate;
  }

  override func GetStatus() -> Bool{
    guard status==nil else{
      return status ?? false;
    }
    return false;
  }

  override func GetEfficacyProbability()->Double{return Config.AppUsage;}
}
