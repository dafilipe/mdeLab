import random
import time
import requests
import paho.mqtt.client as mqtt_client


BROKER_ADDRESS = "127.0.0.1"
BROKER_PORT = 1883

PROLOG_BASE_URL = "http://localhost:8001"

TICK_SECONDS = 3
NEW_ORDER_PROBABILITY = 0.25
ASSIGN_ORDER_PROBABILITY = 0.60


def connect_mqtt():
    def on_connect(client, userdata, flags, rc, *extra):
        if rc == 0:
            print("[MQTT] Connected to broker.")
        else:
            print(f"[MQTT] Connection failed with code {rc}")

    client = mqtt_client.Client()
    client.on_connect = on_connect
    client.connect(BROKER_ADDRESS, BROKER_PORT)
    return client


def http_get(endpoint, params=None):
    try:
        response = requests.get(
            f"{PROLOG_BASE_URL}{endpoint}",
            params=params,
            timeout=5
        )
        return response.json()
    except Exception as e:
        print(f"[HTTP ERROR] {endpoint}: {e}")
        return None


def mqtt_publish(client, topic, value):
    client.publish(topic, str(value))
    print(f"[MQTT] {topic} = {value}")


def create_random_order():
    destination = random.randint(9, 18)
    urgency = random.randint(1, 3)

    product_count = random.randint(1, 5)
    products = [random.randint(1, 6) for _ in range(product_count)]
    products_text = ",".join(str(p) for p in products)

    result = http_get("/new_order", {
        "destination": destination,
        "urgency": urgency,
        "products": products_text
    })

    if result is not None:
        print(f"[PROLOG] New random order result: {result}")

    return result


def assign_random_pending_order():
    result = http_get("/assign_random_pending")

    if result is not None:
        print(f"[PROLOG] Assignment result: {result}")

    return result


def get_robot_status(robot_id):
    return http_get("/status", {"id": robot_id})


def get_robot_route(robot_id):
    return http_get("/route_for_robot", {"id": robot_id})


def finish_order(order_id):
    result = http_get("/finish_order", {"order": order_id})

    if result is not None:
        print(f"[PROLOG] Finish order result: {result}")

    return result


def publish_robot_sensor_update(client, robot_id, node, battery, status, load_id):
    device = f"robot{robot_id}"

    mqtt_publish(client, f"{device}/current_node", node)
    mqtt_publish(client, f"{device}/battery", f"{battery:.2f}")
    mqtt_publish(client, f"{device}/status", status)
    mqtt_publish(client, f"{device}/load_id", load_id)


def simulate_robot_step(client, robot_id):
    status = get_robot_status(robot_id)

    if status is None or status.get("status") != "ok":
        return

    if status.get("mission_status") != "transporting":
        return

    battery = float(status.get("battery"))
    current_node = int(status.get("location"))
    load_id = status.get("load_id")

    route_result = get_robot_route(robot_id)

    if route_result is None or route_result.get("status") != "ok":
        return

    path = route_result.get("path", [])
    order_id = route_result.get("order_id")

    if not path:
        return

    first_step = path[0]

    next_node = first_step["to"]
    distance = float(first_step["distance"])

    battery_drop = random.uniform(0.5, 2.0) + distance * random.uniform(0.005, 0.02)
    new_battery = max(0.0, battery - battery_drop)

    print(
        f"[SIM] Robot {robot_id}: "
        f"{current_node} -> {next_node}, "
        f"battery {battery:.2f}% -> {new_battery:.2f}%"
    )

    if new_battery <= 2:
        publish_robot_sensor_update(
            client,
            robot_id,
            current_node,
            new_battery,
            "paused",
            load_id
        )
        return

    publish_robot_sensor_update(
        client,
        robot_id,
        next_node,
        new_battery,
        "transporting",
        load_id
    )

    if len(path) == 1:
        print(f"[SIM] Robot {robot_id} delivered order {order_id}")

        publish_robot_sensor_update(
            client,
            robot_id,
            next_node,
            new_battery,
            "idle",
            "none"
        )

        if order_id is not None:
            finish_order(order_id)


def run():
    client = connect_mqtt()
    client.loop_start()

    time.sleep(1)

    print("\n=== PROLOG-DRIVEN MQTT SIMULATOR ===")
    print("Python only generates events.")
    print("Prolog decides robots, routes and feasibility.")
    print("Press CTRL+C to stop.\n")

    try:
        while True:
            print("--------------------------------------------------")

            if random.random() < NEW_ORDER_PROBABILITY:
                create_random_order()

            if random.random() < ASSIGN_ORDER_PROBABILITY:
                assign_random_pending_order()

            for robot_id in range(1, 16):
                simulate_robot_step(client, robot_id)

            print("--------------------------------------------------\n")
            time.sleep(TICK_SECONDS)

    except KeyboardInterrupt:
        print("\nStopping simulator...")
        client.loop_stop()
        client.disconnect()
        print("Simulator stopped.")


if __name__ == "__main__":
    run()