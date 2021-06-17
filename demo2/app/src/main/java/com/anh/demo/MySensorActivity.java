package com.anh.demo;

import androidx.appcompat.app.AppCompatActivity;

import android.content.Intent;
import android.os.Bundle;
import android.view.View;

public class MySensorActivity extends AppCompatActivity {

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_my_sensor);
    }
    public void clickToListSensors(View view){
        Intent intent = new Intent(this,ListSensorActivity.class);
        startActivity(intent);
    }
    public void clickToBarometer(View view){
        Intent intent = new Intent(this,MyPressActivity.class);
        startActivity(intent);
    }
    public void clickToCompass(View view){
        Intent intent = new Intent(this,MyCompassActivity.class);
        startActivity(intent);
    }
    public void clickToAccelerometer(View view){
        Intent intent = new Intent(this,MyAccelActivity.class);
        startActivity(intent);
    }
}