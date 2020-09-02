class Mask: DPI{
  var isFPP2:Bool?;

  init(fpp2:Bool? = false){self.isFPP2 = fpp2;}
  override func GetStatus()->Bool{return true;}
  override func GetEfficacyProbability()->Double{
    if isFPP2 ?? false{
      return 0.9 * Config.MaskUsage;
    }else{
      return 0.3 * Config.MaskUsage;
    }
  }
}
