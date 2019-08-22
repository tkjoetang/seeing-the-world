#!/usr/bin/env bash
export NUM_SAMPLE=${NUM_SAMPLE:=8000}
export TRAING_STEPS=${TRAING_STEPS:=500}
export IMAGE_DIR=${IMAGE_DIR:=usa/farmer_market}

function augment_and_retain() {
  augment_data
  retrain_model
}

function augment_data() {
  echo "************************************"
  echo "The number of NUM_SAMPLE is $NUM_SAMPLE"
  echo "Start running Augment"
  echo "************************************"

  python augment/augment_images.py \
  --image_dir=data/${IMAGE_DIR} \
  --num_samples=${NUM_SAMPLE}
}

function retrain_model() {
  echo "************************************"
  echo "The number of TRAING_STEPS is $TRAING_STEPS"
  echo "Start running Retrain"
  echo "************************************"

  python -m train.retrain \
  --bottleneck_dir=train_output/bottlenecks \
  --how_many_training_steps=${TRAING_STEPS} \
  --model_dir=train_output/models/ \
  --summaries_dir=train_output/training_summaries/${ARCHITECTURE} \
  --output_graph=train_output/retrained_graph.pb \
  --output_labels=train_output/retrained_labels.txt \
  --architecture=${ARCHITECTURE} \
  --image_dir=augment-data/${IMAGE_DIR}
}

function predict_label() {
  python -m train.label_image \
  --graph=train_output/retrained_graph.pb \
  --image=validation/$1
}

cd /app

"$@"