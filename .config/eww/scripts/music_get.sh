#!/bin/bash
# TODO: Clean up + Optimize this script, it's a bit of a mess right now
PATH="$PATH:/home/fbartelt/eww/target/release"
# Initialize some variables
GLOBAL_STATUS=$(playerctl --player=spotify,firefox status 2>/dev/null || echo "~")
TITLE="~"
ARTIST=""
POSITION="0"
LENGTH="0"
ART_URL=""
# Function to get player info
get_player_info() {
    local player=$1
    local prefix=$2
    
    STATUS=$(playerctl --player=$player status 2>/dev/null)
    
    if [ $? -eq 0 ] && [ "$STATUS" != "" ]; then
        TITLE=$(playerctl --player=$player metadata --format "{{title}}" 2>/dev/null || echo "No track")
        ARTIST=$(playerctl --player=$player metadata --format "{{artist}}" 2>/dev/null || echo "Unknown artist")
        POSITION=$(playerctl --player=$player metadata --format '{{position}}' 2>/dev/null || echo "0")
        LENGTH=$(playerctl --player=$player metadata --format '{{mpris:length}}' 2>/dev/null || echo "0")
        ART_URL=$(playerctl --player=$player metadata --format '{{mpris:artUrl}}' 2>/dev/null || echo "")

        # Calculate percentage
        if [ "$LENGTH" != "0" ] && [ "$POSITION" != "0" ]; then
            POS_PERCENT=$(awk -v pos="$POSITION" -v len="$LENGTH" 'BEGIN {print (pos/len)*100}')
        else
            POS_PERCENT="0"
        fi
        
        # Update eww variables
        eww update "${prefix}_status"="$STATUS"
        eww update "${prefix}_title"="$TITLE"
        eww update "${prefix}_artist"="$ARTIST"
        eww update "${prefix}_position"="$POS_PERCENT"
        eww update "${prefix}_art"="$ART_URL"
    else
        # Player not active
        eww update "${prefix}_status"=""
        eww update "${prefix}_title"=""
        eww update "${prefix}_artist"=""
        eww update "${prefix}_position"="0"
        eww update "${prefix}_art"=""
    fi
}

# Get info for both players
get_player_info "firefox" "firefox"
get_player_info "spotify" "spotify"

# Determine which player to show in status bar (Spotify priority)
spotify_status=$(eww get spotify_status)
spotify_title=$(eww get spotify_title)
spotify_artist=$(eww get spotify_artist)
spotify_position=$(eww get spotify_position)
spotify_art=$(eww get spotify_art)
firefox_status=$(eww get firefox_status)
firefox_title=$(eww get firefox_title)
firefox_artist=$(eww get firefox_artist)
firefox_position=$(eww get firefox_position)
firefox_art=$(eww get firefox_art)

if [ "$spotify_status" = "Playing" ] || [ "$spotify_status" = "Paused" ]; then
    eww update songtitle="$spotify_title"
    eww update songartist="$spotify_artist"
    eww update songpos="$spotify_position"
    eww update cover_art="$spotify_art"
    eww update song_status="$spotify_status"
    # eww update active_player="spotify"
elif [ "$firefox_status" = "Playing" ] || [ "$firefox_status" = "Paused" ]; then
    eww update songtitle="$firefox_title"
    eww update songartist="$firefox_artist"
    eww update songpos="$firefox_position"
    eww update cover_art="$firefox_art"
    eww update song_status="$firefox_status"
    # eww update active_player="firefox"
else
    eww update songtitle="No media playing"
    eww update songartist=""
    eww update songpos="0"
    eww update cover_art=""
    eww update song_status="Stopped"
    # eww update active_player="none"
fi

if [ "$1" == "--status" ]; then
    echo "$GLOBAL_STATUS"
else
    if [ "$GLOBAL_STATUS" = "Stopped" ] || [ "$GLOBAL_STATUS" = "Inactive" ]; then
        echo "No music is playing"
    elif [ "$GLOBAL_STATUS" = "Paused" ]; then
        echo "$TITLE - $ARTIST"
    elif [ "$GLOBAL_STATUS" = "~" ]; then
        echo ""
    else
        echo "$TITLE - $ARTIST"
    fi
fi
