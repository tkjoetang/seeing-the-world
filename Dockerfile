FROM tensorflow/tensorflow
LABEL org.label-schema.schema-version="1.0" \
      org.label-schema.name="seeing-the-world" \
      org.label-schema.vcs-url="https://github.com/aiformankind/seeing-the-world"

ARG IMAGE_SIZE=224
ENV ARCHITECTURE="mobilenet_0.50_${IMAGE_SIZE}"
ENV TF_CPP_MIN_LOG_LEVEL=2
ENV NUM_SAMPLE=8000
ENV TRAING_STEPS=500
ENV IMAGE_DIR="usa/farmer_market"

WORKDIR /app
COPY requirements.txt .
RUN pip install -r requirements.txt
COPY . .

EXPOSE 8888 6006
VOLUME ["/app/data", "/app/train_output", "/app/augment-data"]
ENTRYPOINT ["bash", "entrypoint.sh", "augment_and_retain"]
