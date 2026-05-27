import paho.mqtt.client as mqtt_client
import requests

BROKER_ADDRESS = "127.0.0.1"
BROKER_PORT = 1883

PROLOG_URL = "http://localhost:8001/mqtt"


def send_to_prolog(topic, value):
    try:
        response = requests.get(
            PROLOG_URL,
            params={
                "topic": topic,
                "value": value
            },
            timeout=5
        )

        print(f"[PROLOG] {response.status_code} {response.text}")

    except Exception as e:
        print(f"[ERROR] Could not send to Prolog: {e}")


def on_connect(client, userdata, flags, rc, properties=None):
    if rc == 0:
        print("[MQTT] Connected to MQTT Broker!")

        # Tópicos antigos / específicos
        client.subscribe("drone1/#")
        client.subscribe("ugv1/#")
        client.subscribe("ac1/#")

        print("[MQTT] Subscribed to drone1/#")
        print("[MQTT] Subscribed to ugv1/#")
        print("[MQTT] Subscribed to ac1/#")

        # Tópicos usados pelo simulador Python: robot1/... até robot15/...
        for robot_id in range(1, 16):
            topic_filter = f"robot{robot_id}/#"
            client.subscribe(topic_filter)
            print(f"[MQTT] Subscribed to {topic_filter}")

        print("[MQTT] All subscriptions active.")

    else:
        print(f"[MQTT] Failed to connect, return code {rc}")


def on_message(client, userdata, msg):
    topic = msg.topic
    value = msg.payload.decode("utf-8")

    print(f"[MQTT] Received: {topic} = {value}")

    send_to_prolog(topic, value)


def run():
    client = mqtt_client.Client()

    client.on_connect = on_connect
    client.on_message = on_message

    client.connect(BROKER_ADDRESS, BROKER_PORT)
    client.loop_forever()


if __name__ == "__main__":
    run()