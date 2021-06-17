package com.anh.demo;

import androidx.appcompat.app.AppCompatActivity;

import android.content.Context;
import android.hardware.Sensor;
import android.hardware.SensorEvent;
import android.hardware.SensorEventListener;
import android.hardware.SensorManager;
import android.os.Bundle;
import android.widget.TextView;

public class MyPressActivity extends AppCompatActivity implements SensorEventListener {
    private SensorManager manager;
    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_my_press);
        manager=(SensorManager) getSystemService(Context.SENSOR_SERVICE);
    }

    @Override
    public void onSensorChanged(SensorEvent event) {
        TextView txtValue = findViewById(R.id.txtValue);
        float[] value =event.values;
        txtValue.setText(value[0]+"");
    }

    @Override
    public void onAccuracyChanged(Sensor sensor, int accuracy) {

    }
    @Override
    protected void onResume() {
        super.onResume();
        Sensor sensor=manager.getDefaultSensor(Sensor.TYPE_PRESSURE);
        manager.registerListener(this,sensor,SensorManager.SENSOR_DELAY_UI);
    }
    @Override
    protected void onPause() {
        super.onPause();
        manager.unregisterListener(this);
    }
}