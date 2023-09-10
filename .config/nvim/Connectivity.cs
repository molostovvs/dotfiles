namespace GeekComparer.Domain;

public class Connectivity : ValueObject
{
    public Cellular Cellular { get; set; }
    public WiFi WiFi { get; set; }
    public Bluetooth Bluetooth { get; set; }
    public IReadOnlyList<NavigationSystem> NavigationSystems { get; set; }
    public USB USB { get; set; }
    public bool HasNFC { get; set; }
    public bool HasIR { get; set; }
    public bool HasUWB { get; set; }

    protected override IEnumerable<IComparable> GetEqualityComponents()
    {
        yield return Cellular;
        yield return WiFi;
        yield return Bluetooth;

        foreach (var ns in NavigationSystems)
            yield return ns;

        yield return USB;
    }
}

public class Cellular : ValueObject
{
    public int SimCount { get; set; }
    public IReadOnlyList<SimType> SimType { get; set; }
    public MultiSimMode MultiSimMode { get; set; }
    public IReadOnlyList<TwoGBand> Bands2G { get; set; }
    public IReadOnlyList<ThreeGBand> Bands3G { get; set; }
    public IReadOnlyList<FourGBand> Bands4G { get; set; }
    public IReadOnlyList<FiveGBand> Bands5G { get; set; }

    protected override IEnumerable<IComparable> GetEqualityComponents()
    {
        yield return SimCount;
        foreach (var simType in SimType)
            yield return simType;
        yield return MultiSimMode;

        foreach (var s in Bands2G)
            yield return s;

        foreach (var s in Bands3G)
            yield return s;

        foreach (var s in Bands4G)
            yield return s;

        foreach (var s in Bands5G)
            yield return s;
    }
}

public class TwoGBand : EnumValueObject<TwoGBand, int>
{
    public static readonly TwoGBand TGSM380 = new(1, nameof(TGSM380));
    public static readonly TwoGBand TGSM410 = new(2, nameof(TGSM410));
    public static readonly TwoGBand GSM450 = new(3, nameof(GSM450));
    public static readonly TwoGBand GSM480 = new(4, nameof(GSM480));
    public static readonly TwoGBand GSM710 = new(5, nameof(GSM710));
    public static readonly TwoGBand GSM750 = new(6, nameof(GSM750));
    public static readonly TwoGBand TGSM810 = new(7, nameof(TGSM810));
    public static readonly TwoGBand GSM850 = new(8, nameof(GSM850));
    public static readonly TwoGBand EGSM900 = new(9, nameof(EGSM900));
    public static readonly TwoGBand RGSM900 = new(10, nameof(RGSM900));
    public static readonly TwoGBand TGSM900 = new(11, nameof(TGSM900));
    public static readonly TwoGBand DCS1800 = new(12, nameof(DCS1800));
    public static readonly TwoGBand PCS1900 = new(13, nameof(PCS1900));

    private TwoGBand(int id, string name) : base(id, name) {}
}

public class ThreeGBand : EnumValueObject<ThreeGBand, int>
{
    public static readonly ThreeGBand One = new(1, nameof(One));
    public static readonly ThreeGBand Two = new(2, nameof(Two));
    public static readonly ThreeGBand Three = new(3, nameof(Three));
    public static readonly ThreeGBand Four = new(4, nameof(Four));
    public static readonly ThreeGBand Five = new(5, nameof(Five));
    public static readonly ThreeGBand Six = new(6, nameof(Six));
    public static readonly ThreeGBand Seven = new(7, nameof(Seven));
    public static readonly ThreeGBand Eight = new(8, nameof(Eight));
    public static readonly ThreeGBand Nine = new(9, nameof(Nine));
    public static readonly ThreeGBand Ten = new(10, nameof(Ten));
    public static readonly ThreeGBand Eleven = new(11, nameof(Eleven));
    public static readonly ThreeGBand Twelve = new(12, nameof(Twelve));
    public static readonly ThreeGBand Thirteen = new(13, nameof(Thirteen));
    public static readonly ThreeGBand Fourteen = new(14, nameof(Fourteen));
    public static readonly ThreeGBand Nineteen = new(19, nameof(Nineteen));
    public static readonly ThreeGBand Twenty = new(20, nameof(Twenty));
    public static readonly ThreeGBand TwentyOne = new(21, nameof(TwentyOne));
    public static readonly ThreeGBand TwentyTwo = new(22, nameof(TwentyTwo));
    public static readonly ThreeGBand TwentyFive = new(25, nameof(TwentyFive));
    public static readonly ThreeGBand TwentySix = new(26, nameof(TwentySix));
    public static readonly ThreeGBand ThirtyTwo = new(32, nameof(ThirtyTwo));

