#!/bin/bash

unset ROS_DISTRO
source "/opt/ros/noetic/setup.bash" --

unset ROS_DISTRO
. /opt/ros/foxy/setup.bash
. install/setup.bash

if [[ ! -f "/woeden/config" ]]; then
    echo "We were unable to identify your robot. Did you run the setup script provided at https://woeden.com/?"
    exit 1
fi
mkdir -p /woeden/bags

ros2 run woeden_agent woeden_agent &
ros2 run woeden_agent trigger_worker.py &
ros2 run woeden_agent upload_worker.py &
ros2 run ros1_bridge dynamic_bridge --bridge-all-topics
