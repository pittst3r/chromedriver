FROM debian

RUN apt-get update -y && apt-get install -y \
    apt-transport-https \
    curl \
    unzip \
    gnupg \
    hicolor-icon-theme \
    libcanberra-gtk* \
    libgl1-mesa-dri \
    libgl1-mesa-glx \
    libpangox-1.0-0 \
    libpulse0 \
    libv4l-0 \
    fonts-symbola

RUN curl -sSL https://dl.google.com/linux/linux_signing_key.pub | apt-key add - \
    && echo "deb [arch=amd64] https://dl.google.com/linux/chrome/deb/ stable main" > /etc/apt/sources.list.d/google.list \
    && apt-get update && apt-get install -y \
    google-chrome-stable

COPY local.conf /etc/fonts/local.conf

RUN mkdir -p /home/chrome/{data,bin}

RUN FULL_VERSION=$(curl https://chromedriver.storage.googleapis.com/LATEST_RELEASE) \
    && curl --output /home/chrome/chromedriver.zip https://chromedriver.storage.googleapis.com/$FULL_VERSION/chromedriver_linux64.zip \
    && unzip -d /home/chrome/bin /home/chrome/chromedriver.zip \
    && rm /home/chrome/chromedriver.zip

RUN groupadd -r chrome \
    && useradd -r -g chrome -G audio,video chrome \
    && chown -R chrome:chrome /home/chrome

ENV PATH=/home/chrome/bin:${PATH}

VOLUME /home/chrome/data
USER chrome

ENTRYPOINT [ "chromedriver" ]
CMD [ "--port=4567", "--whitelisted-ips" ]
