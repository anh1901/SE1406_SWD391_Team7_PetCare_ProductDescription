package com.anh.demo;

import androidx.appcompat.app.AppCompatActivity;

import android.content.Context;
import android.hardware.Sensor;
import android.hardware.SensorEvent;
import android.hardware.SensorEventListener;
import android.hardware.SensorManager;
import android.os.Bundle;
import android.view.animation.Animation;
import android.view.animation.RotateAnimation;
import android.widget.ImageView;
import android.widget.TextView;

public class MyCompassActivity extends AppCompatActivity implements SensorEventListener {
    private ImageView imgCompass;
    private float currentDegrees=0f;
    private SensorManager manager;
    private TextView txtDegree;
    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_my_compass);
        imgCompass=(ImageView)findViewById(R.id.imgCompass);
        txtDegree=(TextView)findViewById(R.id.txtDegree);
        manager=(SensorManager) getSystemService(Context.SENSOR_SERVICE);
    }

    @Override
    public void onSensorChanged(SensorEvent event) {
        float degree=Math.round(event.values[0]);
        txtDegree.setText("Heading: "+Float.toString(degree)+" degrees");
        RotateAnimation ra=new RotateAnimation(currentDegrees,-degree, Animation.RELATIVE_TO_SELF,0.5f,Animation.RELATIVE_TO_SELF,0.5f);
        ra.setDuration(210);
        ra.setFillAfter(true);
        imgCompass.startAnimation(ra);
        currentDegrees=-degree;
    }
    @Override
    protected void onResume() {
        super.onResume();
        Sensor sensor=manager.getDefaultSensor(Sensor.TYPE_ORIENTATION);
        manager.registerListener(this,sensor,SensorManager.SENSOR_DELAY_GAME);
    }
    @Override
    protected void onPause() {
        super.onPause();
        manager.unregisterListener(this);
    }

    @Override
    public void onAccuracyChanged(Sensor sensor, int accuracy) {

    }

}