    public static readonly ThreeGBand A = new(101, nameof(A));
    public static readonly ThreeGBand B = new(102, nameof(B));
    public static readonly ThreeGBand C = new(103, nameof(C));
    public static readonly ThreeGBand D = new(104, nameof(D));
    public static readonly ThreeGBand E = new(105, nameof(E));
    public static readonly ThreeGBand F = new(106, nameof(F));

    private ThreeGBand(int id, string name) : base(id, name) {}
}

public class FourGBand : EnumValueObject<FourGBand, int>
{
    public static readonly FourGBand One = new(1, nameof(One));
    public static readonly FourGBand Two = new(2, nameof(Two));
    public static readonly FourGBand Three = new(3, nameof(Three));
    public static readonly FourGBand Four = new(4, nameof(Four));
    public static readonly FourGBand Five = new(5, nameof(Five));
    public static readonly FourGBand Seven = new(7, nameof(Seven));
    public static readonly FourGBand Eight = new(8, nameof(Eight));
    public static readonly FourGBand Eleven = new(11, nameof(Eleven));
    public static readonly FourGBand Twelve = new(12, nameof(Twelve));
    public static readonly FourGBand Thirteen = new(13, nameof(Thirteen));
    public static readonly FourGBand Fourteen = new(14, nameof(Fourteen));
    public static readonly FourGBand Seventeen = new(17, nameof(Seventeen));
    public static readonly FourGBand Eighteen = new(18, nameof(Eighteen));
    public static readonly FourGBand Nineteen = new(19, nameof(Nineteen));
    public static readonly FourGBand Twenty = new(20, nameof(Twenty));
    public static readonly FourGBand TwentyOne = new(21, nameof(TwentyOne));
    public static readonly FourGBand TwentyFour = new(24, nameof(TwentyFour));
    public static readonly FourGBand TwentyFive = new(25, nameof(TwentyFive));
    public static readonly FourGBand TwentySix = new(26, nameof(TwentySix));
    public static readonly FourGBand TwentyEight = new(28, nameof(TwentyEight));
    public static readonly FourGBand TwentyNine = new(29, nameof(TwentyNine));
    public static readonly FourGBand Thirty = new(30, nameof(Thirty));
    public static readonly FourGBand ThirtyOne = new(31, nameof(ThirtyOne));
    public static readonly FourGBand ThirtyTwo = new(32, nameof(ThirtyTwo));
    public static readonly FourGBand ThirtyFour = new(34, nameof(ThirtyFour));
    public static readonly FourGBand ThirtySeven = new(37, nameof(ThirtySeven));
    public static readonly FourGBand ThirtyEight = new(38, nameof(ThirtyEight));
    public static readonly FourGBand ThirtyNine = new(39, nameof(ThirtyNine));
    public static readonly FourGBand Forty = new(40, nameof(Forty));
    public static readonly FourGBand FortyOne = new(41, nameof(FortyOne));
    public static readonly FourGBand FortyTwo = new(42, nameof(FortyTwo));
    public static readonly FourGBand FortyThree = new(43, nameof(FortyThree));
    public static readonly FourGBand FortySix = new(46, nameof(FortySix));
    public static readonly FourGBand FortySeven = new(47, nameof(FortySeven));
    public static readonly FourGBand FortyEight = new(48, nameof(FortyEight));
    public static readonly FourGBand Fifty = new(50, nameof(Fifty));
    public static readonly FourGBand FiftyOne = new(51, nameof(FiftyOne));
    public static readonly FourGBand FiftyThree = new(53, nameof(FiftyThree));
    public static readonly FourGBand FiftyFour = new(54, nameof(FiftyFour));
    public static readonly FourGBand SixtyFive = new(65, nameof(SixtyFive));
    public static readonly FourGBand SixtySix = new(66, nameof(SixtySix));
    public static readonly FourGBand SixtySeven = new(67, nameof(SixtySeven));
    public static readonly FourGBand SixtyNine = new(69, nameof(SixtyNine));
    public static readonly FourGBand Seventy = new(70, nameof(Seventy));
    public static readonly FourGBand SeventyOne = new(71, nameof(SeventyOne));
    public static readonly FourGBand SeventyTwo = new(72, nameof(SeventyTwo));
    public static readonly FourGBand SeventyThree = new(73, nameof(SeventyThree));
    public static readonly FourGBand SeventyFour = new(74, nameof(SeventyFour));
    public static readonly FourGBand SeventyFive = new(75, nameof(SeventyFive));
    public static readonly FourGBand SeventySix = new(76, nameof(SeventySix));
    public static readonly FourGBand EightyFive = new(85, nameof(EightyFive));
    public static readonly FourGBand EightySeven = new(87, nameof(EightySeven));
    public static readonly FourGBand EightyEight = new(88, nameof(EightyEight));
    public static readonly FourGBand OneHundredThree = new(103, nameof(OneHundredThree));
    public static readonly FourGBand OneHundredSix = new(106, nameof(OneHundredSix));

