function weather-wallpaper --description "Set wallpaper based on season and weather"
    set -l images_dir ~/Pictures

    # Determine season from current date (astronomical seasons, Northern Hemisphere)
    # Spring: ~Mar 20, Summer: ~Jun 21, Autumn: ~Sep 22, Winter: ~Dec 21
    set -l mmdd (date +%m%d)
    set -l season winter
    if test "$mmdd" -ge 0320 -a "$mmdd" -lt 0621
        set season spring
    else if test "$mmdd" -ge 0621 -a "$mmdd" -lt 0922
        set season summer
    else if test "$mmdd" -ge 0922 -a "$mmdd" -lt 1221
        set season autumn
    end

    # Fetch weather code from Open-Meteo (Burgos: 42.34, -3.70)
    set -l response (curl -s --max-time 5 "https://api.open-meteo.com/v1/forecast?latitude=42.34&longitude=-3.70&current=weather_code,wind_speed_10m")
    if test $status -ne 0
        echo "Failed to fetch weather, using default"
        set -l wallpaper $images_dir/$season.png
        echo $wallpaper
        return
    end

    set -l weather_code (echo $response | jq -r '.current.weather_code')
    set -l wind_speed (echo $response | jq -r '.current.wind_speed_10m')

    # WMO weather code descriptions
    set -l weather_desc "Unknown"
    switch $weather_code
        case 0;  set weather_desc "Clear sky"
        case 1;  set weather_desc "Mainly clear"
        case 2;  set weather_desc "Partly cloudy"
        case 3;  set weather_desc "Overcast"
        case 45; set weather_desc "Fog"
        case 48; set weather_desc "Depositing rime fog"
        case 51; set weather_desc "Light drizzle"
        case 53; set weather_desc "Moderate drizzle"
        case 55; set weather_desc "Dense drizzle"
        case 56; set weather_desc "Light freezing drizzle"
        case 57; set weather_desc "Dense freezing drizzle"
        case 61; set weather_desc "Slight rain"
        case 63; set weather_desc "Moderate rain"
        case 65; set weather_desc "Heavy rain"
        case 66; set weather_desc "Light freezing rain"
        case 67; set weather_desc "Heavy freezing rain"
        case 71; set weather_desc "Slight snowfall"
        case 73; set weather_desc "Moderate snowfall"
        case 75; set weather_desc "Heavy snowfall"
        case 77; set weather_desc "Snow grains"
        case 80; set weather_desc "Slight rain showers"
        case 81; set weather_desc "Moderate rain showers"
        case 82; set weather_desc "Violent rain showers"
        case 85; set weather_desc "Slight snow showers"
        case 86; set weather_desc "Heavy snow showers"
        case 95; set weather_desc "Thunderstorm"
        case 96; set weather_desc "Thunderstorm with slight hail"
        case 99; set weather_desc "Thunderstorm with heavy hail"
    end

    echo "Season: $season | Weather: $weather_desc ($weather_code) | Wind: $wind_speed km/h"

    # Determine variant from weather code
    set -l variant ""
    if test $weather_code -ge 71 -a $weather_code -le 77; or test $weather_code -ge 85 -a $weather_code -le 86
        set variant _snow
    else if test $weather_code -ge 51 -a $weather_code -le 67; or test $weather_code -ge 80 -a $weather_code -le 82; or test $weather_code -ge 95 -a $weather_code -le 99
        set variant _rainy
    else if test (math "floor($wind_speed)") -ge 30
        set variant _windy
    end

    # Fall back to default if variant image doesn't exist
    set -l wallpaper $images_dir/$season.png
    if test -n "$variant" -a -f $images_dir/$season$variant.png
        set wallpaper $images_dir/$season$variant.png
    end

    # Print selection table
    set -l entries \
        "$season.png"        default                    "0-48" \
        "$season""_rainy.png"  "rain/drizzle/thunderstorm"  "51-67,80-82,95-99" \
        "$season""_snow.png"   snow                       "71-77,85-86" \
        "$season""_windy.png"  "wind ≥30 km/h"            any
    printf "  %-24s %-30s %-20s\n" Image Condition Codes
    for i in (seq 1 3 (count $entries))
        set -l img $entries[$i]
        set -l cond $entries[(math $i + 1)]
        set -l codes $entries[(math $i + 2)]
        set -l mark ""
        if test $images_dir/$img = "$wallpaper"
            set mark "✓"
        end
        printf "  %-24s %-30s %-20s %s\n" $img $cond $codes $mark
    end

    gsettings set org.gnome.desktop.background picture-uri "file://$wallpaper"
    gsettings set org.gnome.desktop.background picture-options zoom
end
