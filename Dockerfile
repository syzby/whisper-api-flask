FROM python:3.10-slim

WORKDIR /python-docker

COPY requirements.txt requirements.txt
RUN sed -i 's/deb.debian.org/mirrors.tuna.tsinghua.edu.cn/g' /etc/apt/sources.list \
    && sed -i 's/security.debian.org/mirrors.tuna.tsinghua.edu.cn/g' /etc/apt/sources.list \
    && apt-get update && apt-get install git -y
RUN pip3 install -r requirements.txt -i https://pypi.tuna.tsinghua.edu.cn/simple
RUN pip3 install "git+https://github.com/openai/whisper.git" -i https://pypi.tuna.tsinghua.edu.cn/simple
RUN apt-get install -y ffmpeg

COPY . .

EXPOSE 5000

CMD [ "python3", "-m" , "flask", "run", "--host=0.0.0.0"]