    private FourGBand(int id, string name) : base(id, name) {}
}

public class FiveGBand : EnumValueObject<FiveGBand, int>
{
    public static readonly FiveGBand n1 = new(1, nameof(n1));
    public static readonly FiveGBand n2 = new(2, nameof(n2));
    public static readonly FiveGBand n3 = new(3, nameof(n3));
    public static readonly FiveGBand n5 = new(5, nameof(n5));
    public static readonly FiveGBand n7 = new(7, nameof(n7));
    public static readonly FiveGBand n8 = new(8, nameof(n8));
    public static readonly FiveGBand n12 = new(12, nameof(n12));
    public static readonly FiveGBand n13 = new(13, nameof(n13));
    public static readonly FiveGBand n14 = new(14, nameof(n14));
    public static readonly FiveGBand n18 = new(18, nameof(n18));
    public static readonly FiveGBand n20 = new(20, nameof(n20));
    public static readonly FiveGBand n24 = new(24, nameof(n24));
    public static readonly FiveGBand n25 = new(25, nameof(n25));
    public static readonly FiveGBand n26 = new(26, nameof(n26));
    public static readonly FiveGBand n28 = new(28, nameof(n28));
    public static readonly FiveGBand n29 = new(29, nameof(n29));
    public static readonly FiveGBand n30 = new(30, nameof(n30));
    public static readonly FiveGBand n34 = new(34, nameof(n34));
    public static readonly FiveGBand n38 = new(38, nameof(n38));
    public static readonly FiveGBand n39 = new(39, nameof(n39));
    public static readonly FiveGBand n40 = new(40, nameof(n40));
    public static readonly FiveGBand n41 = new(41, nameof(n41));
    public static readonly FiveGBand n46 = new(46, nameof(n46));
    public static readonly FiveGBand n47 = new(47, nameof(n47));
    public static readonly FiveGBand n48 = new(48, nameof(n48));
    public static readonly FiveGBand n50 = new(50, nameof(n50));
    public static readonly FiveGBand n51 = new(51, nameof(n51));
    public static readonly FiveGBand n53 = new(53, nameof(n53));
    public static readonly FiveGBand n54 = new(54, nameof(n54));
    public static readonly FiveGBand n65 = new(65, nameof(n65));
    public static readonly FiveGBand n66 = new(66, nameof(n66));
    public static readonly FiveGBand n67 = new(67, nameof(n67));
    public static readonly FiveGBand n70 = new(70, nameof(n70));
    public static readonly FiveGBand n71 = new(71, nameof(n71));
    public static readonly FiveGBand n74 = new(74, nameof(n74));
    public static readonly FiveGBand n75 = new(75, nameof(n75));
    public static readonly FiveGBand n76 = new(76, nameof(n76));
    public static readonly FiveGBand n77 = new(77, nameof(n77));
    public static readonly FiveGBand n78 = new(78, nameof(n78));
    public static readonly FiveGBand n79 = new(79, nameof(n79));
    public static readonly FiveGBand n80 = new(80, nameof(n80));
    public static readonly FiveGBand n81 = new(81, nameof(n81));
    public static readonly FiveGBand n82 = new(82, nameof(n82));
    public static readonly FiveGBand n83 = new(83, nameof(n83));
    public static readonly FiveGBand n84 = new(84, nameof(n84));
    public static readonly FiveGBand n85 = new(85, nameof(n85));
    public static readonly FiveGBand n86 = new(86, nameof(n86));
    public static readonly FiveGBand n89 = new(89, nameof(n89));
    public static readonly FiveGBand n90 = new(90, nameof(n90));
    public static readonly FiveGBand n91 = new(91, nameof(n91));
    public static readonly FiveGBand n92 = new(92, nameof(n92));
    public static readonly FiveGBand n93 = new(93, nameof(n93));
    public static readonly FiveGBand n94 = new(94, nameof(n94));
    public static readonly FiveGBand n95 = new(95, nameof(n95));
    public static readonly FiveGBand n96 = new(96, nameof(n96));
    public static readonly FiveGBand n97 = new(97, nameof(n97));
    public static readonly FiveGBand n98 = new(98, nameof(n98));
    public static readonly FiveGBand n99 = new(99, nameof(n99));
    public static readonly FiveGBand n100 = new(100, nameof(n100));
    public static readonly FiveGBand n101 = new(101, nameof(n101));
    public static readonly FiveGBand n102 = new(102, nameof(n102));
    public static readonly FiveGBand n104 = new(104, nameof(n104));
    public static readonly FiveGBand n105 = new(105, nameof(n105));

