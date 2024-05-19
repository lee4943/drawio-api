FROM python:3.11.9-bookworm

WORKDIR "/opt/drawio-api"

# Draw.io setup
ENV DRAWIO_VERSION "24.2.5"

RUN apt-get update \
 && apt-get install -y xvfb wget libgbm1 libasound2 \
 && wget -q https://github.com/jgraph/drawio-desktop/releases/download/v${DRAWIO_VERSION}/drawio-amd64-${DRAWIO_VERSION}.deb \
 && apt-get install -y /opt/drawio-api/drawio-amd64-${DRAWIO_VERSION}.deb \
 && rm -rf /opt/drawio-api/drawio-amd64-${DRAWIO_VERSION}.deb \
 && apt-get install -y fonts-liberation \
  fonts-arphic-ukai fonts-arphic-uming \
  fonts-noto fonts-noto-cjk \
  fonts-ipafont-mincho fonts-ipafont-gothic \
  fonts-unfonts-core \
 && apt-get remove -y wget \
 && rm -rf /var/lib/apt/lists/* \
 && chmod a+w .

ENV ELECTRON_DISABLE_SECURITY_WARNINGS "true"
ENV DRAWIO_DESKTOP_EXECUTABLE_PATH "/opt/drawio/drawio"
ENV DRAWIO_DESKTOP_EXECUTABLE_ARGS "--no-sandbox --disable-gpu"
ENV XVFB_DISPLAY ":42"
ENV DISPLAY ":42"
ENV XVFB_OPTIONS "-nolisten unix"
ENV ELECTRON_ENABLE_LOGGING "false"

# Python API setup
COPY requirements.txt app.py wrapper.sh /opt/drawio-api

ENV RECEIVED_FILES_DIR received_files

RUN mkdir ${RECEIVED_FILES_DIR} \
 && pip install -r requirements.txt

CMD ["./wrapper.sh"]