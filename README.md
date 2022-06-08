# Set-PhillipsHue
Windows PowerShell cmdlet to set the hue, brightness, saturation, effect, and power state of Phillips Hue light bulbs.  
  
I was able to implement [this](https://stackoverflow.com/a/22649803) in C# in order to convert RGB values into XY values.  

Script assumes you've set a **PHILIPS_HUE_URI** environment variable to:  
  
```
http://<Hue Bridge Uri or IP Address>/api/<Philips Hue API Key>/lights
```  
  
## Quick Start
Using **Windows PowerShell** (*not PowerShell Core*) you can make this script available to you by running the following commands.  
```ps1

```  
## Get-Help Set-PhillipsHue -Full
```ps1

NAME
    Set-PhilipsHue
    
SYNTAX
    Set-PhilipsHue [-LightName] <string> [[-Color] {red | orange | yellow | chartreuse | electric green | spring green 
    | aqua | azure | blue | violet | fuchsia | bright pink}] [[-Brightness] <int>] [[-Effect] {none | colorloop}] 
    [[-PowerState] {On | Off}] [[-Saturation] <int>]  [<CommonParameters>]
    
    
PARAMETERS
    -Brightness <int>
        
        Required?                    false
        Position?                    2
        Accept pipeline input?       false
        Parameter set name           (All)
        Aliases                      None
        Dynamic?                     false
        
    -Color <string>
        
        Required?                    false
        Position?                    1
        Accept pipeline input?       false
        Parameter set name           (All)
        Aliases                      None
        Dynamic?                     false
        
    -Effect <string>
        
        Required?                    false
        Position?                    3
        Accept pipeline input?       false
        Parameter set name           (All)
        Aliases                      None
        Dynamic?                     false
        
    -LightName <string>
        
        Required?                    true
        Position?                    0
        Accept pipeline input?       false
        Parameter set name           (All)
        Aliases                      None
        Dynamic?                     false
        
    -PowerState <string>
        
        Required?                    false
        Position?                    4
        Accept pipeline input?       false
        Parameter set name           (All)
        Aliases                      None
        Dynamic?                     false
        
    -Saturation <int>
        
        Required?                    false
        Position?                    5
        Accept pipeline input?       false
        Parameter set name           (All)
        Aliases                      None
        Dynamic?                     false
        
    <CommonParameters>
        This cmdlet supports the common parameters: Verbose, Debug,
        ErrorAction, ErrorVariable, WarningAction, WarningVariable,
        OutBuffer, PipelineVariable, and OutVariable. For more information, see 
        about_CommonParameters (https:/go.microsoft.com/fwlink/?LinkID=113216). 
    
    
INPUTS
    None
    
    
OUTPUTS
    System.Object
    
ALIASES
    None
    

REMARKS
    None
```  