    private FiveGBand(int id, string name) : base(id, name) {}
}

public class MultiSimMode : EnumValueObject<MultiSimMode, int>
{
    public static readonly MultiSimMode Standby = new(1, nameof(Standby));
    public static readonly MultiSimMode Active = new(2, nameof(Active));

    private MultiSimMode(int id, string name) : base(id, name) {}
}

public class SimType : EnumValueObject<SimType, int>
{
    public static readonly SimType Standard = new(1, nameof(Standard));
    public static readonly SimType Mini = new(2, nameof(Mini));
    public static readonly SimType Micro = new(3, nameof(Micro));
    public static readonly SimType Nano = new(4, nameof(Nano));
    public static readonly SimType Embedded = new(5, nameof(Embedded));
    public static readonly SimType Integrated = new(6, nameof(Integrated));

    private SimType(int id, string name) : base(id, name) {}
}

public class NavigationSystem : EnumValueObject<NavigationSystem, int>
{
    public static readonly NavigationSystem GPS = new(1, nameof(GPS));
    public static readonly NavigationSystem GLONASS = new(2, nameof(GLONASS));
    public static readonly NavigationSystem Beidou = new(3, nameof(Beidou));
    public static readonly NavigationSystem Galileo = new(4, nameof(Galileo));
    public static readonly NavigationSystem QZSS = new(5, nameof(QZSS));
    public static readonly NavigationSystem NAVIC = new(6, nameof(NAVIC));

    private NavigationSystem(int id, string name) : base(id, name) {}
}

public class USB : ValueObject
{
    public string Version { get; set; }
    public UsbConnector Connector { get; set; }
    public IReadOnlyList<UsbFeature> Features { get; set; }

    protected override IEnumerable<IComparable> GetEqualityComponents()
    {
        yield return Version;
        yield return Connector;

        foreach (var feature in Features)
            yield return feature;
    }
}

public class UsbFeature : EnumValueObject<UsbFeature, int>
{
    public static readonly UsbFeature Charging = new(1, nameof(Charging));
    public static readonly UsbFeature OTG = new(2, nameof(OTG));
    public static readonly UsbFeature StorageMode = new(3, nameof(StorageMode));

    private UsbFeature(int id, string name) : base(id, name) {}
}

public class UsbConnector : EnumValueObject<UsbConnector, int>
{
    public static readonly UsbConnector C = new(1, nameof(C));
    public static readonly UsbConnector Micro = new(2, nameof(Micro));
    public static readonly UsbConnector Lightning = new(3, nameof(Lightning));

    private UsbConnector(int id, string name) : base(id, name) {}
}

public class Bluetooth : ValueObject
{
    public string Version { get; set; }

    protected override IEnumerable<IComparable> GetEqualityComponents()
    {
        yield return Version;
    }
}

public class WiFi : ValueObject
{
    public IReadOnlyList<WiFiStandard> Standards { get; set; }

    protected override IEnumerable<IComparable> GetEqualityComponents()
        => Standards;
}

public class WiFiStandard : EnumValueObject<WiFiStandard, int>
{
    public static readonly WiFiStandard b = new(1, nameof(b));
    public static readonly WiFiStandard a = new(2, nameof(a));
    public static readonly WiFiStandard g = new(3, nameof(g));
    public static readonly WiFiStandard n = new(4, nameof(n));
    public static readonly WiFiStandard ac = new(5, nameof(ac));
    public static readonly WiFiStandard ax = new(6, nameof(ax));
    public static readonly WiFiStandard be = new(7, nameof(be));

    private WiFiStandard(int id, string name) : base(id, name) {}
}