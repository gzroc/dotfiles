#!/bin/bash
# ~/.config/ncmpcpp/album_art.sh
# 在 kitty 右下角显示专辑封面，不遮挡歌曲列表

COVER="/tmp/ncmpcpp_cover.png"
MUSIC_DIR="$HOME/Music"
SIZE="200x200"

# 清除上一张封面
kitty +kitten icat --clear --silent 2>/dev/null

# 获取当前播放文件路径
CURRENT=$(mpc current -f "%file%" 2>/dev/null)
[ -z "$CURRENT" ] && exit 0

DIR="$MUSIC_DIR/$(dirname "$CURRENT")"

# 查找目录里的封面图片
FOUND=""
for f in "$DIR/cover.jpg" "$DIR/cover.png" "$DIR/folder.jpg" \
          "$DIR/folder.png" "$DIR/Cover.jpg" "$DIR/front.jpg" \
          "$DIR/artwork.jpg" "$DIR/AlbumArt.jpg"; do
    if [ -f "$f" ]; then
        FOUND="$f"
        break
    fi
done

# 没找到则从音频文件提取内嵌封面
if [ -z "$FOUND" ]; then
    ffmpeg -i "$MUSIC_DIR/$CURRENT" -an -vf scale=200:200 \
           "$COVER" -y 2>/dev/null
    [ -f "$COVER" ] && FOUND="$COVER"
fi

# 显示封面（右下角，不遮挡列表区域）
if [ -n "$FOUND" ]; then
    convert "$FOUND" -resize "${SIZE}^" -gravity center \
            -extent "$SIZE" "$COVER" 2>/dev/null
    # place 参数：列数x行数@列偏移x行偏移
    # 根据终端大小放在右下角
    COLS=$(tput cols)
    ROWS=$(tput lines)
    POS_X=$((COLS - 26))
    POS_Y=$((ROWS - 13))
    kitty +kitten icat --silent --scale-up \
          --place "25x12@${POS_X}x${POS_Y}" "$COVER" 2>/dev/null
fi
