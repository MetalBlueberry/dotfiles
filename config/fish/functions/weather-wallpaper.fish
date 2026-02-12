function weather-wallpaper --description "Set wallpaper based on season and weather"
    set -l images_dir ~/Pictures

    # Determine season from current month
    set -l month (date +%m | string trim -l -c 0)
    set -l season winter
    if test $month -ge 3 -a $month -le 5
        set season spring
    else if test $month -ge 6 -a $month -le 8
        set season summer
    else if test $month -ge 9 -a $month -le 11
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

    echo "Season: $season | Weather code: $weather_code | Wind: $wind_speed km/h"

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

    echo "Setting wallpaper: $wallpaper"

    gsettings set org.gnome.desktop.background picture-uri "file://$wallpaper"
    gsettings set org.gnome.desktop.background picture-options zoom
end
