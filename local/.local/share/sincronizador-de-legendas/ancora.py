import sys
import math
from faster_whisper import WhisperModel

def formata_tempo(s):
    h = math.floor(s / 3600)
    m = math.floor((s % 3600) / 60)
    sec = math.floor(s % 60)
    ms = round((s - math.floor(s)) * 1000)
    return f"{h:02d}:{m:02d}:{sec:02d},{ms:03d}"

def main():
    if len(sys.argv) < 2:
        sys.exit(1)
        
    video = sys.argv[1]
    out_srt = video.rsplit('.', 1)[0] + ".en.srt"

    print(f"[*] Gerando âncora temporal para: {video}")
    # Modelo small: rápido, gasta pouca VRAM e serve perfeitamente de âncora
    modelo = WhisperModel("small", device="cuda", compute_type="float16")
    
    # Força o inglês e usa beam_size 1 para velocidade máxima
    segmentos, _ = modelo.transcribe(video, language="en", beam_size=1)

    with open(out_srt, "w", encoding="utf-8") as f:
        for i, seg in enumerate(segmentos, 1):
            f.write(f"{i}\n{formata_tempo(seg.start)} --> {formata_tempo(seg.end)}\n{seg.text.strip()}\n\n")

if __name__ == "__main__":
    main()
