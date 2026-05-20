package com.fct.mqttmaven;

import java.io.IOException;
import java.net.URI;
import java.net.URLEncoder;
import java.net.http.HttpClient;
import java.net.http.HttpRequest;
import java.net.http.HttpResponse;
import java.nio.charset.StandardCharsets;

import org.eclipse.paho.client.mqttv3.MqttClient;
import org.eclipse.paho.client.mqttv3.MqttMessage;

public class MqttBridgeStart {

    private static final String MQTT_BROKER = "tcp://localhost:1883";
    private static final String PROLOG_SERVER = "http://localhost:8001";

    private static final HttpClient HTTP_CLIENT = HttpClient.newHttpClient();

    public static void main(String[] args) {

        System.out.println("Welcome to the MqttBridge");

        MqttClient subscriber = MqttSubscriber.createSubscriber(MQTT_BROKER);

        if (subscriber != null) {
            System.out.println("Subscriber is running...");
        } else {
            System.out.println("Failed to start subscriber.");
        }
    }

    // ************************************************************
    // MQTT METHODS
    // ************************************************************

    public static void messageReceived(String topic, MqttMessage message) {

        String value = message.toString();

        System.out.println("Message arrived. Topic: " + topic + " Message: " + value);

        callPrologHttpService(topic, value);
    }

    // ************************************************************
    // HTTP METHODS
    // ************************************************************

    private static void callPrologHttpService(String topic, String value) {

        try {
            String encodedTopic = encode(topic);
            String encodedValue = encode(value);

            String url = PROLOG_SERVER
                    + "/mqtt?topic=" + encodedTopic
                    + "&value=" + encodedValue;

            HttpRequest request = HttpRequest.newBuilder()
                    .uri(URI.create(url))
                    .GET()
                    .build();

            HttpResponse<String> response = HTTP_CLIENT.send(
                    request,
                    HttpResponse.BodyHandlers.ofString()
            );

            if (response.statusCode() >= 200 && response.statusCode() < 300) {
                System.out.println("Prolog updated successfully:");
                System.out.println(response.body());
            } else {
                System.out.println("Failed to update Prolog.");
                System.out.println("HTTP status: " + response.statusCode());
                System.out.println("Response: " + response.body());
            }

        } catch (IOException e) {
            System.out.println("HTTP error while calling Prolog:");
            System.out.println(e.getMessage());

        } catch (InterruptedException e) {
            Thread.currentThread().interrupt();
            System.out.println("HTTP call interrupted:");
            System.out.println(e.getMessage());

        } catch (Exception e) {
            System.out.println("Unexpected error while calling Prolog:");
            System.out.println(e.getMessage());
        }
    }

    private static String encode(String value) {
        return URLEncoder.encode(value, StandardCharsets.UTF_8);
    }
}