#!/bin/bash

#PBS -W group_list=bhurwitz
#PBS -q standard
#PBS -l select=1:ncpus=28:mem=224gb:np100s=1:os7=True
#PBS -l walltime=02:00:00
#PBS -l place=free:shared
#PBS -M aponsero@email.arizona.edu
#PBS -m bea

cd /rsgrps/bhurwitz/alise/tools/tensorflow/models/research
PYTHONPATH=$PYTHONPATH:`pwd`:`pwd`/slim


cd /rsgrps/bhurwitz/alise/temp/stream_sprint

source activate stream_sprint
# resize pictures
#python transform_image_resolution.py -d images/ -s 800 600
# convert xml into csv
python xml_to_csv.py
# convert in TFR
python generate_tfrecord.py --csv_input=images/train_labels.csv --image_dir=images/train --output_path=train.record
python generate_tfrecord.py --csv_input=images/test_labels.csv --image_dir=images/test --output_path=test.record

# train model
python model_main.py --logtostderr --model_dir=training/ --pipeline_config_path=training/faster_rcnn_inception_v2_test.config

