function Set-PhilipsHue
{
    [cmdletbinding()]
    Param(
        [parameter(Mandatory=$true)]
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
        [int32]$Saturation
    )
    Add-Type -TypeDefinition "namespace Philips`n{`n    using System;`n    using System.Linq;`n    using System.Collections.Generic;`n    public class Hue : Dictionary<string,LightObject>`n    {`n        public Hue()`n        {`n        }`n    }`n    public class LightObject`n    {`n        public State state { get; set; }`n        public Swupdate swupdate { get; set; }`n        public string type { get; set; }`n        public string name { get; set; }`n        public string modelid { get; set; }`n        public string manufacturername { get; set; }`n        public string productname { get; set; }`n        public Capabilities capabilities { get; set; }`n        public Config config { get; set; }`n        public string uniqueid { get; set; }`n        public string swversion { get; set; }`n        public string swconfigid { get; set; }`n        public string productid { get; set; }`n    }`n    public class Capabilities`n    {`n        public bool certified { get; set; }`n        public Control control { get; set; }`n        public Streaming streaming { get; set; }`n    }`n    public class Config`n    {`n        public string archetype { get; set; }`n        public string function { get; set; }`n        public string direction { get; set; }`n        public Startup startup { get; set; }`n    }`n    public class Control`n    {`n        public int mindimlevel { get; set; }`n        public int maxlumen { get; set; }`n        public string colorgamuttype { get; set; }`n        public List<List<double>> colorgamut { get; set; }`n        public Ct ct { get; set; }`n    }`n    public class Ct`n    {`n        public int min { get; set; }`n        public int max { get; set; }`n    }`n    public class Startup`n    {`n        public string mode { get; set; }`n        public bool configured { get; set; }`n    }`n    public class State`n    {`n        public bool on { get; set; }`n        public int bri { get; set; }`n        public int hue { get; set; }`n        public int sat { get; set; }`n        public string effect { get; set; }`n        public List<double> xy { get; set; }`n        public int ct { get; set; }`n        public string alert { get; set; }`n        public string colormode { get; set; }`n        public string mode { get; set; }`n        public bool reachable { get; set; }`n    }`n    public class Streaming`n    {`n        public bool renderer { get; set; }`n        public bool proxy { get; set; }`n    }`n    public class Swupdate`n    {`n        public string state { get; set; }`n        public DateTime lastinstall { get; set; }`n    }`n    public class Create`n    {`n        public void begin()`n        {`n            JsonList.Add(`"namespace Philips\n{\n    using System;\n    using System.Collections.Generic;\n    public class RequestBody\n    {\n        public RequestBody()\n        {\n        }`");`n        }`n        public void bri(int brightness)`n        {`n            JsonList.Add(String.Format(`"        public int bri = {0};`", brightness.ToString()));`n        }`n        public void effect(string effect)`n        {`n            JsonList.Add(String.Format(`"        public string effect = {0};`", effect));`n        }`n        public void hue(string color)`n        {`n            List_ Colors = new List_();`n            Value_ color_object = Colors.ColorList.Where(i => { return (i.Name == color); }).FirstOrDefault();`n            Double hue = color_object.HueValue;`n            List<Double> xy_ = Philips.Convert.ToXy(color_object);`n            JsonList.Add(String.Format(`"        public int hue = {0};`", hue.ToString()));`n            xy(xy_);`n        }`n        public void on(bool on)`n        {`n            JsonList.Add(String.Format(`"        public bool on = {0};`", on.ToString().ToLower()));`n        }`n        public void sat(int saturation)`n        {`n            JsonList.Add(String.Format(`"        public int sat = {0};`", saturation.ToString()));`n        }`n        public void xy(List<Double> xy)`n        {`n            JsonList.Add(String.Format(`"        public List<Double> xy = new List<Double>(){{ {0}, {1} }};`", xy[0].ToString(), xy[1].ToString()));`n        }`n        public void end()`n        {`n            JsonList.Add(`"    }\n}`");`n            JsonString = String.Join(`"\n`",JsonList);`n        }`n        public List<string> JsonList = new List<string>();`n        public string JsonString = String.Empty;`n    }`n    public class Convert`n    {`n        public static List<Double> ToXy(Value_ c)`n        {`n            Double[] normalizedToOne = new Double[3];`n            Double cred = System.Convert.ToDouble(c.Red);`n            Double cgreen = System.Convert.ToDouble(c.Green);`n            Double cblue = System.Convert.ToDouble(c.Blue);`n            normalizedToOne[0] = (cred / 255);`n            normalizedToOne[1] = (cgreen / 255);`n            normalizedToOne[2] = (cblue / 255);`n            Double red;`n            Double green;`n            Double blue;`n            if (normalizedToOne[0] > 0.04045)`n            {`n                red = Math.Pow((normalizedToOne[0] + 0.055) / (1.0 + 0.055), 2.4);`n            }`n            else`n            {`n                red = normalizedToOne[0] / 12.92;`n            }`n            if (normalizedToOne[1] > 0.04045)`n            {`n                green = Math.Pow((normalizedToOne[1] + 0.055) / (1.0 + 0.055), 2.4);`n            }`n            else`n            {`n                green = normalizedToOne[1] / 12.92;`n            }`n            if (normalizedToOne[2] > 0.04045)`n            {`n                blue = Math.Pow((normalizedToOne[2] + 0.055) / (1.0 + 0.055), 2.4);`n            }`n            else`n            {`n                blue = normalizedToOne[2] / 12.92;`n            }`n            Double X_ = (red * 0.649926) + (green * 0.103455) + (blue * 0.197109);`n            Double Y_ = (red * 0.234327) + (green * 0.743075) + (blue * 0.022598);`n            Double Z_ = (red * 0.0000000) + (green * 0.053077) + (blue * 1.035763);`n            Double x = X_ / (X_ + Y_ + Z_);`n            Double y = Y_ / (X_ + Y_ + Z_);`n            List<Double> xyAsList = new List<Double>();`n            xyAsList.Add(x);`n            xyAsList.Add(y);`n            return xyAsList;`n        }`n    }`n    public class Value_`n    {`n        public string Name`n        {`n            get;`n            set;`n        }`n        public int Red`n        {`n            get;`n            set;`n        }`n        public int Green`n        {`n            get;`n            set;`n        }`n        public int Blue`n        {`n            get;`n            set;`n        }`n        public Double Increment`n        {`n            get;`n            set;`n        }`n        public Double HueValue`n        {`n            get;`n            set;`n        }`n        public Value_()`n        {`n        }`n    }`n    public class List_`n    {`n        public List<Value_> ColorList = new List<Value_>()`n        {`n            new Value_()`n            {`n                Name      = `"red`",`n                Red       = 255,`n                Green     = 0,`n                Blue      = 0,`n                Increment = 0,`n                HueValue  = 0`n            },`n            new Value_()`n            {`n                Name      = `"orange`",`n                Red       = 255,`n                Green     = 127,`n                Blue      = 0,`n                Increment = 127,`n                HueValue  = 5440`n            },`n            new Value_()`n            {`n                Name      = `"yellow`",`n                Red       = 255,`n                Green     = 255,`n                Blue      = 0,`n                Increment = 255,`n                HueValue  = 10923`n            },`n            new Value_()`n            {`n                Name      = `"chartreuse`",`n                Red       = 127,`n                Green     = 255,`n                Blue      = 0,`n                Increment = 382.5,`n                HueValue  = 16384`n            },`n            new Value_()`n            {`n                Name      = `"electric green`",`n                Red       = 0,`n                Green     = 255,`n                Blue      = 0,`n                Increment = 510,`n                HueValue  = 21845`n            },`n            new Value_()`n            {`n                Name      = `"spring green`",`n                Red       = 0,`n                Green     = 255,`n                Blue      = 127,`n                Increment = 637.5,`n                HueValue  = 27307`n            },`n            new Value_()`n            {`n                Name      = `"aqua`",`n                Red       = 0,`n                Green     = 255,`n                Blue      = 255,`n                Increment = 765,`n                HueValue  = 32768`n            },`n            new Value_()`n            {`n                Name      = `"azure`",`n                Red       = 0,`n                Green     = 127,`n                Blue      = 255,`n                Increment = 892.5,`n                HueValue  = 38229`n            },`n            new Value_()`n            {`n                Name      = `"blue`",`n                Red       = 0,`n                Green     = 0,`n                Blue      = 255,`n                Increment = 1020,`n                HueValue  = 43691`n            },`n            new Value_()`n            {`n                Name      = `"violet`",`n                Red       = 127,`n                Green     = 0,`n                Blue      = 255,`n                Increment = 1147.5,`n                HueValue  = 49152`n            },`n            new Value_()`n            {`n                Name      = `"fuchsia`",`n                Red       = 255,`n                Green     = 0,`n                Blue      = 255,`n                Increment = 1275,`n                HueValue  = 54613`n            },`n            new Value_()`n            {`n                Name      = `"bright pink`",`n                Red       = 255,`n                Green     = 0,`n                Blue      = 127,`n                Increment = 1402.5,`n                HueValue  = 60075`n            },`n            new Value_()`n            {`n                Name      = `"red`",`n                Red       = 255,`n                Green     = 0,`n                Blue      = 0,`n                Increment = 1530,`n                HueValue  = 65536`n            }`n        };`n        public List_()`n        {`n        }`n    }`n}"
    $lights = [System.Net.WebClient]::New().DownloadString($ENV:PHILIPS_HUE_URI)
    $all_lights = $lights | ConvertFrom-Json
    $light_Id = @($all_lights | gm -MemberType NoteProperty |% Name).Where({ $all_lights."$($_)".name -eq $LightName })
    if(!$light_Id)
    {
        Write-Host "Light name: $($LightName) not found!" -ForegroundColor Red
        Write-Host "Choose from the following:" -ForegroundColor Green
        @($all_lights | gm -MemberType NoteProperty |% Name).ForEach({
            Write-Host "    $($all_lights."$($_)".name)" -ForegroundColor Yellow
        })
        return
    }
    $create = [Philips.Create]::New()
    $create.begin()
    if($Brightness -gt 0)
    {
        $create.bri($Brightness)
    }
    if(![String]::IsNullOrEmpty($Effect))
    {
        $create.effect($Effect)
    }
    if(![String]::IsNullOrEmpty($PowerState))
    {
        switch($PowerState)
        {
            "On" {
                $create.on($true)
            }
            "Off" {
                $create.on($false)
            }
        }
    }
    if($Saturation -gt 0)
    {
        $create.sat($Saturation)
    }
    if(![String]::IsNullOrEmpty($Color))
    {
        $create.hue($Color)
    }
    $create.end()
    $typename = "Philips.RequestBody"
    $iter = 0
    while($typename-as [type])
    {
        $iter++
        $typename = "Philips" + $iter.ToString() + ".RequestBody"
    }
    if($iter -gt 0)
    {
        $create.JsonString = $create.JsonString -replace "namespace Philips","namespace Philips$($iter.ToString())"
        Add-Type -TypeDefinition $create.JsonString
        $t = $typename -as [type]
        $p_obj = [System.Activator]::CreateInstance($t)
    } else {
        Add-Type -TypeDefinition $create.JsonString
        $p_obj = [Philips.RequestBody]::new()
    }
    $payload = $p_obj | ConvertTo-Json -Compress
    $r = Invoke-WebRequest -Uri "$($env:PHILIPS_HUE_URI)/$($light_id)/state/" -Method Put -ContentType "application/json" -Body $payload
    return $r
}
