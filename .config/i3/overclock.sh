#!/bin/bash

# TODO: overclock only high performance levels
nvidia-settings -a GPUGraphicsClockOffsetAllPerformanceLevels=155
nvidia-settings -a GPUMemoryTransferRateOffsetAllPerformanceLevels=2500
