#!/usr/bin/env python3


from PIL import Image
import os
import argparse


def rescale_images(directory, size):
    for img in os.listdir(directory):
        im = Image.open(directory+img)
        im_resized = im.resize(size, Image.ANTIALIAS)
        im_resized.save(directory+img)

def get_args():
    parser = argparse.ArgumentParser(description="Rescale images")
    parser.add_argument('-d', '--directory', type=str, required=True, help='Directory containing the images')
    parser.add_argument('-s', '--size', type=int, nargs=2, required=True, metavar=('width', 'height'), help='Image size')

    return parser.parse_args()
 

def main():
    args = get_args()
    rescale_images(args.directory, args.size)

if __name__ == "__main__":main()
