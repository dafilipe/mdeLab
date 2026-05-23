#!/bin/bash

BASE_DIR="/home/diogo/8SEM/mdeLab/Lab02"
HTTP_DIR="$BASE_DIR/http_server"

echo "A arrancar sistema Prolog + MQTT..."

gnome-terminal --title="PROLOG HTTP SERVER" -- bash -c "
cd '$BASE_DIR'
echo '=== PROLOG HTTP SERVER ==='
echo 'A carregar main.pl...'
swipl -s main.pl -g \"start_server(8001), writeln('HTTP server running on port 8001.')\"
exec bash
"

sleep 2

gnome-terminal --title="MQTT BRIDGE" -- bash -c "
cd '$HTTP_DIR'
echo '=== MQTT BRIDGE ==='
echo 'A ligar Mosquitto ao Prolog...'
python3 mqtt_bridge.py
exec bash
"

sleep 2

gnome-terminal --title="PYTHON SIMULATOR" -- bash -c "
cd '$HTTP_DIR'
echo '=== PYTHON RANDOM SIMULATOR ==='
echo 'A iniciar simulador Python...'
python3 mqtt_publisher_script.py
exec bash
"
