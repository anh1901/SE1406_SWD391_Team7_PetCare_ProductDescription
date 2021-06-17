package com.anh.demo;

import androidx.appcompat.app.AppCompatActivity;

import android.content.Intent;
import android.os.Bundle;
import android.view.View;

public class MainActivity extends AppCompatActivity {

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_main);
    }

    public void clickToSensor(View view) {
        Intent intent = new Intent(this,MySensorActivity.class);
        startActivity(intent);
    }

    public void clickToBluetooth(View view) {
        Intent intent = new Intent(this,MyBluetoothActivity.class);
        startActivity(intent);
    }
}