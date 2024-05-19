import os
import subprocess

from pathlib import Path

from flask import Flask, request, send_file

RECEIVED_FILES_DIR = os.getenv("RECEIVED_FILES_DIR", "received_files")

app = Flask(__name__)


def build_drawio_cmd(filepath):
    cmd_list = []

    drawio_exec_path = os.getenv("DRAWIO_DESKTOP_EXECUTABLE_PATH")
    drawio_exec_args = os.getenv("DRAWIO_DESKTOP_EXECUTABLE_ARGS").split()
    svg_path = filepath.with_suffix(".svg")

    cmd_list.extend(
        [
            drawio_exec_path,
            str(filepath),
            "-x",
            "-f",
            "svg",
            #    "--scale",
            #    "2.5",
            "-o",
            str(svg_path),
        ]
    )

    cmd_list.extend(drawio_exec_args)

    return cmd_list


@app.post("/convert-vsdx")
def convert_vsdx():
    filename = "temp.vsdx"
    filepath = Path(RECEIVED_FILES_DIR) / filename
    with open(filepath, "wb") as f:
        f.write(request.data)
    drawio_cmd = build_drawio_cmd(filepath)
    subprocess.run(drawio_cmd, capture_output=True, text=True)
    return send_file(filepath.with_suffix(".svg"))
