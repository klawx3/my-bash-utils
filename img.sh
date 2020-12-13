#!/bin/bash
# https://github.com/Ceryn/img
clientid="a6ad9d354cbac2f"
img_dir="/tmp/img_upload.png"
scrot "$img_dir" --line style=solid,width=1,color="red" --select -f -z
res=$(curl -s --location --request POST "https://api.imgur.com/3/image" --header "Authorization: Client-ID $clientid" -F "image=@$img_dir")
echo $res | grep -qo '"status":200' && link=$(echo $res | sed -e 's/.*"link":"\([^"]*\).*/\1/' -e 's/\\//g')
test -n "$link" && (echo $link | xclip -selection clipboard; rm "$img_dir"; notify-send "copy to clippboard: $link") || notify-send -u critical "error uploading: $res" ; rm "$img_dir"
