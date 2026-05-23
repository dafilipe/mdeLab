import paho.mqtt.client as mqtt_client
import requests

broker_address = "127.0.0.1"
port = 1883

prolog_url = "http://localhost:8001/mqtt"


def send_to_prolog(topic, value):
    try:
        response = requests.get(
            prolog_url,
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

        client.subscribe("drone1/#")
        client.subscribe("ugv1/#")
        client.subscribe("ac1/#")

        print("[MQTT] Subscribed to drone1/#, ugv1/#, ac1/#")
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

    client.connect(broker_address, port)
    client.loop_forever()


if __name__ == "__main__":
    run()