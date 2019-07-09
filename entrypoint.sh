#!/usr/bin/env bash

augment_data() {
  python augment/augment_images.py \
  --image_dir=data/usa/farmer_market \
  --num_samples=${1}
}

retrain_model() {
  python -m train.retrain \
  --bottleneck_dir=train_output/bottlenecks \
  --how_many_training_steps=${1} \
  --model_dir=train_output/models/ \
  --summaries_dir=train_output/training_summaries/${ARCHITECTURE} \
  --output_graph=train_output/retrained_graph.pb \
  --output_labels=train_output/retrained_labels.txt \
  --architecture=${ARCHITECTURE} \
  --image_dir=augment-data/usa/farmer_market
}

cd ${WORKPATH}

if [ "$NUM_SAMPLE" == "" ]; then
  SAMPLE=8000
else
  SAMPLE=${NUM_SAMPLE}
fi

if [ "$TRAING_STEPS" == "" ]; then
  STEPS=500
else
  STEPS=${TRAING_STEPS}
fi

echo "************************************"
echo "The number of NUM_SAMPLE is $SAMPLE"
echo "Start running Augment"
echo "************************************"
augment_data ${SAMPLE}

echo "************************************"
echo "The number of TRAING_STEPS is $STEPS"
echo "Start running Retrain"
echo "************************************"
retrain_model ${STEPS}
