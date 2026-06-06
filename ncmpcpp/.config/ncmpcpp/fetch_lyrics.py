#!/usr/bin/env python3
# ~/.config/ncmpcpp/fetch_lyrics.py
# 从网易云音乐 API 下载歌词，供 ncmpcpp 使用

import requests
import subprocess
import os
import sys
import re

LYRICS_DIR = os.path.expanduser("~/Music/.lyrics")
os.makedirs(LYRICS_DIR, exist_ok=True)

def get_current_song():
    """获取当前播放的歌曲信息"""
    try:
        artist = subprocess.check_output(
            ["mpc", "current", "-f", "%artist%"],
            stderr=subprocess.DEVNULL
        ).decode().strip()
        title = subprocess.check_output(
            ["mpc", "current", "-f", "%title%"],
            stderr=subprocess.DEVNULL
        ).decode().strip()
        return artist, title
    except:
        return None, None

def search_song(artist, title):
    """在网易云搜索歌曲"""
    try:
        query = f"{artist} {title}"
        url = "https://music.163.com/api/search/get"
        params = {
            "s": query,
            "type": 1,
            "limit": 5,
            "offset": 0
        }
        headers = {
            "User-Agent": "Mozilla/5.0",
            "Referer": "https://music.163.com"
        }
        resp = requests.get(url, params=params, headers=headers, timeout=10)
        data = resp.json()
        songs = data.get("result", {}).get("songs", [])
        if not songs:
            return None
        # 返回第一个匹配结果的 id
        return songs[0]["id"]
    except:
        return None

def get_lyrics(song_id):
    """获取歌词"""
    try:
        url = f"https://music.163.com/api/song/lyric"
        params = {
            "id": song_id,
            "lv": 1,
            "kv": 1,
            "tv": -1
        }
        headers = {
            "User-Agent": "Mozilla/5.0",
            "Referer": "https://music.163.com"
        }
        resp = requests.get(url, params=params, headers=headers, timeout=10)
        data = resp.json()
        lrc = data.get("lrc", {}).get("lyric", "")
        return lrc
    except:
        return None

def save_lyrics(artist, title, lyrics):
    """保存歌词到文件"""
    # 清理文件名中的非法字符
    safe_name = re.sub(r'[/\\:*?"<>|]', '_', f"{artist} - {title}")
    filepath = os.path.join(LYRICS_DIR, f"{safe_name}.lrc")
    with open(filepath, "w", encoding="utf-8") as f:
        f.write(lyrics)
    return filepath

def get_lyrics_path(artist, title):
    """检查歌词文件是否已存在"""
    safe_name = re.sub(r'[/\\:*?"<>|]', '_', f"{artist} - {title}")
    filepath = os.path.join(LYRICS_DIR, f"{safe_name}.lrc")
    return filepath if os.path.exists(filepath) else None

def main():
    artist, title = get_current_song()
    if not artist or not title:
        sys.exit(0)

    # 已有歌词则跳过
    if get_lyrics_path(artist, title):
        sys.exit(0)

    # 搜索并下载
    song_id = search_song(artist, title)
    if not song_id:
        sys.exit(0)

    lyrics = get_lyrics(song_id)
    if not lyrics or len(lyrics.strip()) < 10:
        sys.exit(0)

    save_lyrics(artist, title, lyrics)

if __name__ == "__main__":
    main()
