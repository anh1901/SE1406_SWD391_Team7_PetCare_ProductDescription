package com.anh.demo;

import androidx.appcompat.app.AppCompatActivity;

import android.content.Context;
import android.hardware.Sensor;
import android.hardware.SensorEvent;
import android.hardware.SensorEventListener;
import android.hardware.SensorManager;
import android.os.Bundle;
import android.view.View;
import android.widget.ImageView;
import android.widget.TextView;

public class MyAccelActivity extends AppCompatActivity implements SensorEventListener {
    private float mLastX;
    private float mLastY;
    private float mLastZ;
    private boolean bInit;
    private SensorManager manager;
    private Sensor accelerometer;
    private final float NOISE=2.0f;
    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_my_accel);
        bInit = false;
        manager =(SensorManager) getSystemService(Context.SENSOR_SERVICE);
        accelerometer=manager.getDefaultSensor(Sensor.TYPE_ACCELEROMETER);    }

    @Override
    public void onSensorChanged(SensorEvent event) {
        TextView txtX=(TextView) findViewById(R.id.txtXAxis);
        TextView txtY=(TextView) findViewById(R.id.txtYAxis);
        TextView txtZ=(TextView) findViewById(R.id.txtZAxis);
        ImageView img=(ImageView) findViewById(R.id.imageDirection);
        float x=event.values[0];
        float y=event.values[1];
        float z=event.values[2];
        if(!bInit){
            mLastX=x;
            mLastY=y;
            mLastZ=z;
            txtX.setText("0.0");
            txtY.setText("0.0");
            txtZ.setText("0.0");
            bInit=true;
        }else{
            float deltaX=mLastX-x;
            float deltaY=mLastY-y;
            float deltaZ=mLastZ-z;
//            deltaX=(deltaX<NOISE)?0.0f:deltaX;
//            deltaY=(deltaY<NOISE)?0.0f:deltaY;
//            deltaZ=(deltaZ<NOISE)?0.0f:deltaZ;
            mLastX=x;
            mLastY=y;
            mLastZ=z;
            txtX.setText(deltaX+"");
            txtY.setText(deltaY+"");
            txtZ.setText(deltaZ+"");
            img.setVisibility(View.VISIBLE);
            if(deltaX>deltaY){
                img.setImageResource(R.drawable.ic_launcher_background);
            }else if(deltaY>deltaX){
                img.setImageResource(R.drawable.ic_launcher_foreground);
            }else{
                img.setVisibility(View.INVISIBLE);
            }
        }
    }

    @Override
    public void onAccuracyChanged(Sensor sensor, int accuracy) {

    }
    @Override
    protected void onResume() {
        super.onResume();
        Sensor sensor=manager.getDefaultSensor(Sensor.TYPE_ORIENTATION);
        manager.registerListener(this,accelerometer,SensorManager.SENSOR_DELAY_NORMAL);
    }
    @Override
    protected void onPause() {
        super.onPause();
        manager.unregisterListener(this);
    }
}