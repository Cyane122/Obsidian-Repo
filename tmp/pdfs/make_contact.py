from pathlib import Path
from PIL import Image, ImageDraw
import sys


source = Path(sys.argv[1])
chunk_size = int(sys.argv[2])
files = sorted(source.glob("all-*.jpg"))

for chunk_index, start in enumerate(range(0, len(files), chunk_size), 1):
    selected = files[start : start + chunk_size]
    thumbs = []
    for path in selected:
        image = Image.open(path).convert("RGB")
        image.thumbnail((560, 315))
        canvas = Image.new("RGB", (580, 355), "white")
        canvas.paste(image, ((580 - image.width) // 2, 25))
        ImageDraw.Draw(canvas).text((10, 5), path.stem, fill="black")
        thumbs.append(canvas)

    rows = (len(thumbs) + 1) // 2
    sheet = Image.new("RGB", (1160, rows * 355), "#dddddd")
    for index, thumb in enumerate(thumbs):
        sheet.paste(thumb, ((index % 2) * 580, (index // 2) * 355))
    sheet.save(source / f"contact-{chunk_index}.jpg", quality=90)
