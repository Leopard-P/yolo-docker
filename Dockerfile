FROM ubuntu:20.04

RUN apt-get update && apt-get install -y \
    git wget build-essential \
    && rm -rf /var/lib/apt/lists/*

# Darknet 다운로드
RUN git clone https://github.com/pjreddie/darknet /darknet
WORKDIR /darknet

# 컴파일
RUN make

# YOLOv3 weights 다운로드
RUN wget https://data.pjreddie.com/files/yolov3.weights

# 컨테이너 실행 시 URL 입력 → 이미지 다운로드 → YOLOv3 실행
ENTRYPOINT ["bash", "-c", "wget -O input.jpg \"$1\" && ./darknet detector test cfg/coco.data cfg/yolov3.cfg yolov3.weights input.jpg -dont_show", "--"]
