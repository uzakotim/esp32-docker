FROM espressif/idf:release-v5.5

WORKDIR /project

COPY . /project

CMD ["bash"]
