package com.anh.demo;

import androidx.appcompat.app.AppCompatActivity;

import android.content.Context;
import android.hardware.Sensor;
import android.hardware.SensorManager;
import android.os.Bundle;
import android.widget.TextView;

import java.util.List;

public class ListSensorActivity extends AppCompatActivity {

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_list_sensors);
        TextView txt =(TextView) findViewById(R.id.txtSensors);
        SensorManager manager =(SensorManager) getSystemService(Context.SENSOR_SERVICE);
        List<Sensor> list=manager.getSensorList(Sensor.TYPE_ALL);
        StringBuilder data=new StringBuilder();
        for(Sensor sensor : list){
            data.append("+ Name: "+ sensor.getName()+"\n");
            data.append("\t- Vendor: "+ sensor.getVendor()+"\n");
            data.append("\t- Name: "+ sensor.getVersion()+"\n");
        }
        txt.setText(data);
    }
}