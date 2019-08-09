# Use an official tensorflow and latest stable release

FROM tensorflow/tensorflow

# Define environment variable
ENV IMAGE_SIZE=224
ENV ARCHITECTURE="mobilenet_0.50_${IMAGE_SIZE}"
ENV WORKPATH /seeing-the-world
ENV TF_CPP_MIN_LOG_LEVEL=2
ARG NUM_SAMPLE
ARG TRAING_STEPS
ENV NUM_SAMPLE=$NUM_SAMPLE
ENV TRAING_STEPS=$TRAING_STEPS

# Make port 8888 and 6006 available to the world outside this container
EXPOSE 8888 6006

# Install any needed software and python packages
RUN apt-get update \
  && apt-get install -y \
     wget \
     vim  \
  && rm -rf /var/lib/apt/lists/* \
  && pip install --upgrade pip \
  && pip install Augmentor

WORKDIR $WORKPATH
COPY . $WORKPATH

# Run bash when the container launches
ENTRYPOINT ["bash", "entrypoint.sh"]
