#!/system/bin/sh

echo "[image-configurator] start";
SD_CARD=$(ls /mnt/media_rw);
if [[ SD_CARD ]]; then 

    IMAGE_CHANGER=$(opkg list-installed | grep "image-changer" > /dev/null; echo $?);
    echo "[image-configurator] SD card found: $SD_CARD"; 

    if [[ -f "/mnt/media_rw/$SD_CARD/screensaver01.png" ]]; then
        echo "[image-configurator] screensaver01.png found on SD card";
        
        ffmpeg -i "/mnt/media_rw/$SD_CARD/screensaver01.png" -vf "scale=1440:810" -pix_fmt bgra "/tmp/screensaver01.rgb" &&
        mv /tmp/screensaver01.rgb /data/screensaver01.data

        echo "[image-configurator] screensaver01.png converted to screensaver01.data";

        if [[ $IMAGE_CHANGER -eq 0 ]]; then
            draw_to_screensaver 1 /data/screensaver01.data
        fi

        mv "/mnt/media_rw/$SD_CARD/screensaver01.png" "/mnt/media_rw/$SD_CARD/screensaver01.png.ok"

    fi

    if [[ -f "/mnt/media_rw/$SD_CARD/screensaver02.png" ]]; then
        echo "[image-configurator] screensaver02.png found on SD card";
        
        ffmpeg -i "/mnt/media_rw/$SD_CARD/screensaver02.png" -vf "scale=1440:810" -pix_fmt bgra "/tmp/screensaver02.rgb" &&
        mv /tmp/screensaver02.rgb /data/screensaver02.data

        echo "[image-configurator] screensaver02.png converted to screensaver02.data";

        if [[ $IMAGE_CHANGER -eq 0 ]]; then
            draw_to_screensaver 2 /data/screensaver02.data
        fi

        mv "/mnt/media_rw/$SD_CARD/screensaver02.png" "/mnt/media_rw/$SD_CARD/screensaver02.png.ok"

    fi

    if [[ -f "/mnt/media_rw/$SD_CARD/splashscreen.png" ]]; then
        echo "[image-configurator] splashscreen.png found on SD card";

        ffmpeg -i "/mnt/media_rw/$SD_CARD/splashscreen.png" -vf "scale=1440:810,pad=w=1536:h=810:x=0:y=0:color=black" -pix_fmt nv12 "/tmp/splashscreen.yuv" &&
        mv /tmp/splashscreen.yuv /data/splashscreen.yuv; 

        echo "[image-configurator] splashscreen.png converted to splashscreen.yuv";

        if [[ $IMAGE_CHANGER -eq 0 ]]; then
            draw_to_splash /data/splashscreen.yuv
        fi

        mv "/mnt/media_rw/$SD_CARD/splashscreen.png" "/mnt/media_rw/$SD_CARD/splashscreen.png.ok"

    fi

    if [[ -f "/mnt/media_rw/$SD_CARD/splashscreen.delete" ]]; then
        echo "[image-configurator] splashscreen.delete found on SD card";

        rm /data/splashscreen.yuv
        mv "/mnt/media_rw/$SD_CARD/splashscreen.delete" "/mnt/media_rw/$SD_CARD/splashscreen.delete.ok"
    fi

    if [[ -f "/mnt/media_rw/$SD_CARD/screensaver01.delete" ]]; then
        echo "[image-configurator] screensaver01.delete found on SD card";

        rm /data/screensaver01.data
        mv "/mnt/media_rw/$SD_CARD/screensaver01.delete" "/mnt/media_rw/$SD_CARD/screensaver01.delete.ok"
    fi

    if [[ -f "/mnt/media_rw/$SD_CARD/screensaver02.delete" ]]; then
        echo "[image-configurator] screensaver02.delete found on SD card";

        rm /data/screensaver02.data
        mv "/mnt/media_rw/$SD_CARD/screensaver02.delete" "/mnt/media_rw/$SD_CARD/screensaver02.delete.ok"
    fi

    echo "[image-configurator] SD scan functions complete";
fi

