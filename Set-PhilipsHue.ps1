function Set-PhilipsHue
{
    [cmdletbinding()]
    Param(
        [parameter(Mandatory=$true)]
        [ValidateSet("Lamp 2","Counter 2","Travis Closet","Bath Strip","Hall Lamp","Bath2","Cabinet Lightstrip","Counter 1","Lamp 1","Bed","Hue Blow")]
        [string]$LightName,
        [ValidateSet("red", "orange", "yellow", "chartreuse", "electric green", "spring green", "aqua", "azure", "blue", "violet", "fuchsia", "bright pink")]
        [string]$Color,
        [ValidateRange(1,254)]
        [int32]$Brightness,
        [ValidateSet("none","colorloop")]
        [string]$Effect,
        [ValidateSet("On","Off")]
        [string]$PowerState,
        [ValidateRange(1,254)]
        [int32]$Saturation,
        [ValidateRange(0.0,1.0)]
        [Double]$X,
        [ValidateRange(0.0,1.0)]
        [Double]$Y
    )
    Add-Type -Path "C:\.TEMP\BIN\newtonsoft.json.13.0.1\lib\net45\Newtonsoft.Json.dll"
    Add-Type -TypeDefinition "namespace Hue`n{`n    using System;`n    using System.Collections.Generic;`n    public class Payload`n    {`n        public Payload()`n        {`n        }`n        public int bri`n        {`n            get;`n            set;`n        }`n        public string effect`n        {`n            get;`n            set;`n        }`n        public int hue`n        {`n            get;`n            set;`n        }`n        public bool on`n        {`n            get;`n            set;`n        }`n        public int sat`n        {`n            get;`n            set;`n        }`n        public List<Double> xy`n        {`n            get;`n            set;`n        }`n    }`n}"
    Add-Type -TypeDefinition "namespace Color`n{`n    using System;`n    using System.Collections.Generic;`n    public class Value_`n    {`n        public string Name`n        {`n            get;`n            set;`n        }`n        public int Red`n        {`n            get;`n            set;`n        }`n        public int Green`n        {`n            get;`n            set;`n        }`n        public int Blue`n        {`n            get;`n            set;`n        }`n        public Double Increment`n        {`n            get;`n            set;`n        }`n        public Double HueValue`n        {`n            get;`n            set;`n        }`n        public Value_()`n        {`n        }`n    }`n    public class List_`n    {`n        public List<Value_> ColorList = new List<Value_>()`n        {`n            new Value_()`n            {`n                Name      = `"red`",`n                Red       = 255,`n                Green     = 0,`n                Blue      = 0,`n                Increment = 0,`n                HueValue  = 0`n            },`n            new Value_()`n            {`n                Name      = `"orange`",`n                Red       = 255,`n                Green     = 127,`n                Blue      = 0,`n                Increment = 127,`n                HueValue  = 5440`n            },`n            new Value_()`n            {`n                Name      = `"yellow`",`n                Red       = 255,`n                Green     = 255,`n                Blue      = 0,`n                Increment = 255,`n                HueValue  = 10923`n            },`n            new Value_()`n            {`n                Name      = `"chartreuse`",`n                Red       = 127,`n                Green     = 255,`n                Blue      = 0,`n                Increment = 382.5,`n                HueValue  = 16384`n            },`n            new Value_()`n            {`n                Name      = `"electric green`",`n                Red       = 0,`n                Green     = 255,`n                Blue      = 0,`n                Increment = 510,`n                HueValue  = 21845`n            },`n            new Value_()`n            {`n                Name      = `"spring green`",`n                Red       = 0,`n                Green     = 255,`n                Blue      = 127,`n                Increment = 637.5,`n                HueValue  = 27307`n            },`n            new Value_()`n            {`n                Name      = `"aqua`",`n                Red       = 0,`n                Green     = 255,`n                Blue      = 255,`n                Increment = 765,`n                HueValue  = 32768`n            },`n            new Value_()`n            {`n                Name      = `"azure`",`n                Red       = 0,`n                Green     = 127,`n                Blue      = 255,`n                Increment = 892.5,`n                HueValue  = 38229`n            },`n            new Value_()`n            {`n                Name      = `"blue`",`n                Red       = 0,`n                Green     = 0,`n                Blue      = 255,`n                Increment = 1020,`n                HueValue  = 43691`n            },`n            new Value_()`n            {`n                Name      = `"violet`",`n                Red       = 127,`n                Green     = 0,`n                Blue      = 255,`n                Increment = 1147.5,`n                HueValue  = 49152`n            },`n            new Value_()`n            {`n                Name      = `"fuchsia`",`n                Red       = 255,`n                Green     = 0,`n                Blue      = 255,`n                Increment = 1275,`n                HueValue  = 54613`n            },`n            new Value_()`n            {`n                Name      = `"bright pink`",`n                Red       = 255,`n                Green     = 0,`n                Blue      = 127,`n                Increment = 1402.5,`n                HueValue  = 60075`n            },`n            new Value_()`n            {`n                Name      = `"red`",`n                Red       = 255,`n                Green     = 0,`n                Blue      = 0,`n                Increment = 1530,`n                HueValue  = 65536`n            }`n        };`n        public List_()`n        {`n        }`n    }`n}"
    Add-Type -TypeDefinition "namespace Philips`n{`n    using System;`n    using System.Collections.Generic;`n    public class Hue : Dictionary<string,LightObject>`n    {`n        public Hue()`n        {`n        }`n    }`n    public class LightObject`n    {`n        public State state { get; set; }`n        public Swupdate swupdate { get; set; }`n        public string type { get; set; }`n        public string name { get; set; }`n        public string modelid { get; set; }`n        public string manufacturername { get; set; }`n        public string productname { get; set; }`n        public Capabilities capabilities { get; set; }`n        public Config config { get; set; }`n        public string uniqueid { get; set; }`n        public string swversion { get; set; }`n        public string swconfigid { get; set; }`n        public string productid { get; set; }`n    }`n    public class Capabilities`n    {`n        public bool certified { get; set; }`n        public Control control { get; set; }`n        public Streaming streaming { get; set; }`n    }`n    public class Config`n    {`n        public string archetype { get; set; }`n        public string function { get; set; }`n        public string direction { get; set; }`n        public Startup startup { get; set; }`n    }`n    public class Control`n    {`n        public int mindimlevel { get; set; }`n        public int maxlumen { get; set; }`n        public string colorgamuttype { get; set; }`n        public List<List<double>> colorgamut { get; set; }`n        public Ct ct { get; set; }`n    }`n    public class Ct`n    {`n        public int min { get; set; }`n        public int max { get; set; }`n    }`n    public class Startup`n    {`n        public string mode { get; set; }`n        public bool configured { get; set; }`n    }`n    public class State`n    {`n        public bool on { get; set; }`n        public int bri { get; set; }`n        public int hue { get; set; }`n        public int sat { get; set; }`n        public string effect { get; set; }`n        public List<double> xy { get; set; }`n        public int ct { get; set; }`n        public string alert { get; set; }`n        public string colormode { get; set; }`n        public string mode { get; set; }`n        public bool reachable { get; set; }`n    }`n    public class Streaming`n    {`n        public bool renderer { get; set; }`n        public bool proxy { get; set; }`n    }`n    public class Swupdate`n    {`n        public string state { get; set; }`n        public DateTime lastinstall { get; set; }`n    }`n}"
    $all_lights = [Newtonsoft.Json.JsonConvert]::DeserializeObject(
        [System.Net.WebClient]::New().DownloadString($ENV:PHILIPS_HUE_URI),
        [Philips.Hue]
    )
    $light_id = $all_lights.keys.Where({$all_lights[$_].name -eq $LightName})[0]
    $payload = [System.Collections.Generic.Dictionary[[string],[object]]]::New()
    if($Brightness -gt 0)
    {
        $payload["bri"] = $Brightness
    }
    if(![String]::IsNullOrEmpty($Effect))
    {
        $payload["effect"] = $Effect
    }
    if(![String]::IsNullOrEmpty($PowerState))
    {
        switch($PowerState)
        {
            "On" { $payload["on"] = $true }
            "Off" { $payload["on"] = $false }
        }
    }
    if($Saturation -gt 0)
    {
        $payload["sat"] = $Saturation
    }
    if($X -gt 0 -and $Y -gt 0)
    {
        $payload["xy"] = "[$($X),$($Y)]"
    }
    if($light_id -in @(4,9,12) -and $Color -eq "blue")
    {
        switch($light_id)
        {
            4   {
                $payload["colormode"] = "xy"
                $payload["ct"] = 153
                $payload["xy"] = "[0.1567,0.1044]"
                $payload["sat"] = 254
            }
            9   {
                $payload["ct"] = 500
                $payload["xy"] = "[0.1567,0.1044]"
                $payload["sat"] = 254
            }
            12  {
                $payload["ct"] = 500
                $payload["xy"] = "[0.1567,0.1044]"
                $payload["sat"] = 254
            }
        }
        if($light_id -in @(9,12))
        {
            $payload["ct"] = 500
        } else {
            $payload["colormode"] = "xy"
            $payload["ct"] = 153
        }
        $payload["xy"] = "[0.1567,0.1044]"
        $payload["sat"] = 254
    }
    if(![String]::IsNullOrEmpty($Color))
    {
        $ColorWheel = [Color.List_]::new()
        $color_object = $ColorWheel.ColorList.Where({$_.Name -eq $Color})[0]
        $payload["hue"] = $color_object.HueValue
    }
    $pj = "{"
    $payload.Keys.ForEach({
        $key = $_
        $pj = $pj + "`"$($key)`":"
        switch($key)
        {
            "bri"       {$pj = $pj + "$($payload[$key]),"}
            "effect"    {$pj = $pj + "`"$($payload[$key])`","}
            "on"        {$pj = $pj + "$($payload[$key].ToString().ToLower()),"}
            "sat"       {$pj = $pj + "$($payload[$key]),"}
            "xy"        {$pj = $pj + "$($payload[$key]),"}
            "hue"       {$pj = $pj + "$($payload[$key]),"}
            "ct"        {$pj = $pj + "$($payload[$key]),"}
            "colormode" {$pj = $pj + "`"$($payload[$key])`","}
        }
    })
    $pj = [regex]::new("(,$)").Replace($pj,"}")
    Write-Host $pj
    $r = [Execute.HttpRequest]::Send(
        "$($env:PHILIPS_HUE_URI)/$($light_id)/state/",
        [System.Net.Http.HttpMethod]::Put,
        $null,
        $null,
        "application/json",
        $pj
    )
    return $r
}