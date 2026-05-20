package com.fct.mqttmaven;

import org.eclipse.paho.client.mqttv3.*;


public class MqttSubscriber {

    private static final String SUBSCRIBER_CLIENT_ID = "MDE_Subscriber";
    //private static final String SUBSCRIPTION_TOPIC = "charging_station+/+";


    static MqttClient createSubscriber(String broker){
        try {
            MqttClient client = new MqttClient(broker, SUBSCRIBER_CLIENT_ID);
            MqttConnectOptions connectionOptions = createConnectionOptions();
            
            client.setCallback(new MqttCallback() {
                @Override
                public void connectionLost(Throwable cause) {
                    System.out.println("Connection lost!");
                }

                @Override
                public void messageArrived(String topic, MqttMessage message) throws Exception {
                    MqttBridgeStart.messageReceived(topic, message);
                }

                @Override
                public void deliveryComplete(IMqttDeliveryToken iMqttDeliveryToken) {
                    // Not used for subscriber
                }

            });

            client.connect(connectionOptions);
            System.out.println("Connected to broker: " + broker);

            client.subscribe("drone1/battery");
            client.subscribe("drone1/latitude");
            client.subscribe("drone1/longitude");
            client.subscribe("ac1/battery");
            client.subscribe("ac1/available");
            client.subscribe("ugv1/battery");
            client.subscribe("ugv1/available");


            System.out.println("Subscribed to topic: drone1/battery");
            System.out.println("Subscribed to topic: drone1/latitude");
            System.out.println("Subscribed to topic: drone1/longitude");
            System.out.println("Subscribed to topic: ac1/battery");
            System.out.println("Subscribed to topic: ac1/available");
            System.out.println("Subscribed to topic: ugv1/battery");
            System.out.println("Subscribed to topic: ugv1/available");

            return client;

        } catch (MqttException me) {
            System.out.println("reason " + me.getReasonCode());
            System.out.println("msg " + me.getMessage());
            System.out.println("loc " + me.getLocalizedMessage());
            System.out.println("cause " + me.getCause());
            System.out.println("excep " + me);
            me.printStackTrace();
            return null;
        }
    }

    private static MqttConnectOptions createConnectionOptions() {
        MqttConnectOptions connectionOptions = new MqttConnectOptions();
        connectionOptions.setCleanSession(true);
        return connectionOptions;
    }

}
