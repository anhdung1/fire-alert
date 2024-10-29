package org.example;

import org.eclipse.paho.client.mqttv3.MqttClient;
import org.eclipse.paho.client.mqttv3.MqttConnectOptions;
import org.eclipse.paho.client.mqttv3.MqttException;

import java.util.Date;

public class MQTTReceiver {
    public void getData() {
        String broker = "tcp://127.0.0.1:1883";
        String clientId = "ClientExample";

        MqttClient mqttClient;
        try {


            mqttClient = new MqttClient(broker, clientId);
            MqttConnectOptions options = new MqttConnectOptions();
            options.setCleanSession(true);
            mqttClient.connect(options);

            mqttClient.subscribe("sensor/+/data", (topic, message) -> {
                String msg = new String(message.getPayload());
                Date date = new Date();
                System.out.println("Received: " + msg);
            });
        } catch (MqttException e) {
            e.printStackTrace();
        }
    }
}
